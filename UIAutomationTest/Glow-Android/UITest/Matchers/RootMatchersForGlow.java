package com.glow.test.UITest.Matchers;

import com.google.android.apps.common.testing.ui.espresso.Root;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;


/**
 * Created by jason on 14-3-18.
 */
public class RootMatchersForGlow {

    public static Matcher<Root> iswindowsfocus() {
        return new TypeSafeMatcher<Root>() {

            @Override
            public void describeTo(Description description) {
                description.appendText("is iswindowsfocus");
            }

            @Override
            public boolean matchesSafely(Root root) {
                if (root.getDecorView().hasWindowFocus() == false) {
                    return false;
                }
                return true;
            }
        };
    }

    public static Matcher<Root> isclickenable() {
        return new TypeSafeMatcher<Root>() {

            @Override
            public void describeTo(Description description) {
                description.appendText("is clickable");
            }

            @Override
            public boolean matchesSafely(Root root) {
                if (root.getDecorView().isClickable() == false) {
                    return false;
                }
                return true;
            }
        };
    }


}
