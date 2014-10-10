package com.glow.test.UITest.ActivityTest;

import android.test.ActivityInstrumentationTestCase2;
import android.test.suitebuilder.annotation.LargeTest;
import android.util.Log;

import com.glow.android.R;
import com.glow.android.ui.SignInActivity;
import com.glow.test.UITest.ActionsGlow.SwipeGlow;
import com.glow.test.UITest.Utils.FuncUtils;
import com.glow.test.UITest.Utils.SinginUtils;
import com.jayway.android.robotium.solo.Solo;

import junit.framework.Assert;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.pressMenuKey;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.swipeLeft;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isDisplayed;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isRoot;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.is;

//import static com.google.android.apps.common.testing.ui.es

//import com.glow.test.UITest.Utils.Funcutils;

/**
 * Created by jason on 14-3-19.
 */
@LargeTest
public class HomeTest extends ActivityInstrumentationTestCase2<SignInActivity> {

    private SignInActivity signinactivity;
    private Solo solo;

    private FuncUtils fu = new FuncUtils();
    private SinginUtils su = new SinginUtils();
    private SwipeGlow sg = new SwipeGlow();

    @SuppressWarnings("deprecation")
    public HomeTest() {
        super("com.glow.android", SignInActivity.class);
    }

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        signinactivity = getActivity();
        fu.starts(getInstrumentation());

    }

    //sTestcase 11 Switch to other day and back to today
    @SuppressWarnings("unchecked")
    public void testcase11() throws Exception {
        su.setinfo();
        fu.waitformoment(10000);

        try {
            try {
                onView(withId(R.id.linear_calendar)).check(matches(isDisplayed()));
                onView(withId(R.id.linear_calendar)).perform(swipeLeft());
                onView(withId(R.id.action_to_today)).perform(click());
                fu.logoutapp(getInstrumentation());
            } catch (Exception e) {
                onView(withId(R.id.month_view_pager)).check(matches(isDisplayed()));
                onView(withId(R.id.linear_calendar)).perform(swipeLeft());
                onView(withId(R.id.action_to_today)).perform(click());
                fu.logoutapp(getInstrumentation());
            }
        }catch (Exception e) {

            fu.logoutapp(getInstrumentation());
            Assert.assertTrue(false);
        }
    }



    //testcase14 Daily log area shows on today
    @SuppressWarnings("unchecked")
    public void testcase14() throws Exception {
        su.setinfo();
        fu.waitformoment(10000);
        try {
            String datstr = fu.daystr(0);
            Log.e("jasonwoo",datstr);
            fu.actiontoday();
            onView(withText(datstr)).check(matches(isDisplayed()));
            onView(withText(datstr)).perform(click());
            fu.waitformoment(3000);
            onView(withText(R.string.home_important_tasks_today_caption)).check(matches(isDisplayed()));
            fu.logoutapp(getInstrumentation());
        }catch (Exception e) {

            fu.logoutapp(getInstrumentation());
            Assert.assertTrue(false);
        }
    }

    //testcase15 Daily log area shows on the day after today
    @SuppressWarnings("unchecked")
    public void testcase15() throws Exception {
        su.setinfo();
        fu.waitformoment(10000);
        try {
            String datstr = fu.monthdaystr(1);
            Log.e("jasonwoo",datstr);
            fu.actiontoday();
            onView(allOf(withId(R.id.month_day), is(withText(datstr)))).check(matches(isDisplayed()));
            onView(allOf(withId(R.id.month_day), is(withText(datstr)))).perform(click());
            fu.waitformoment(3000);
            onView(withText(R.string.no_task_for_future_days)).check(matches(isDisplayed()));
            fu.logoutapp(getInstrumentation());
        }catch (Exception e) {

            fu.logoutapp(getInstrumentation());
            Assert.assertTrue(false);
        }
    }

    //testcase16 Daily log area shows on yestoday
    @SuppressWarnings("unchecked")
    public void testcase16() throws Exception {
        su.setinfo();
        fu.waitformoment(10000);
        try {
            String datstr = fu.monthdaystr(-1);
            Log.e("jasonwoo",datstr);
            fu.actiontoday();
            fu.waitformoment();
            onView(allOf(withId(R.id.month_day),is(withText(datstr)))).check(matches(isDisplayed()));
            onView(allOf(withId(R.id.month_day),is(withText(datstr)))).perform(click());
            fu.waitformoment(3000);
            onView(withText(R.string.home_important_tasks_yesterday_caption)).check(matches(isDisplayed()));
            fu.logoutapp(getInstrumentation());
        }catch (Exception e) {

            fu.logoutapp(getInstrumentation());
            Assert.assertTrue(false);
        }
    }

    //testcase17 Daily log area shows on yestoday
    @SuppressWarnings("unchecked")
    public void testcase17() throws Exception {
        su.setinfo();
        fu.waitformoment(10000);
        try {
            String datinfo = fu.getdateinfo(-2,signinactivity);
            String datstr = fu.monthdaystr(-1);
            String datstr1 = fu.monthdaystr(-2);

            fu.actiontoday();
            fu.waitformoment();
            onView(allOf(withId(R.id.month_day),is(withText(datstr)))).check(matches(isDisplayed()));
            onView(allOf(withId(R.id.month_day),is(withText(datstr)))).perform(click());
            fu.waitformoment(3000);
            onView(allOf(withId(R.id.month_day),is(withText(datstr1)))).check(matches(isDisplayed()));
            onView(allOf(withId(R.id.month_day),is(withText(datstr1)))).perform(click());

            fu.waitformoment(5000);
            onView(withText(datinfo)).check(matches(isDisplayed()));
            fu.logoutapp(getInstrumentation());
        }catch (Exception e) {
            fu.logoutapp(getInstrumentation());
            Log.e("HomeTest",e.getMessage());
            Assert.assertTrue(false);
        }
    }

    //Test case 64 Change from period log to home
    public void testcase64() throws Exception {
        try {
            su.setinfo();
            fu.waitformoment(10000);
            onView(withId(android.R.id.home)).perform(click());
            onView(withId(R.id.nav_period_log)).perform(click());
            fu.waitformoment();
            onView(withId(android.R.id.home)).perform(click());
            onView(withId(R.id.nav_home)).perform(click());
            fu.waitformoment(5000);
            fu.actiontoday();
            onView(withText("Today's important tasks")).check(matches(withText(containsString("Today"))));
            onView(withId(android.R.id.home)).perform(click());
            onView(withId(R.id.nav_period_log)).perform(click());
            fu.waitformoment(5000);
            onView(withId(android.R.id.home)).perform(click());
            onView(withId(R.id.nav_home)).perform(click());
            fu.waitformoment(5000);
            fu.actiontoday();
            onView(withText("Today's important tasks")).check(matches(withText(containsString("Today"))));
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            fu.logoutapp(getInstrumentation());
            Log.e("HomeTest", e.getMessage());
            Assert.assertTrue(false);
        }
    }

    //Testcase 65 the phone's menu button
    public void testcase65() throws Exception {
        su.setinfo();
        fu.waitformoment(10000);
        onView(isRoot()).perform(pressMenuKey());
        onView(withText("Send us feedback")).check(matches(isDisplayed()));
        onView(withText("Rate Glow 5 stars")).check(matches(isDisplayed()));
        onView(withText("Log out")).check(matches(isDisplayed()));
        onView(withText("Settings")).check(matches(isDisplayed()));
        onView(withText("Help center")).check(matches(isDisplayed()));
        onView(withText("Log out")).perform(click());
        fu.logoutapp(getInstrumentation());
    }

    //Testcase9 Switch line calander from full calander
    public void testcase9() throws Exception {
        try {
            solo = new Solo(getInstrumentation(), getActivity());
            su.setinfo();
            fu.waitformoment(10000);
            String datstr = fu.daystr(0);
            fu.actiontoday();
            fu.waitformoment();
            onView(withText(datstr)).check(matches(isDisplayed()));
            onView(withId(R.id.home_scroll_view)).perform(SwipeGlow.swipeDownCenter());
            fu.waitformoment(2000);
            onView(withText("Switch months")).check(matches(isDisplayed()));
            onView(withId(R.id.home_scroll_view)).perform(SwipeGlow.swipeDownCenter());
            fu.waitformoment(2000);
            onView(withText(datstr)).check(matches(isDisplayed()));
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            fu.logoutapp(getInstrumentation());
            Log.e("Dragdown", e.getMessage());
            Assert.assertTrue(false);
        }
    }

    @Override
    protected void tearDown() throws Exception {
        super.tearDown();

    }
}
