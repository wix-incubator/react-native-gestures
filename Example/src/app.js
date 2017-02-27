import React, {Component} from 'react';
import {AppRegistry, View, Text, Button} from 'react-native';
import Gestures from '../react-native-gestures'; // this is for development only, instead of 'react-native-gestures' because react-native doesn't work with module links

export default class Example extends Component {
  constructor(props) {
    super(props);

    this.state = {
      baseFontSize: 30,
      scale: 1
    };

    this.onPinchUpdate = this.onPinchUpdate.bind(this);
    this.onPinchFinish = this.onPinchFinish.bind(this);
  }

  render() {
    return (
      <View flex={1} justifyContent='center' alignItems='center'>
        <Gestures.Pinch
            onStart={this.onPinchUpdate}
            onChange={this.onPinchUpdate}
            onFinish={this.onPinchFinish}
        >
          <Text style={{fontSize: this.state.baseFontSize * this.state.scale}}>
            The fontSize of this text box can be changed with pinch gesture
          </Text>
        </Gestures.Pinch>
      </View>
    );
  }

  onPinchUpdate(event) {
    this.setState({scale: event.nativeEvent.scale});
  }

  onPinchFinish(event) {
    let newFontSize = this.state.baseFontSize * event.nativeEvent.scale;
    if(newFontSize < 10) newFontSize = 10;
    this.setState({
      baseFontSize: newFontSize,
      scale: 1
    });
  }
}

AppRegistry.registerComponent('Example', () => Example);  