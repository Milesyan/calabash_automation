package com.glow.test.UITest.PageAction;

import com.glow.android.R;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;

/**
 * Created by jason on 14-3-17.
 */
public class SignupAction {

    public void clicksignupbutton(){
        onView(withId(R.id.signUpButton)).check(matches(withText("Sign Up")));
        onView(withId(R.id.signUpButton)).perform(click());
    }

}
