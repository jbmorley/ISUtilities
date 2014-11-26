#!/bin/bash

set -e

pushd Tests/iOS

pod install
xcodebuild -workspace ISUtilitiesTests.xcworkspace \
           -scheme ISUtilitiesTests \
           test || exit 1

popd

pushd Tests/OSX

pod install
xcodebuild -workspace ISUtilitiesTests.xcworkspace \
           -scheme ISUtilitiesTests \
           test || exit 1

popd
