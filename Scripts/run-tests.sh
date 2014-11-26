#!/bin/bash

set -e
set -u

pushd Tests/iOS
pod update
xcodebuild -sdk iphonesimulator8.0 -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests -destination "name=iPhone 6" clean test || exit 1
popd

pushd Tests/OSX
pod update
xcodebuild -workspace ISUtilitiesTests.xcworkspace -scheme ISUtilitiesTests clean test || exit 1
popd
