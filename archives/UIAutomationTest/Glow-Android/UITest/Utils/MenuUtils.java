package com.glow.test.UITest.Utils;

import com.glow.android.R;
import com.glow.test.UITest.ActionsGlow.SwipeGlow;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;



/**
 * Created by jason on 14-3-24.
 */
public class MenuUtils {
    private FuncUtils fu = new FuncUtils();
    private SinginUtils su = new SinginUtils();
    private PickUtils pu = new PickUtils();
    private SwipeGlow sg = new SwipeGlow();

    public void switchmenu(String str){
        onView(withId(android.R.id.home)).perform(click());
        fu.waitformoment();
        if(str == "home"){
            onView(withId(R.id.nav_home)).perform(click());
            fu.waitformoment();
        }
        if(str == "period") {
            onView(withId(R.id.nav_period_log)).perform(click());
            fu.waitformoment();
        }
        if(str == "me") {
            onView(withId(R.id.nav_profile)).perform(click());
            fu.waitformoment();
        }
        if(str == "gf"){
            onView(withId(R.id.nav_gf)).perform(click());
            fu.waitformoment();
        }
        if(str == "debug"){
            onView(withId(R.id.nav_debug)).perform(click());
            fu.waitformoment();
        }
    }
}
