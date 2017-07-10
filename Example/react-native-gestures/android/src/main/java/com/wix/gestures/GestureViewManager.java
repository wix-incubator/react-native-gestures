package com.wix.gestures;

import android.support.annotation.Nullable;

import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewGroupManager;

import java.util.Map;

public class GestureViewManager extends ViewGroupManager<GestureDetectingView> {

  private static final String REACT_CLASS = "RNGView";

  @Override
  public String getName() {
    return REACT_CLASS;
  }

  @Override
  public GestureDetectingView createViewInstance(ThemedReactContext context) {
    return new GestureDetectingView(context);
  }

  @Nullable
  @Override
  public Map<String, Object> getExportedCustomDirectEventTypeConstants() {
    return MapBuilder.<String, Object>builder()
        .put("onTap", MapBuilder.of("registrationName", "onTap"))
        .build();
  }
}
