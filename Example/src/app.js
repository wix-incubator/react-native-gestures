import React, {Component} from 'react';
import {AppRegistry, View, Text, Button} from 'react-native';
import Gestures from '../react-native-gestures'; // this is for development only, instead of 'react-native-gestures' because react-native doesn't work with module links

export default class Example extends Component {
  constructor(props) {
    super(props);

    console.warn("Gestures: ", Gestures);
  }

  render() {
    return (
      <View flex={1} justifyContent='center' alignItems='center'>
        <Gestures.Pinch
            onStart={this.onPinchStart}
            onChange={this.onPinchChange}
            onFinish={this.onPinchFinish}
        >
          <Text style={{fontSize: 60}}>Pinch gesture demo</Text>
        </Gestures.Pinch>
      </View>
    );
  }

  onPinchStart(event) {
    console.log(
      'gestureId: ', event.nativeEvent.gestureId,
      'action: ', event.nativeEvent.action,
      'scale: ', event.nativeEvent.scale
    );
  }

  onPinchChange(event) {
    console.log(
      'gestureId: ', event.nativeEvent.gestureId,
      'action: ', event.nativeEvent.action,
      'scale: ', event.nativeEvent.scale
    );
  }

  onPinchFinish(event) {
    console.log(
      'gestureId: ', event.nativeEvent.gestureId,
      'action: ', event.nativeEvent.action,
      'scale: ', event.nativeEvent.scale
    );
  }
}

AppRegistry.registerComponent('Example', () => Example);  