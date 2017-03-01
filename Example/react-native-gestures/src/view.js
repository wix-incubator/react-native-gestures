import React, { Component } from 'react';
import { Text, View } from 'react-native';
import { requireNativeComponent } from 'react-native';

export default class GesturesView extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <NativeView
        {...this.props}
      />
    );
  }
}

GesturesView.propTypes = {
  onPinchAction: React.PropTypes.func,
  onTapAction: React.PropTypes.func,
  onPanAction: React.PropTypes.func
};

const NativeView = requireNativeComponent('RNGView', GesturesView);
