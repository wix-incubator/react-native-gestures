package com.wix.gestures;

import android.content.Context;
import android.view.GestureDetector;
import android.view.GestureDetector.OnGestureListener;
import android.view.MotionEvent;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.facebook.react.views.view.ReactViewGroup;

public class GestureDetectingView extends ReactViewGroup implements OnGestureListener {

  private GestureDetector mSimpleGestureDetector;
  private boolean mIsScrolling = false;
  private float mCurrentPanX;
  private float mCurrentPanY;
  private float mScrollStartX;
  private float mScrollStartY;
  private float mScreenDensity;

  public GestureDetectingView(Context context) {
    super(context);
    init(context);
  }

  private void init(Context context) {
    mSimpleGestureDetector = new GestureDetector(context, this);
    mScreenDensity = getResources().getDisplayMetrics().density;
  }

  @Override
  public boolean onTouchEvent(MotionEvent event) {
    boolean isConsumed = mSimpleGestureDetector.onTouchEvent(event);
    if (mIsScrolling && event.getAction() == MotionEvent.ACTION_UP) {
      mIsScrolling = false;
      emitPan("finish");
    }
    return isConsumed;
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
    String action = mIsScrolling ? "start" : "change";
    if (!mIsScrolling) {
      mIsScrolling = true;
      mScrollStartX = getX();
      mScrollStartY = getY();
    }

    // The position of this view may change when responding to onPan event and pan arguments have
    // to be adjusted.
    mCurrentPanX = ( e2.getX() - e1.getX() + getX() - mScrollStartX ) / mScreenDensity;
    mCurrentPanY = ( e2.getY() - e1.getY() + getY() - mScrollStartY ) / mScreenDensity;

    emitPan(action);

    return true;
  }

  @Override
  public void onLongPress(MotionEvent e) {
  }

  @Override
  public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
    return false;
  }

  private void emitPan(String action) {
    WritableMap args = Arguments.createMap();
    args.putString("action", action);
    args.putDouble("x", mCurrentPanX);
    args.putDouble("y", mCurrentPanY);

    ReactContext reactContext = (ReactContext) getContext();
    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(getId(), "onPan", args);
  }
}
