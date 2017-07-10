package com.wix.gestures;

import android.content.Context;
import android.view.GestureDetector;
import android.view.GestureDetector.OnGestureListener;
import android.view.MotionEvent;

import com.facebook.react.bridge.ReactContext;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.facebook.react.views.view.ReactViewGroup;

public class GestureDetectingView extends ReactViewGroup implements OnGestureListener {

  private GestureDetector mSimpleGestureDetector;

  public GestureDetectingView(Context context) {
    super(context);
    init(context);
  }

  private void init(Context context) {
    mSimpleGestureDetector = new GestureDetector(context, this);
  }

  @Override
  public boolean onTouchEvent(MotionEvent event) {
    return mSimpleGestureDetector.onTouchEvent(event);
  }

  @Override
  public boolean onDown(MotionEvent e) {
    return true;
  }

  @Override
  public void onShowPress(MotionEvent e) {
  }

  @Override
  public boolean onSingleTapUp(MotionEvent e) {
    ReactContext reactContext = (ReactContext) getContext();
    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(getId(), "onTap", null);
    return true;
  }

  @Override
  public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
    return false;
  }

  @Override
  public void onLongPress(MotionEvent e) {
  }

  @Override
  public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
    return false;
  }
}
