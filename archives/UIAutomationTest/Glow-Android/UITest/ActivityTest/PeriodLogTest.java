package com.glow.test.UITest.ActivityTest;

import android.test.ActivityInstrumentationTestCase2;
import android.test.suitebuilder.annotation.LargeTest;
import android.util.Log;

import com.glow.android.ui.SignInActivity;
import com.glow.test.UITest.ActionsGlow.SwipeGlow;
import com.glow.test.UITest.Utils.FuncUtils;
import com.glow.test.UITest.Utils.MenuUtils;
import com.glow.test.UITest.Utils.SinginUtils;
import com.jayway.android.robotium.solo.Solo;
import com.glow.android.R;

import junit.framework.Assert;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isDisplayed;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withContentDescription;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;

/**
 * Created by jason on 14-3-21.
 */
@LargeTest
public class PeriodLogTest extends ActivityInstrumentationTestCase2<SignInActivity> {

    private SignInActivity signinactivity;
    private FuncUtils fu = new FuncUtils();
    private SinginUtils su = new SinginUtils();
    private MenuUtils mu = new MenuUtils();
    private SwipeGlow sg = new SwipeGlow();
    private Solo solo;

    @SuppressWarnings("deprecation")
    public PeriodLogTest() {
        super("com.glow.android", SignInActivity.class);
    }

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        signinactivity = getActivity();
        fu.starts(getInstrumentation());
        solo = new Solo(getInstrumentation(), getActivity());

    }

    //Test case28 and testcase33 Save period log and delete period log.
    public void testcase28andtestcase33(){
       try{
           su.setinfo();
           fu.waitformoment(10000);

           mu.switchmenu("period");
           fu.waitformoment();
           onView(withText("Today")).check(matches(isDisplayed()));
           onView(withText("Today")).perform(click());
           fu.waitformoment();
           onView(withText("Yes")).perform(click());
           fu.waitformoment();
           onView(withContentDescription("Done")).perform(click());
           fu.waitformoment(5000);
           onView(withText("Today")).perform(click());
           fu.waitformoment(2000);
           onView(withId(R.id.action_delete)).perform(click());

           fu.waitformoment(5000);
           mu.switchmenu("home");
           fu.logoutapp(getInstrumentation());
       }catch (Exception e){
           mu.switchmenu("home");
           fu.logoutapp(getInstrumentation());
           Log.e("Period log", e.getMessage());
           Assert.fail(e.getMessage());
           Assert.assertTrue(false);
       }
    }

    //Testcase 29 Save no changed period log
    public void testcase29(){
        try{
            su.setinfo();
            fu.waitformoment(10000);
            mu.switchmenu("period");
            fu.waitformoment();
            onView(withText("Today")).check(matches(isDisplayed()));
            onView(withText("Today")).perform(click());
            fu.waitformoment();
            onView(withText("Yes")).perform(click());
            fu.waitformoment();
            onView(withContentDescription("Done")).perform(click());
            fu.waitformoment(5000);
            onView(withText("Today")).perform(click());
            fu.waitformoment(2000);
            solo.getCurrentActivity();
            onView(withText("Cancel")).perform(click());
            assertTrue(this.solo.waitForText("Changes discarded"));
            fu.waitformoment();
            onView(withText("Today")).perform(click());
            fu.waitformoment(2000);
            onView(withId(R.id.action_delete)).perform(click());
            fu.waitformoment();
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
            Log.e("Period log", e.getMessage());
            Assert.fail(e.getMessage());
            Assert.assertTrue(false);
        }
    }

    //Testcase32 Change the period log and click cancle button
    public void testcase32(){
        try{
            su.setinfo();
            fu.waitformoment(10000);
            mu.switchmenu("period");
            fu.waitformoment();
            onView(withText("Today")).check(matches(isDisplayed()));
            onView(withText("Today")).perform(click());
            fu.waitformoment();
            onView(withText("Yes")).perform(click());
            fu.waitformoment();
            solo.getCurrentActivity();
            onView(withText("Cancel")).perform(click());
            assertTrue(this.solo.waitForText("Changes discarded"));
            fu.waitformoment();
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
            Log.e("Period log", e.getMessage());
            Assert.fail(e.getMessage());
            Assert.assertTrue(false);
        }
    }

    @Override
    protected void tearDown() throws Exception {
        super.tearDown();

    }
}
