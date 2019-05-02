
# react-native-ant-viewer

## Getting started

1. add  `"react-native-ant-viewer": "https://github.com/kolyan94/RNAntViewer.git"` to package.json dependencies
2. `$ npm install`


### Manual installation

#### iOS

If you use Cocoapods: 
1. add  `pod 'RNAntViewer', path: '../node_modules/react-native-ant-viewer'` to your Podfile
2. `$ pod install`

If not:

1. `$ pod init`
2. 
```
platform :ios, '11.3'
use_frameworks!
target 'your_app_name' do
pod 'React', :path => '../node_modules/react-native', :subspecs => [
'Core',
'CxxBridge', # Include this for RN >= 0.47
'DevSupport', # Include this to enable In-App Devmenu if RN >= 0.43
'RCTText',
'RCTNetwork',
'RCTWebSocket', # needed for debugging
# Add any other subspecs you want to use in your project
]
# Explicitly include Yoga if you are using RN >= 0.42.0
pod 'yoga', :path => '../node_modules/react-native/ReactCommon/yoga'

# Third party deps podspec link
pod 'DoubleConversion', :podspec => '../node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'
pod 'glog', :podspec => '../node_modules/react-native/third-party-podspecs/glog.podspec'
pod 'Folly', :podspec => '../node_modules/react-native/third-party-podspecs/Folly.podspec'

pod 'RNAntViewer', path: '../node_modules/react-native-ant-viewer'

end
```
3. `$ pod install`


## Usage
```javascript
import AntWidget from 'react-native-ant-viewer';

<AntWidget />
```
  
