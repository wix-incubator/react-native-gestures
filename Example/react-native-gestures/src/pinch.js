import React, { Component } from 'react';
import { Text, View } from 'react-native';
import { requireNativeComponent } from 'react-native';

export default class Pinch extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <NativePinchView
        {...this.props}
      />
    );
  }
}

Pinch.propTypes = {
  onStart: React.PropTypes.func,
  onChange: React.PropTypes.func,
  onFinish: React.PropTypes.func
};

const NativePinchView = requireNativeComponent('RNGPinch', Pinch);
