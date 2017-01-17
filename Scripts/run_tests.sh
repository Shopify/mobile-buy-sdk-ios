#!/usr/bin/env bash

set -ex

if [[ "$CI" == "true" ]]; then
  echo "{
     \"merchant_id\": \"$TEST_MERCHANT_ID\",
     \"domain\": \"$TEST_DOMAIN\",
     \"api_key\": \"$TEST_API_KEY\",
     \"app_id\": \"$TEST_APP_ID\"
   }" > "Mobile Buy SDK/Mobile Buy SDK Tests/test_shop_config.json"
fi

xcodebuild test -project "Mobile Buy SDK/Mobile Buy SDK.xcodeproj" \
-scheme "Mobile Buy SDK Tests" \
-sdk iphonesimulator \
-destination 'platform=iOS Simulator,name=iPhone 6s,OS=10.2'
