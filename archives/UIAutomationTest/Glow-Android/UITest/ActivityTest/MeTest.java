package com.glow.test.UITest.ActivityTest;

import android.test.ActivityInstrumentationTestCase2;
import android.util.Log;

import com.glow.android.R;
import com.glow.android.ui.SignInActivity;
import com.glow.test.UITest.ActionsGlow.SwipeGlow;
import com.glow.test.UITest.Matchers.RootMatchersForGlow;
import com.glow.test.UITest.Matchers.ViewMatchersForGlow;
import com.glow.test.UITest.Utils.FuncUtils;
import com.glow.test.UITest.Utils.MenuUtils;
import com.glow.test.UITest.Utils.SinginUtils;
import com.google.android.apps.common.testing.ui.espresso.Espresso;
import com.jayway.android.robotium.solo.Solo;

import junit.framework.Assert;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.clearText;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.typeText;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isDisplayed;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.containsString;

/**
 * Created by jason on 14-4-1.
 */
public class MeTest extends ActivityInstrumentationTestCase2<SignInActivity> {

    private SignInActivity signinactivity;
    private FuncUtils fu = new FuncUtils();
    private SinginUtils su = new SinginUtils();
    private MenuUtils mu = new MenuUtils();
    private SwipeGlow sg = new SwipeGlow();
    private Solo solo;
//    private Solo solo;

    @SuppressWarnings("deprecation")
    public MeTest() {
        super("com.glow.android", SignInActivity.class);
    }

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        signinactivity = getActivity();
        fu.starts(getInstrumentation());
        solo = new Solo(getInstrumentation(), getActivity());
    }

    //Test case36 "I'm pregnant!" and  click 'Later'
    public void testcase36(){
        try{
            su.setinfo("jason+000002@upwlabs.com","hui130124");
            fu.waitformoment(10000);
            mu.switchmenu("me");
            onView(withText("I'm pregnant!")).check(matches(isDisplayed()));
            onView(withText("I'm pregnant!")).perform(click());
            fu.waitformoment();
            onView(withText("Later")).perform(click());
            fu.waitformoment();
            onView(withId(R.id.app_purpose_pregnant_select)).check(matches(ViewMatchersForGlow.isSelected()));
            onView(withText("Trying to conceive")).perform(click());
            fu.waitformoment();
            onView(withId(R.id.children_count_picker)).perform(click());
            fu.waitformoment();
            onView(withText("Trying for 1st child")).inRoot(RootMatchersForGlow.iswindowsfocus()).perform(click());
            onView(withId(R.id.ttc_length_text_view)).perform(click());
            fu.waitformoment();
            onView(withText("Set")).perform(click());
            onView(withText("OK")).perform(click());
            fu.waitformoment();
            onView(withId(R.id.app_purpose_ttc_select)).check(matches(ViewMatchersForGlow.isSelected()));
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
            Log.e("Period log", e.getMessage());
            Assert.assertTrue(false);
        }
    }

    //Test case37 "I'm pregnant!" and  click 'Share!'
    public void testcase37(){
        try{
                su.setinfo("jason+000002@upwlabs.com","hui130124");
                fu.waitformoment(10000);
                mu.switchmenu("me");
                onView(withText("I'm pregnant!")).check(matches(isDisplayed()));
                onView(withText("I'm pregnant!")).perform(click());
                fu.waitformoment();
                solo.getCurrentActivity();
                onView(withText("Share!")).perform(click());
                assertTrue(this.solo.waitForText("Sorry, the content is too short!"));
                fu.waitformoment(10000);
                Espresso.pressBack();
                mu.switchmenu("home");
                fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
            Log.e("Period log", e.getMessage());
            Assert.assertTrue(false);
        }
    }

    //Test case38 Help friends create miracles
    public void testcase38(){
        try{
            su.setinfo("jason+000002@upwlabs.com","hui130124");
            fu.waitformoment(10000);
            mu.switchmenu("me");
            onView(withText("Help friends create miracles")).check(matches(isDisplayed()));
            onView(withText("Help friends create miracles")).perform(click());
            fu.waitformoment();

            solo.getCurrentActivity();
            assertTrue(this.solo.searchText("Share to your friends"));
            su.solo_goback(solo);
            fu.waitformoment();
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
            Log.e("Period log", e.getMessage());
            Assert.assertTrue(false);
        }
    }

    //Test case41 and case42 User Setting and Save User setting
    public void testcase41andtestcase42(){
        try{
            su.setinfo("jason+000002@upwlabs.com","hui130124");
            fu.waitformoment(10000);
            mu.switchmenu("me");
            onView(withId(R.id.scrollview_me)).perform(SwipeGlow.swipeUpCenter());
            fu.waitformoment();
            onView(withText("Settings")).perform(click());
            fu.waitformoment(1000);
            onView(withId(R.id.setting_last_name)).perform(click());
            fu.waitformoment(1000);
            onView(withId(R.id.editor)).perform(typeText("jason"));
            onView(withText("Set")).perform(click());
            fu.waitformoment(1000);
            //Back to me home
            onView(withText("Settings")).perform(click());
            //check the result
            onView(withText("Settings")).perform(click());
            fu.waitformoment(1000);
            onView(withId(R.id.last_name)).check(matches(withText(containsString("jason"))));
            onView(withId(R.id.setting_last_name)).perform(click());
            fu.waitformoment(1000);
            onView(withId(R.id.editor)).perform(clearText());
            onView(withId(R.id.editor)).perform(typeText("hui"));
            onView(withText("Set")).perform(click());
            onView(withText("Settings")).perform(click());
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
            Log.e("Period log", e.getMessage());
            Assert.assertTrue(false);
        }
    }

    //Test case39 Success stories
    public void testcase39(){
        try{
            su.setinfo("jason+000002@upwlabs.com","hui130124");
            fu.waitformoment(10000);
            mu.switchmenu("me");
            onView(withId(R.id.scrollview_me)).perform(SwipeGlow.swipeUpCenter());
            fu.waitformoment();
            onView(withText("Success stories")).perform(click());
            fu.waitformoment(5000);
            onView(withId(R.id.web_view)).check(matches(isDisplayed()));
            Espresso.pressBack();
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
            Log.e("Period log", e.getMessage());
            Assert.assertTrue(false);
        }
    }

    //Test case44  Help Center
    public void testcase44(){
        try{
            su.setinfo("jason+000002@upwlabs.com","hui130124");
            fu.waitformoment(10000);
            mu.switchmenu("me");
            onView(withId(R.id.scrollview_me)).perform(SwipeGlow.swipeUpCenter());
            fu.waitformoment();
            onView(withText("Help center")).perform(click());
            fu.waitformoment(5000);
            //FAQ
            onView(withText("FAQ")).check(matches(isDisplayed()));
            onView(withText("FAQ")).perform(click());
            fu.waitformoment(5000);
            onView(withId(R.id.web_view)).check(matches(isDisplayed()));
            Espresso.pressBack();

            //Web
            onView(withText("Web")).check(matches(isDisplayed()));
            onView(withText("Web")).perform(click());
            fu.waitformoment(5000);
            Espresso.pressBack();

            //Blog
            onView(withText("Blog")).check(matches(isDisplayed()));
            onView(withText("Blog")).perform(click());
            fu.waitformoment(5000);
            Espresso.pressBack();

            //Terms of service
            onView(withText("Terms of service")).check(matches(isDisplayed()));
            onView(withText("Terms of service")).perform(click());
            fu.waitformoment(5000);
            Espresso.pressBack();

            //Privacy policy
            onView(withText("Privacy policy")).check(matches(isDisplayed()));
            onView(withText("Privacy policy")).perform(click());
            fu.waitformoment(5000);
            Espresso.pressBack();

            Espresso.pressBack();
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
            Log.e("Period log", e.getMessage());
            Assert.assertTrue(false);
        }
    }


    @Override
    protected void tearDown() throws Exception {
        super.tearDown();

    }

}
