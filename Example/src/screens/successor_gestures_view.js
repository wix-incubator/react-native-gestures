import React, {Component} from 'react';
import {View, Text} from 'react-native';
import Gestures from '../../react-native-gestures'; // this is for development only, instead of 'react-native-gestures' because react-native doesn't work with module links

export default class SuccessorGesturesView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      blue: {
        base: {x: 0, y: 0},
        offset: {x: 0, y: 0}
      },
      green: {
        base: {x: 0, y: 0},
        offset: {x: 0, y: 0}
      },
    };

    this._viewPosition.bind(this);
  }

  _viewPosition(view) {
    return {
      left: this.state[view].base.x + this.state[view].offset.x,
      top: this.state[view].base.y + this.state[view].offset.y
    }
  }

  render() {
    return (
      <View style={{paddingTop: 20}}>
        <Gestures.View
          style={[
            {position: 'absolute'},
            this._viewPosition('blue')
          ]}
          onPan={this._handlePan.bind(this, 'blue')}
        >
          <View style={{backgroundColor: 'blue', width: 200, height: 200}}/>
          <Gestures.View
            style={[
              {position: 'absolute'},
              this._viewPosition('green')
            ]}
            onPan={this._handlePan.bind(this, 'green')}
          >
            <View style={{backgroundColor: 'green', width: 100, height: 100}}/>
          </Gestures.View>
        </Gestures.View>
      </View>
    );
  }

  _handlePan(view, event) {
    if(event.nativeEvent.action !== 'finish') {
      let stateChange = {};
      stateChange[view] = {
        base: this.state[view].base,
        offset: {x: event.nativeEvent.x, y: event.nativeEvent.y}
      };
      this.setState(stateChange);
      return;
    }

    let stateChange = {};
    stateChange[view] = {
      base: {
        x: this.state[view].base.x + event.nativeEvent.x,
        y: this.state[view].base.y + event.nativeEvent.y
      },
      offset: {x: 0, y: 0}
    }
    this.setState(stateChange);
  }
}