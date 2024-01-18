cd ./Project

xcrun instruments -w 'iPhone 14 Pro Max (latest)' || sleep 15

xcodebuild test-without-building \
    -workspace 'MdEditor.xcworkspace' \
    -scheme 'MdEditor' \
    -destination 'platform=iOS Simulator,name=iPhone 14 Pro Max,OS=latest'
