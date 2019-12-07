# PGP keys map to maven artifacts
[![Build Status](https://travis-ci.com/s4u/pgp-keys-map.svg?branch=master)](https://travis-ci.com/s4u/pgp-keys-map)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=org.simplify4u%3Apgp-keys-map&metric=alert_status)](https://sonarcloud.io/dashboard?id=org.simplify4u%3Apgp-keys-map)
[![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=org.simplify4u%3Apgp-keys-map&metric=ncloc)](https://sonarcloud.io/dashboard?id=org.simplify4u%3Apgp-keys-map)

This project contains PGP keys map to maven artifacts which should be used to signed.

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
                            <version>2019.12</version>
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
