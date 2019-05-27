
# react-native-ant-viewer

## Getting started

1.  `$ npm install react-native-ant-viewer` 

### Manual installation

#### iOS

If you use Cocoapods: 
1. Add  `pod 'RNAntViewer', path: '../node_modules/react-native-ant-viewer'` to your Podfile
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

### Troubleshooting 
https://stackoverflow.com/questions/50096025/it-gives-errors-when-using-swift-static-library-with-objective-c-project


## Usage
```javascript
import AntWidget from 'react-native-ant-viewer';

export default class App extends Component<Props> {
  render() {
    return (
      <View style={styles.container}>
        <AntWidget
        isLightMode={true}
        bottomMargin={40}
        rightMargin={30}
        onViewerAppear={() => console.log("Appeared")}
        onViewerDisappear={() => console.log("Disappeared")}
        />
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
      </View>
    );
  }
}

```
  
