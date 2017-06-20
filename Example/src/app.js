import React, {Component} from 'react';
import {AppRegistry, View, Text, Image, Button } from 'react-native';
import DifferentGestureOnSameView from './screens/different_gesture_on_same_view';
import SuccessorGesturesView from './screens/successor_gestures_view';
import _ from 'lodash';

class Example extends Component {
  constructor(props) {
    super(props);
    
    this.state = {
      currentScreen: null
    };
  }

  render() {
    if(this.state.currentScreen) {
      return <this.state.currentScreen/>;
    }

    let screens = [
      DifferentGestureOnSameView,
      SuccessorGesturesView,
    ];

    return (
      <View style={{marginTop: 20, flex: 1, justifyContent: 'center'}}>
        {
          _.map(screens, (screen) => {
            let name = screen.name;
            return (
              <Button
                key={name}
                title={name}
                testId={name}
                onPress={() => this.setState({currentScreen: screen})}
              />
            );
          })
        }
      </View>
    );
  }
}

AppRegistry.registerComponent('Example', () => Example);