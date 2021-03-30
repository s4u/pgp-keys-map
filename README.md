# PGP key maps to maven artifacts
[![Build](https://github.com/s4u/pgp-keys-map/workflows/Build/badge.svg)](https://github.com/s4u/pgp-keys-map/actions?query=workflow%3ABuild)
[![Maven Central](https://maven-badges.herokuapp.com/maven-central/org.simplify4u/pgp-keys-map/badge.svg)](https://maven-badges.herokuapp.com/maven-central/org.simplify4u/pgp-keys-map)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=org.simplify4u%3Apgp-keys-map&metric=alert_status)](https://sonarcloud.io/dashboard?id=org.simplify4u%3Apgp-keys-map)
[![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=org.simplify4u%3Apgp-keys-map&metric=ncloc)](https://sonarcloud.io/dashboard?id=org.simplify4u%3Apgp-keys-map)

This project contains PGP key maps to maven artifacts which should be used to sign them.

# Contributing

We need help of any other people (the more the better) to build **credible** key maps,
so your contribution is welcome.

You are especially welcome to help when:
 - you want to add more artifacts / plugins
 - you find wrong key mapping
 - you verify pull request
 - you are author who publish something to maven central - let us know about your key
 - star / watch project
 - share knowledge about project in any way

# Usage

    <project>
        ...
        <build>
            <!-- To define the plugin version in your parent POM -->
            <pluginManagement>
                <plugins>
                    <plugin>
                        <groupId>org.simplify4u.plugins</groupId>
                        <artifactId>pgpverify-maven-plugin</artifactId>
                        <version>1.11.0</version>
                        <executions>
                            <execution>
                                <goals>
                                    <goal>check</goal>
                                </goals>
                            </execution>
                        </executions>
                        <configuration>
                            <keysMapLocation>/pgp-keys-map.list</keysMapLocation>
                            <verifyPlugins>true</verifyPlugins>
                            <verifyPluginDependencies>true</verifyPluginDependencies>
                            <verifyAtypical>true</verifyAtypical>
                        </configuration>
                        <dependencies>
                            <dependency>
                                <groupId>org.simplify4u</groupId>
                                <artifactId>pgp-keys-map</artifactId>
                                <version>2020.08</version>
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
