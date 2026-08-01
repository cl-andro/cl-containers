#!/bin/sh
set -e
echo "=== kotlin-compiler Sandbox Setup ==="
mkdir -p /opt/kotlin
mkdir -p /opt/kotlin/jre

echo "Downloading Kotlin Compiler..."
curl -L -o /tmp/kotlin.zip https://github.com/JetBrains/kotlin/releases/download/v2.0.21/kotlin-compiler-2.0.21.zip

echo "Downloading OpenJDK JRE 17..."
curl -L -o /tmp/jre.tar.gz https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.7%2B7/OpenJDK17U-jre_x64_linux_hotspot_17.0.7_7.tar.gz

echo "Extracting Kotlin compiler..."
mkdir -p /tmp/kotlin_extract
python3 -c "import zipfile; zipfile.ZipFile('/tmp/kotlin.zip').extractall('/tmp/kotlin_extract')"
cp -r /tmp/kotlin_extract/kotlinc/* /opt/kotlin/
rm -rf /tmp/kotlin.zip /tmp/kotlin_extract

echo "Extracting JRE 17..."
tar -xzf /tmp/jre.tar.gz -C /opt/kotlin/jre --strip-components=1
rm -f /tmp/jre.tar.gz

echo "Setting permissions..."
if [ -n "$SUDO_UID" ] && [ -n "$SUDO_GID" ]; then
    chown -R "$SUDO_UID:$SUDO_GID" /opt/kotlin
else
    chmod -R 777 /opt/kotlin
fi

echo "=== kotlin-compiler Sandbox Forged ==="
