# Click Count application

[![Build Status](https://travis-ci.com/mbimbij/click-count-2.svg?branch=main)](https://travis-ci.com/mbimbij/click-count-2)


# Notes

1. Le build échoue initialement -> il faut ajouter une version plus récente du plugin maven `maven-war-plugin`

```log
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-war-plugin:2.2:war (default-war) on project clickCount: Execution default-war of goal org.apache.maven.plugins:maven-war-plugin:2.2:war failed: Unable to load the mojo 'war' in the plugin 'org.apache.maven.plugins:maven-war-plugin:2.2' due to an API incompatibility: org.codehaus.plexus.component.repository.exception.ComponentLookupException: Cannot access defaults field of Properties
[ERROR] -----------------------------------------------------
[ERROR] realm =    plugin>org.apache.maven.plugins:maven-war-plugin:2.2
[ERROR] strategy = org.codehaus.plexus.classworlds.strategy.SelfFirstStrategy
```

2. `TravisCI` lance automatiquement `mvn test -B` si le langage est configuré comme étant `Java`. Pour désactiver ce comportement, il faut redéfinir le stage `script` du lifecycle de Travis.

3. On ne peut pas faire facilement d'approbation manuelle avec `Travis`, à moins de faire une machine à gaz, nécessitant un flag et de pousser à nouveau