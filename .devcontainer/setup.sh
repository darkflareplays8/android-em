#!/bin/bash
set -e

echo "==> Installing system deps..."
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    wget unzip xvfb \
    libgl1 libgles2 libpulse0 libnss3 \
    libxss1 libxtst6 libxrandr2 libasound2

echo "==> Installing Android SDK..."
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator

mkdir -p $ANDROID_HOME/cmdline-tools
wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/ct.zip
unzip -q /tmp/ct.zip -d /tmp
mv /tmp/cmdline-tools $ANDROID_HOME/cmdline-tools/latest
rm /tmp/ct.zip

echo "==> Installing emulator + system image..."
yes | sdkmanager --licenses > /dev/null
sdkmanager "platform-tools" "emulator" "system-images;android-27;default;x86"

echo "==> Creating AVD..."
echo "no" | avdmanager create avd \
    -n avd \
    -k "system-images;android-27;default;x86" \
    --force

printf "hw.ramSize=4096\nhw.gpu.enabled=no\nhw.gpu.mode=swiftshader_indirect\nhw.lcd.width=540\nhw.lcd.height=960\nhw.lcd.density=240\nvm.heapSize=512\ndisk.dataPartition.size=512M\nhw.keyboard=yes\nshowDeviceFrame=no\nfastboot.forceColdBoot=no\nhw.mainKeys=no\nhw.camera.back=none\nhw.camera.front=none\nhw.audioInput=no\nhw.audioOutput=no\nhw.gps=no\nhw.sensors.proximity=no\nhw.sensors.light=no\nhw.sensors.gyroscope=no\nhw.sensors.magnetic_field=no\nhw.accelerometer=no\nhw.battery=no\n" \
    >> $HOME/.android/avd/avd.avd/config.ini

echo "==> Installing Node deps..."
cd /workspaces/android-em
npm install

echo "==> Setup complete!"
