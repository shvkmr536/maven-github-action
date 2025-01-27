#!/bin/bash

# Retrieve Git commit ID
COMMIT_HEAD=$(git rev-parse HEAD)

echo "The latest commit id is $COMMIT_HEAD , it will use in package naming convention"

COMMIT_ID=$(git log -n1 --format="%h")

# Generate version number
VERSION="$COMMIT_ID"

# Build project
mvn clean package

# Rename JAR file
mv target/my-app-1.0-SNAPSHOT.jar target/my-app-1.0-SNAPSHOT-$VERSION.jar

echo "The latest package name is my-app-1.0-SNAPSHOT-$VERSION.jar"
