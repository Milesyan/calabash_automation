package com.glow.test.UITest.Utils;

import com.glow.android.R;
import com.jayway.android.robotium.solo.Solo;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.typeText;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;

/**
 * Created by jason on 14-3-18.
 */
public class SinginUtils {

    private FuncUtils fu = new FuncUtils();
    public void setinfo(){
        onView(withId(R.id.email)).perform(typeText("jason+00001@upwlabs.com"));
        onView(withId(R.id.password)).perform(typeText("hui130124"));
        fu.waitformoment(1000);
        onView(withId(R.id.sign_in_button)).perform(click());
        fu.waitformoment(1000);
    }

    public void solo_goback(Solo solo){
        solo.goBack();

    }

    public void setinfo(String email,String password){
        onView(withId(R.id.email)).perform(typeText(email));
        onView(withId(R.id.password)).perform(typeText(password));
        fu.waitformoment(1000);
        onView(withId(R.id.sign_in_button)).perform(click());
        fu.waitformoment(1000);
    }

    public void forgetpassword(String email){
        onView(withId(R.id.forgot_password)).perform(click());
        fu.waitformoment();
        onView(withId(R.id.email)).perform(typeText(email));
        onView(withText("Send")).perform(click());
    }
}
