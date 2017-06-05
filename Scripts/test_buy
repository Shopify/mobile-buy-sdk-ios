 #!/usr/bin/env bash

set -ex
set -eo pipefail

xcodebuild test \
-project "Buy.xcodeproj" \
-scheme "Buy" \
-sdk iphonesimulator \
-destination 'platform=iOS Simulator,name=iPhone 7,OS=10.3' \
 | xcpretty -c
