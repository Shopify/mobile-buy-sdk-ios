 #!/usr/bin/env bash

set -ex
set -eo pipefail

xcodebuild test \
-project "Buy.xcodeproj" \
-scheme "Buy" \
-sdk iphonesimulator \
-destination 'platform=iOS Simulator,name=iPhone 6s,OS=10.2' \
 | xcpretty -c
