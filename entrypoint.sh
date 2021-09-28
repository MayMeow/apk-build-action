#!/bin/bash

apt-get --quiet update --yes
apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1

# Setup path as android_home for moving/exporting the downloaded sdk into it
export ANDROID_HOME="${PWD}/android-home"
# Create a new directory at specified location
install -d $ANDROID_HOME

# Setup path as android_home for moving/exporting the downloaded sdk into it
wget --output-document=$ANDROID_HOME/cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-$3_latest.zip
# move to the archive at ANDROID_HOME
pushd $ANDROID_HOME
unzip -d cmdline-tools cmdline-tools.zip
popd
export PATH=$PATH:${ANDROID_HOME}/cmdline-tools/tools/bin/

# use yes to accept all licenses
yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses || true
sdkmanager --sdk_root=${ANDROID_HOME} "platforms;android-$1"
sdkmanager --sdk_root=${ANDROID_HOME} "platform-tools"
sdkmanager --sdk_root=${ANDROID_HOME} "build-tools;$2"

# disable daemon
echo 'g.gradle.daemon=false' >> ./gradle.properties
# Not necessary, but just for surity
chmod +x ./gradlew

# Run build
./gradlew --no-daemon assembleDebug