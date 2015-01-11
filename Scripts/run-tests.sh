#!/bin/bash

simulator_sdk="iphonesimulator8.1"

set -e
set -u

pushd Tests/iOS > /dev/null
echo "Running iOS Tests...\n"
pod update --silent
xcodebuild -sdk "$simulator_sdk" -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests -destination "name=iPhone 6" clean test | xcpretty -c
popd > /dev/null

pushd Tests/OSX > /dev/null
echo "Running OS X Tests...\n"
pod update --silent
xcodebuild -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests clean test | xcpretty -c
popd > /dev/null
