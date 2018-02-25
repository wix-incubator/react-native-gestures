package com.wix.gestures;

import android.content.Context;
import android.support.v4.view.MotionEventCompat;
import android.support.v4.view.ScaleGestureDetectorCompat;
import android.view.GestureDetector;
import android.view.GestureDetector.OnGestureListener;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.facebook.react.views.view.ReactViewGroup;

public class GestureDetectingView extends ReactViewGroup implements OnGestureListener, ScaleGestureDetector.OnScaleGestureListener {

  private GestureDetector mSimpleGestureDetector;
  private ScaleGestureDetector mScaleGestureDetector;
  private boolean mIsScrolling = false;
  private boolean mIsDetectorEnabled = true;
  private boolean mCanInterceptTouches = true;
  private boolean mEventWasHandled = false;
  private float mCurrentPanX;
  private float mCurrentPanY;
  private float mCurrentScale;
  private float mScrollStartX;
  private float mScrollStartY;
  private float mScaleStartSpan;
  private float mScreenDensity;

  public GestureDetectingView(Context context) {
    super(context);
    init(context);
  }

  private void init(Context context) {
    mSimpleGestureDetector = new GestureDetector(context, this);
    mScaleGestureDetector = new ScaleGestureDetector(context, this);
    ScaleGestureDetectorCompat.setQuickScaleEnabled(mScaleGestureDetector, false);
    mScreenDensity = getResources().getDisplayMetrics().density;
  }

  @Override
  public boolean onTouchEvent(MotionEvent event) {
    mScaleGestureDetector.onTouchEvent(event);
    boolean isConsumed = mSimpleGestureDetector.onTouchEvent(event);

    final int action = MotionEventCompat.getActionMasked(event);
    boolean gestureEnded = action == MotionEvent.ACTION_CANCEL || action == MotionEvent.ACTION_UP;

    if (gestureEnded && mIsScrolling) {
      mIsScrolling = false;
      emitPan("finish");
    }

    mEventWasHandled = true;
    return isConsumed;
  }

  @Override
  public void requestDisallowInterceptTouchEvent(boolean disallowIntercept) {
    super.requestDisallowInterceptTouchEvent(disallowIntercept);
    mCanInterceptTouches = false;
  }

  @Override
  public boolean dispatchTouchEvent(MotionEvent event) {
    mCanInterceptTouches = true;
    mEventWasHandled = false;
    boolean wasConsumed = super.dispatchTouchEvent(event);
    if (mCanInterceptTouches) {
      // this ensures that the GestureDetectingView that is deepest in hierarchy handles the gesture
      getParent().requestDisallowInterceptTouchEvent(true);
      if (!mEventWasHandled) {
        // Somehow call to super.dispatchTouchEvent does not always call this.onTouchEvent,
        // for example when ACTION_DOWN is immediately followed by ACTION_UP.
        // Ensure the detectors get all events by calling onTouchEvent now.
        onTouchEvent(event);
      }
      wasConsumed = true;
    }
    else {
      mIsDetectorEnabled = false;
      // cancel gesture handling
      int originalAction = event.getAction();
      event.setAction(MotionEvent.ACTION_CANCEL);
      mSimpleGestureDetector.onTouchEvent(event);
      event.setAction(originalAction);
    }

    final int action = MotionEventCompat.getActionMasked(event);
    boolean gestureEnded = action == MotionEvent.ACTION_CANCEL || action == MotionEvent.ACTION_UP;

    if (gestureEnded) {
      mIsDetectorEnabled = true;
    }

    return wasConsumed;
  }

  @Override
  public boolean onInterceptTouchEvent(MotionEvent event) {
    if (!mIsDetectorEnabled) {
      return false;
    }

    final int action = MotionEventCompat.getActionMasked(event);
    boolean gestureStart = action == MotionEvent.ACTION_DOWN;
    if (gestureStart) {
      // return false, meaning that onTouchEvent will not be called, but start handling gesture
      // anyway, will cancel if needed
      onTouchEvent(event);
      return false;
    }
    return true;
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
    return performClick();
  }

  @Override
  public boolean performClick() {
    ReactContext reactContext = (ReactContext) getContext();
    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(getId(), "onTap", null);
    return super.performClick();
  }

  @Override
  public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX, float distanceY) {
    String action = mIsScrolling ? "change" : "start";
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

  @Override
  public boolean onScaleBegin(ScaleGestureDetector detector) {
    mScaleStartSpan = detector.getCurrentSpan();
    mCurrentScale = 1;
    emitPinch("start");
    return true;
  }

  @Override
  public boolean onScale(ScaleGestureDetector detector) {
    mCurrentScale = detector.getCurrentSpan() / mScaleStartSpan;
    emitPinch("change");
    return true;
  }

  @Override
  public void onScaleEnd(ScaleGestureDetector detector) {
    emitPinch("finish");
  }

  private void emitPan(String action) {
    WritableMap args = Arguments.createMap();
    args.putString("action", action);
    args.putDouble("x", mCurrentPanX);
    args.putDouble("y", mCurrentPanY);

    ReactContext reactContext = (ReactContext) getContext();
    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(getId(), "onPan", args);
  }

  private void emitPinch(String action) {
    WritableMap args = Arguments.createMap();
    args.putString("action", action);
    args.putDouble("scale", mCurrentScale);

    ReactContext reactContext = (ReactContext) getContext();
    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(getId(), "onPinch", args);
  }
}
