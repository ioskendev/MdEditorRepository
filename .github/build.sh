xcrun instruments -w 'iPhone 14 Pro Max (latest)' || sleep 15

curl -Ls https://install.tuist.io | bash
tuist install 3.36.2
tuist fetch
tuist generate

xcodebuild clean -quiet
xcodebuild build-for-testing \
    -workspace 'MdEditor.xcworkspace' \
    -scheme 'MdEditor' \
    -destination 'platform=iOS Simulator,name=iPhone 14 Pro Max,OS=latest'
