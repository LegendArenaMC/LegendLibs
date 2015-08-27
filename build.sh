#!/usr/bin/env bash

echo "Building `basename \`pwd\`` on branch `git rev-parse --abbrev-ref HEAD`..."

set -e

#prefer system-wide installations of gradle than the gradle wrapper
#(mainly to save the annoyance of downloading the gradle runtime if we don't need to)
if [ -f scripts/.requireshadow ]; then
    if hash gradle 2>/dev/null; then
        gradle build shadowJar
    else
        ./gradlew build shadowJar --no-daemon
    fi
    rm build/libs/`basename \`pwd\``.jar
    mv build/libs/`basename \`pwd\``-all.jar build/libs/`basename \`pwd\``.jar
else
    if hash gradle 2>/dev/null; then
        gradle build
    else
        ./gradlew build --no-daemon
    fi
fi

echo "Done!"