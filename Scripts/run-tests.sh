#!/bin/bash

simulator_sdk="iphonesimulator8.1"

set -e
set -u

pushd Tests/iOS > /dev/null
echo "Running iOS Tests..."
echo "Updating CocoaPods..."
pod update --silent
xcodebuild -sdk "$simulator_sdk" -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests -destination "name=iPhone 6" clean build | xcpretty -c
xcodebuild -sdk "$simulator_sdk" -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests -destination "name=iPhone 6" test
popd > /dev/null

pushd Tests/OSX > /dev/null
echo "Running OS X Tests..."
echo "Updating CocoaPods..."
pod update --silent
xcodebuild -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests clean build | xcpretty -c
xcodebuild -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests test
popd > /dev/null
