package com.wix.gestures;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.JavaScriptModule;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;

import java.util.Collections;
import java.util.List;

public class GesturePackage implements ReactPackage {

  @Override
  public List<Class<? extends JavaScriptModule>> createJSModules() {
    return Collections.emptyList();
  }

  @Override
  public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
    return Collections.<ViewManager>singletonList(new GestureViewManager());
  }

  @Override
  public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
    return Collections.emptyList();
  }
}
