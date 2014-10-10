package com.glow.test.UITest.ActivityTest;

import android.test.ActivityInstrumentationTestCase2;
import android.test.suitebuilder.annotation.LargeTest;

import com.glow.android.R;
import com.glow.android.ui.SignInActivity;
import com.glow.test.UITest.Utils.FuncUtils;
import com.glow.test.UITest.Utils.SinginUtils;

import junit.framework.Assert;

import static com.glow.test.UITest.Matchers.ViewMatchersForGlow.isonthetop;
import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.pressBack;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isDisplayed;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isRoot;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.is;


/**
 * Created by jason on 14-3-21.
 */
@LargeTest
public class DailylogTest extends ActivityInstrumentationTestCase2<SignInActivity> {


    private SignInActivity signinactivity;
    private FuncUtils fu = new FuncUtils();
    private SinginUtils su = new SinginUtils();

    @SuppressWarnings("deprecation")
    public DailylogTest() {
        super("com.glow.android", SignInActivity.class);
    }

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        signinactivity = getActivity();
        fu.starts(getInstrumentation());
    }

    //Testcase20 Save empty daily task log
    public void testcase20() throws Exception {
        try {
            su.setinfo();
            fu.waitformoment(10000);
            onView(withId(R.id.create_daily_log)).perform(click());
            fu.waitformoment();
            onView(withId(R.id.action_save)).perform(click());
            fu.waitformoment();
            onView(withText(R.string.create_daily_log)).check(matches(isDisplayed()));
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            Assert.assertTrue(false);
            fu.logoutapp(getInstrumentation());
        }
    }

    //Testcase19 and 22 Save empty daily task log and save something
    public void testcase19and22() throws Exception {
        try {
            su.setinfo();
            fu.waitformoment(10000);
            onView(withId(R.id.create_daily_log)).perform(click());
            fu.waitformoment();
            onView(isRoot()).perform(pressBack());
            fu.waitformoment();
            onView(withText(R.string.create_daily_log)).check(matches(isDisplayed()));
            fu.waitformoment();

            //save something
            onView(withId(R.id.create_daily_log)).perform(click());
            fu.waitformoment();
            onView(allOf(withId(R.id.daily_log_tick), is(isonthetop(1)))).perform(click());
            fu.waitformoment(1000);
            onView(withText(R.string.daily_log_position_on_bottom)).perform(click());
            fu.waitformoment(1000);
            onView(isRoot()).perform(pressBack());
            fu.waitformoment(1000);
            onView(withText(R.string.daily_log_save_prompt_positive_button)).perform(click());
            fu.waitformoment();
            onView(withText(R.string.create_daily_log_logged)).check(matches(isDisplayed()));

            //change to save nothing
            onView(withText(R.string.create_daily_log_logged)).perform(click());
            fu.waitformoment(1000);
            onView(allOf(withId(R.id.daily_log_tick), is(isonthetop(1)))).perform(click());
            fu.waitformoment(1000);
            onView(withId(R.id.action_save)).perform(click());
            fu.waitformoment();
            onView(withText(R.string.create_daily_log)).check(matches(isDisplayed()));
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            Assert.assertTrue(false);
            fu.logoutapp(getInstrumentation());
        }
    }

    @Override
    protected void tearDown() throws Exception {
        super.tearDown();

    }
}
