#!/bin/bash
set -e
xcodebuild -project 'QuotesMaker.xcodeproj' -scheme 'QuotesMaker' -destination 'platform=iOS Simulator,name=iPhone 11' test
xcodebuild -project 'QuotesMaker.xcodeproj' -scheme 'QuotesMaker' -destination 'platform=iOS Simulator,name=iPad Pro (12.9-inch) (3rd generation)' test

xcodebuild -project 'QuotesMaker.xcodeproj' -scheme 'QuotesMaker' -destination 'generic/platform=iOS' -configuration Release build CODE_SIGNING_ALLOWED=NO
