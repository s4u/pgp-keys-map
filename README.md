# PGP keys map to maven artifacts
[![Build Status](https://travis-ci.com/s4u/pgp-keys-map.svg?branch=master)](https://travis-ci.com/s4u/pgp-keys-map)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=org.simplify4u%3Apgp-keys-map&metric=alert_status)](https://sonarcloud.io/dashboard?id=org.simplify4u%3Apgp-keys-map)
[![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=org.simplify4u%3Apgp-keys-map&metric=ncloc)](https://sonarcloud.io/dashboard?id=org.simplify4u%3Apgp-keys-map)

This project contains PGP keys map to maven artifacts which should be used to signed.

# Contributing

We need help of any other people (the more the better) to build **credible** keys map,
so your contribution is welcome.

Especially you can help, when:
 - you want to add more artifacts / plugins
 - you find wrong key mapping
 - you verify pull request
 - you are author who publish something to maven central - let us know about your key
 - star / watch project
 - share knowledge about project in any way

# Usage

    <project>

        <properties>
            <pgp-keys-map.version>2019.12</pgp-keys-map.version>
        </properties>

        <dependencies>
            <dependency>
                <!-- because plugin dependencies aren't verified, 
                     we should add this in order to also check keys map -->
                <groupId>org.simplify4u</groupId>
                <artifactId>pgp-keys-map</artifactId>
                <version>${pgp-keys-map.version}</version>
                <scope>runtime</scope>
                <optional>true</optional>
            </dependency>
        </dependencies>

        ...
        <build>
            <!-- To define the plugin version in your parent POM -->
            <pluginManagement>
                <plugins>
                    <plugin>
                        <groupId>org.simplify4u.plugins</groupId>
                        <artifactId>pgpverify-maven-plugin</artifactId>
                        <version>1.5.0</version>
                        <executions>
                            <execution>
                                <goals>
                                    <goal>check</goal>
                                </goals>
                            </execution>
                        </executions>
                        <configuration>
                            <keysMapLocation>/pgp-keys-map.list</keysMapLocation>
                            <strictNoSignature>true</strictNoSignature>
                            <verifyPlugins>true</verifyPlugins>
                        </configuration>
                        <dependencies>
                            <dependency>
                                <groupId>org.simplify4u</groupId>
                                <artifactId>pgp-keys-map</artifactId>
                                <version>${pgp-keys-map.version}</version>
                            </dependency>
                        </dependencies>
                    </plugin>
                    ...
                </plugins>
            </pluginManagement>

            <!-- To use the plugin goals in your POM or parent POM -->
            <plugins>
                <plugin>
                    <groupId>org.simplify4u.plugins</groupId>
                    <artifactId>pgpverify-maven-plugin</artifactId>
                </plugin>
            ...
            </plugins>
        </build>
        ...
    </project>
