import React, { Component } from 'react';
import { Text, View, ViewPropTypes } from 'react-native';
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
  ...ViewPropTypes,
  onPinch: React.PropTypes.func,
  onTap: React.PropTypes.func,
  onPan: React.PropTypes.func
};

const NativeView = requireNativeComponent('RNGView', GesturesView);
