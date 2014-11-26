#!/bin/bash

set -e
set -u

pushd Tests/iOS
pod install
xcodebuild -sdk iphonesimulator8.0 -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests clean test || exit 1
popd

pushd Tests/OSX
pod install
xcodebuild -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests clean test || exit 1
popd
