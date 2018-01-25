import React, { Component } from 'react';
import { Text, View, ViewPropTypes } from 'react-native';
import { requireNativeComponent } from 'react-native';
import PropTypes from 'prop-types';

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
  onPinch: PropTypes.func,
  onTap: PropTypes.func,
  onPan: PropTypes.func,
  onRotation: PropTypes.func
};

const NativeView = requireNativeComponent('RNGView', GesturesView);
