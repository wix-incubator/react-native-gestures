
# react-native-touch-gestures

Native gestures in React Native

## Getting started

`$ npm install react-native-touch-gestures --save`

### Mostly automatic installation

`$ react-native link react-native-touch-gestures`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-touch-gestures` and add `RNGGestures.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNGGestures.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<


## Usage
```javascript
import Gestures from 'react-native-touch-gestures';

class Example extends Component {
  render() {
    return (
      <View>
        <Gestures.View // Wrap the view with the Gestures view that recognizes pinch
          onPinch={this.onPinch}
          onTap={this.onTap}
          onPan={this.onPan}
        >
          <Text>hello world</Text>
        </Gestures.Pinch>
      </View>
    );
  }
  
  onPinch(event) {
    console.log(
      'onPinch -- ',
      'gestureId: ', event.nativeEvent.gestureId, // unique id per gesture
      'action: ', event.nativeEvent.action, // 'start' | 'change' | 'finish'
      'scale: ', event.nativeEvent.scale
    );
  }

  onTap(event) {
    console.log(
      'onTap -- ',
      'gestureId: ', event.nativeEvent.gestureId // unique id per gesture
    );
  }

  onPan(event) {
    console.log(
    'onPan -- ',
    'gestureId: ', event.nativeEvent.gestureId,
      'action: ', event.nativeEvent.action, // 'start' | 'change' | 'finish'
      'x: ', event.nativeEvent.x,
      'y: ', event.nativeEvent.y
    );
  }
}
```
  
## Roadmap
* Add support for Android
* Add support for more gestures