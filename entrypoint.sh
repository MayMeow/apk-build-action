#!/bin/sh

apt-get --quiet update --yes
apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
export ANDROID_HOME="${PWD}/android-home"
install -d $ANDROID_HOME

wget --output-document=$ANDROID_HOME/cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-$3_latest.zip

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