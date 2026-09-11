# AGENTS.md

This file provides guidance to coding agents when working with code in this repository.

## What this repository is

There is no application code here. The deliverable is a single data file — `resources/pgp-keys-map.list` — that maps Maven artifacts to the PGP keys allowed to sign them. It is packaged as the `org.simplify4u:pgp-keys-map` jar and consumed by
[pgpverify-maven-plugin](https://github.com/s4u/pgpverify-maven-plugin) via `<keysMapLocation>/pgp-keys-map.list</keysMapLocation>`.

Everything else in the repo exists to *test* that data file.

## Build and test

```bash
mvn verify                       # build the keys-map jar and verify every test module against it
mvn verify -pl pgp-keys-map-test1   # exercise a single test module
```

`test-not-used-keys.sh` is kept in the repo for historical purposes only — do not run it, and never act on its output. Keys are not removed from the map: an entry stays valid for every artifact version ever signed with that key, while the test modules only exercise a thin slice of the map — so the script reports almost every key as "not used" and none of that is a reason to delete anything.

How the verification loop works:
1. In the root `initialize` phase, maven-assembly-plugin (`assembly.xml`) packs `resources/` into `pgp-keys-map-${project.version}.jar`.
2. Every module's `verify` phase runs `pgpverify:check`, with that freshly built jar declared as a plugin dependency — so the map under test is always the working-copy one, not a released version.
3. A module "test" therefore means: its declared dependencies and plugins are downloaded, their signatures checked against the map, and the build fails on any artifact the map does not cover or covers wrongly.

Many standard plugins (deploy, install, javadoc, source, jacoco, enforcer) are bound to phase `none` in the root pom — this project publishes only the assembled jar.

## Test modules

Each module is `packaging=pom` with no sources; its pom *is* the test case. Add an artifact there to bring it under signature verification:

- `pgp-keys-map-test1`, `pgp-keys-map-test2` — general dependency coverage, split to keep poms manageable.
- `org-apache-maven-plugins-test`, `org-codehaus-mojo-test` — plugin coverage (`verifyPlugins`/`verifyPluginDependencies` are on).
- `org-springframework-test` — Spring / Spring Boot, versions driven by `spring-core.version` / `spring-boot.version` properties.

Dependency versions are written as single-version ranges (`[2.22.0]`) so Dependabot bumps them and each bump PR re-verifies the map against a newly released artifact. Where a group's `maven-metadata.xml` is incomplete, a plain version is used instead — those exceptions carry an explanatory comment; keep the comment if you touch the entry.

Dependabot watches all four module directories (`.github/dependabot.yml`); most commits in history are its version bumps.

## Editing `resources/pgp-keys-map.list`

Format (full spec in the pgpverify-maven-plugin docs):

```
groupId[:artifactId[:versionRange]] = <fingerprint>[, <fingerprint>…] | noSig | noKey | badSig
```

Conventions in force throughout the file — match them:

- Entries are kept in roughly alphabetical order by the key on the left (with local deviations where a specific override sits next to its general entry). Insert a new entry among its neighbours rather than appending at the end.
- Fingerprints are full 40-char uppercase with a `0x` prefix; multiple keys are listed one per line, comma-separated, continued with a trailing `\` and aligned under the first.
- `noSig` for artifacts published without signatures, `noKey` where the key was revoked and removed from keyservers, `badSig` for known-broken signatures. A `!` prefix on a fingerprint keeps a revoked/unavailable key accepted in place (see `com.stripe`, `org.liquibase`). Each non-obvious `noKey`/`noSig`/`!` carries a `#` comment saying *why* — write one for anything you add.
- Narrow version ranges override a broader entry for the same group, e.g. `commons-codec:*:(,1.3] = noSig` above the unbounded `commons-codec = …`. Put the specific line before the general one.
- The file is force-LF via `.gitattributes`.
- Only add or correct entries — never drop a key or an entry because nothing in this repo currently uses it. Consumers verify artifact versions this repo does not test.

A change to the list should normally come with a matching test-module entry that actually exercises it.

## Releasing / CI

Workflows delegate to reusable `s4u/.github` workflows (`maven-build.yml` on master/tags, `maven-pr.yml` on PRs, plus release-drafter and auto-approve). Versions are date-based (`YYYY.MM.DD`).
