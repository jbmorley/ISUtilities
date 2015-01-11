#!/bin/bash

simulator_sdk="iphonesimulator8.1"

set -e
set -u

pushd Tests/iOS
pod update
xcodebuild -sdk "$simulator_sdk" -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests -destination "name=iPhone 6" clean test
popd

pushd Tests/OSX
pod update
xcodebuild -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests clean test
popd
