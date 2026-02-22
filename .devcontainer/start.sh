#!/bin/bash

export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator

echo "==> Starting Xvfb..."
Xvfb :0 -screen 0 540x960x16 -ac -noreset &
sleep 2

echo "==> Starting Android emulator..."
DISPLAY=:0 emulator -avd avd -no-window -no-audio \
    -gpu swiftshader_indirect -no-boot-anim \
    -memory 4096 -cores 2 -no-snapshot -no-accel -no-metrics &

echo "==> Starting Node server..."
cd /workspaces/android-em
npm start
