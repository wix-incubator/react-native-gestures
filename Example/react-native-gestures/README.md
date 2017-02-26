
# react-native-touch-gestures

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
        <Gestures.Pinch // Wrap the view with the Gestures.Pinch view that recognizes pinch
            onStart={this.onPinchStart}
            onChange={this.onPinchChange}
            onFinish={this.onPinchFinish}
        >
          <Text>hello world</Text>
        </Gestures.Pinch>
      </View>
    );
  }
  
  onPinchStart(event) {
    console.log(
      'gestureId: ', event.nativeEvent.gestureId, // unique id per gesture
      'action: ', event.nativeEvent.action, // 'start'
      'scale: ', event.nativeEvent.scale
    );
  }

  onPinchChange(event) {
    console.log(
      'gestureId: ', event.nativeEvent.gestureId,
      'action: ', event.nativeEvent.action, // 'change'
      'scale: ', event.nativeEvent.scale
    );
  }

  onPinchFinish(event) {
    console.log(
      'gestureId: ', event.nativeEvent.gestureId,
      'action: ', event.nativeEvent.action, // 'finish'
      'scale: ', event.nativeEvent.scale
    );
  }
}
```
  