package com.glow.test.UITest.ActionsGlow;


import com.google.android.apps.common.testing.ui.espresso.ViewAction;
import com.google.android.apps.common.testing.ui.espresso.action.GeneralLocation;
import com.google.android.apps.common.testing.ui.espresso.action.GeneralSwipeAction;
import com.google.android.apps.common.testing.ui.espresso.action.Press;
import com.google.android.apps.common.testing.ui.espresso.action.Swipe;

/**
 * Created by jason on 14-3-21.
 */
public class SwipeGlow {

    public static ViewAction swipeDown() {
        return new GeneralSwipeAction(Swipe.SLOW,GeneralLocation.TOP_CENTER,
                GeneralLocation.BOTTOM_CENTER, Press.THUMB);
    }

    public static ViewAction swipeDownCenter() {
        return new GeneralSwipeAction(Swipe.SLOW,GeneralLocation.CENTER,
                GeneralLocation.BOTTOM_CENTER, Press.THUMB);
    }

    public static ViewAction swipeUpCenter() {
        return new GeneralSwipeAction(Swipe.SLOW,GeneralLocation.BOTTOM_CENTER,
                GeneralLocation.CENTER,Press.THUMB);
    }

    public static ViewAction swipeUp() {
        return new GeneralSwipeAction(Swipe.FAST, GeneralLocation.TOP_CENTER,
                GeneralLocation.TOP_CENTER, Press.THUMB);
    }
}
