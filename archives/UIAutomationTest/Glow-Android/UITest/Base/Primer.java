package com.glow.test.UITest.Base;

import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;

import com.google.android.apps.common.testing.testrunner.GoogleInstrumentationTestRunner;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * Created by jason on 14-3-21.
 */
public final class Primer extends GoogleInstrumentationTestRunner {
    private static final String TAG = "Primer";
    private static final String ANIMATION_PERMISSION = "android.permission.SET_ANIMATION_SCALE";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        // as time goes on we may actually need to process our arguments.
        super.onCreate(savedInstanceState);
        disableAnimation();
    }

    private void disableAnimation() {

        int permStatus = getContext().checkCallingOrSelfPermission(ANIMATION_PERMISSION);
//        int permStatus = getContext().checkCallingOrSelfPermission(ANIMATION_PERMISSION);
        if (permStatus == PackageManager.PERMISSION_GRANTED) {
            if (reflectivelyDisableAnimation()) {
                this.getClass().getName();
                Log.i(TAG, "All animations disabled.");
            } else {
                Log.i(TAG, "Could not disable animations.");
            }
        } else {
            Log.i(TAG, "Cannot disable animations due to lack of permission.");
        }
    }

    private boolean reflectivelyDisableAnimation() {
        try {
            Class<?> windowManagerStubClazz = Class.forName("android.view.IWindowManager$Stub");
            Method asInterface = windowManagerStubClazz.getDeclaredMethod("asInterface", IBinder.class);
            Class<?> serviceManagerClazz = Class.forName("android.os.ServiceManager");
            Method getService = serviceManagerClazz.getDeclaredMethod("getService", String.class);
            Class<?> windowManagerClazz = Class.forName("android.view.IWindowManager");
            Method setAnimationScales = windowManagerClazz.getDeclaredMethod("setAnimationScales",
                    float[].class);
            Method getAnimationScales = windowManagerClazz.getDeclaredMethod("getAnimationScales");

            IBinder windowManagerBinder = (IBinder) getService.invoke(null, "window");
            Object windowManagerObj = asInterface.invoke(null, windowManagerBinder);
            float[] currentScales = (float[]) getAnimationScales.invoke(windowManagerObj);
            for (int i = 0; i < currentScales.length; i++) {
                currentScales[i] = 0.0f;
            }
            setAnimationScales.invoke(windowManagerObj, currentScales);
            return true;
        } catch (ClassNotFoundException cnfe) {
            Log.w(TAG, "Cannot disable animations reflectively.", cnfe);
        } catch (NoSuchMethodException mnfe) {
            Log.w(TAG, "Cannot disable animations reflectively.", mnfe);
        } catch (SecurityException se) {
            Log.w(TAG, "Cannot disable animations reflectively.", se);
        } catch (InvocationTargetException ite) {
            Log.w(TAG, "Cannot disable animations reflectively.", ite);
        } catch (IllegalAccessException iae) {
            Log.w(TAG, "Cannot disable animations reflectively.", iae);
        } catch (RuntimeException re) {
            Log.w(TAG, "Cannot disable animations reflectively.", re);
        }
        return false;
    }
}
