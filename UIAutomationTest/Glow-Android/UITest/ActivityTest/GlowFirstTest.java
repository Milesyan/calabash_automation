package com.glow.test.UITest.ActivityTest;

import android.test.ActivityInstrumentationTestCase2;
import android.test.suitebuilder.annotation.LargeTest;

import com.glow.android.R;
import com.glow.android.ui.SignInActivity;
import com.glow.test.UITest.ActionsGlow.SwipeGlow;
import com.glow.test.UITest.Utils.FuncUtils;
import com.glow.test.UITest.Utils.MenuUtils;
import com.glow.test.UITest.Utils.PickUtils;
import com.glow.test.UITest.Utils.SinginUtils;
import com.google.android.apps.common.testing.ui.espresso.Espresso;
import com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers;
import com.jayway.android.robotium.solo.Solo;

import junit.framework.Assert;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.typeText;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isClickable;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isDisplayed;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withEffectiveVisibility;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.is;

/**
 * Created by jason on 14-3-24.
 */
@LargeTest
public class GlowFirstTest extends ActivityInstrumentationTestCase2<SignInActivity> {

    private Solo solo;
    private SignInActivity gfha;
    private FuncUtils fu = new FuncUtils();
    private SinginUtils su = new SinginUtils();
    private PickUtils pu = new PickUtils();
    private SwipeGlow sg = new SwipeGlow();
    private MenuUtils mu = new MenuUtils();



    @SuppressWarnings("deprecation")
    public GlowFirstTest() {
        super("com.glow.android", SignInActivity.class);
    }

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        gfha =  getActivity();
        solo = new Solo(getInstrumentation(), gfha);
        fu.starts(getInstrumentation());
    }

    //Test case 49 Glow First page
    public void testcase49(){
        try {
            su.setinfo();
            fu.waitformoment();
            mu.switchmenu("gf");
            onView(withId(R.id.action_apply_glow_first)).check(matches(isDisplayed()));

            onView(withText("About")).check(matches(isDisplayed()));
            onView(withText("Details")).check(matches(isDisplayed()));

            onView(withText("About")).perform(click());
            onView(withText("What")).check(matches(isDisplayed()));

            onView(withText("Details")).perform(click());
            onView(withText(R.string.glow_first_terms_title)).check(matches(isDisplayed()));

            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }catch (Exception e) {
            Assert.assertTrue(false);
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }
    }

    //Test case 50 Apply glow first page step 1
    public void testcase50(){
        try {
            su.setinfo();
            fu.waitformoment();
            mu.switchmenu("gf");
            onView(withId(R.id.action_apply_glow_first)).check(matches(isDisplayed()));
            onView(withId(R.id.action_apply_glow_first)).perform(click());
            fu.waitformoment();
            onView(withText(R.string.gf_signup_choose_way)).check(matches(isDisplayed()));
            fu.waitformoment();
            Espresso.pressBack();
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }catch (Exception e) {
            Assert.assertTrue(false);
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }
    }

    //Test case 51 and 52 and 55 Apply glow first page step 2 and 3 by email, back from step 3 to step 2
    public void testcase51andtestcase52andtestcase55(){
        try {
            su.setinfo();
            fu.waitformoment();
            mu.switchmenu("gf");
            onView(withId(R.id.action_apply_glow_first)).check(matches(isDisplayed()));
            onView(withId(R.id.action_apply_glow_first)).perform(click());
            fu.waitformoment();
            onView(withText(R.string.gf_signup_choose_way)).check(matches(isDisplayed()));
            onView(withId(R.id.gf_signup_choose_way_employer)).perform(click());
            fu.waitformoment();

            onView(withId(R.id.gf_signup_work_email)).perform(typeText("jason+00002@upwlabs.com"));
            onView(withId(R.id.gf_signup_full_name)).perform(typeText("jason00002"));

            onView(allOf(withText("Next"), is(isClickable())))
                .perform(click());
            fu.waitformoment();

            onView(withId(R.id.gf_signup_verifiy_code)).perform(typeText("111111"));
            onView(withText("Done")).perform(click());
            fu.waitformoment();
            onView(withId(R.id.gf_signup_verifiy_code))
                .check(matches(isDisplayed()));
            fu.waitformoment();
            Espresso.pressBack();
            onView(withText("Yes")).perform(click());
            Espresso.pressBack();
            Espresso.pressBack();
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }catch (Exception e) {
            Assert.assertTrue(false);
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }
    }

//    //Test case 57 Choose manual process to next step
//    public void testcase57(){
////        try {
//            su.setinfo();
//            fu.waitformoment();
//            mu.switchmenu("gf");
//            onView(withId(R.id.action_apply_glow_first)).check(matches(isDisplayed()));
//            onView(withId(R.id.action_apply_glow_first)).perform(click());
//            fu.waitformoment();
//            onView(withText(R.string.gf_signup_choose_way)).check(matches(isDisplayed()));
//            onView(withId(R.id.gf_signup_choose_way_employer)).perform(click());
//            fu.waitformoment();
//
//            onView(withId(R.id.gf_signup_work_email)).perform(typeText("jason+00002@upwlabs.com"));
//            onView(withId(R.id.gf_signup_full_name)).perform(typeText("jason00002"));
//
//            onView(withText("jason+00002@upwlabs.com")).check(matches(isDisplayed()));
//
//            onView(withId(R.id.upload_img)).perform(click());
//            fu.waitformoment();
//
//            solo.sendKey(KeyEvent.KEYCODE_TAB);
//            fu.waitformoment();
//            solo.sendKey(KeyEvent.KEYCODE_TAB);
//            fu.waitformoment();
//            solo.sendKey(KeyEvent.KEYCODE_TAB);
//            fu.waitformoment();
//            solo.sendKey(KeyEvent.KEYCODE_ENTER);
//            fu.waitformoment();
//            onView(allOf(withText("Next"), is(isClickable())))
//                .perform(click());
//            fu.waitformoment(5000);
//
//            onView(withText(R.string.gf_home_paystub_uploaded_dlg_title)).check(matches(isDisplayed()));
//            fu.waitformoment();
//            onView(withText("OK")).perform(click());
//            fu.waitformoment();
//            onView(withText("About")).check(matches(isDisplayed()));
//            mu.switchmenu("home");
//            fu.logoutapp(getInstrumentation());
//        }catch (Exception e) {
//            Assert.assertTrue(false);
//            mu.switchmenu("home");
//            fu.logoutapp(getInstrumentation());
//        }
//    }

    //Test case 59 and Tese case 60 Send email to Hr and cc to myself
    public void testcase59andTestcase60(){
        try {
            su.setinfo();
            fu.waitformoment();
            mu.switchmenu("gf");
            onView(withId(R.id.action_apply_glow_first)).check(matches(isDisplayed()));
            onView(withId(R.id.action_apply_glow_first)).perform(click());
            fu.waitformoment();
            onView(withText(R.string.gf_signup_choose_way)).check(matches(isDisplayed()));
            onView(withId(R.id.gf_signup_choose_way_employer)).perform(click());
            fu.waitformoment();

            onView(withId(R.id.gf_signup_work_email)).perform(typeText("jason@ximalaya.com"));
            onView(withId(R.id.gf_signup_full_name)).perform(typeText("jason00002"));
//            onView(withText("jason+00002@upwlabs.com")).check(matches(isDisplayed()));

            onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE))))
                .perform(click( ));
            fu.waitformoment();
//            onView(withText(R.string.gf_signup_notify_employer_header)).check(matches(isDisplayed()));

            onView(withId(R.id.gf_signup_hr_email)).perform(typeText("jason+00001@upwlabs.com"));
            onView(withId(R.id.gf_signup_content)).perform(typeText("jason+00001@upwlabs.com"));
            onView(withId(R.id.gf_signup_cc_self)).perform(click());


            solo.getCurrentActivity();
            onView(withText("SEND")).perform(click());
            assertTrue(this.solo.waitForText("Email sent!"));
            fu.waitformoment();
            onView(withText("About")).check(matches(isDisplayed()));
            onView(withText("What")).check(matches(isDisplayed()));
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());

        }catch (Exception e) {
            Assert.assertTrue(false);
            mu.switchmenu("home");
            fu.logoutapp(getInstrumentation());
        }
    }

//    //Test case 59 and Tese case 60 Send email to Hr and cc to myself
//    public void testcase59andTestcase60(){
//        try {
//            su.setinfo();
//            fu.waitformoment();
//            mu.switchmenu("gf");
//            onView(withId(R.id.action_apply_glow_first)).check(matches(isDisplayed()));
//            onView(withId(R.id.action_apply_glow_first)).perform(click());
//            fu.waitformoment();
//            onView(withText(R.string.gf_signup_choose_way)).check(matches(isDisplayed()));
//            onView(withId(R.id.gf_signup_choose_way_employer)).perform(click());
//            fu.waitformoment();
//
//            onView(withId(R.id.gf_signup_work_email)).perform(typeText("jason@ximalaya.com"));
//            onView(withId(R.id.gf_signup_full_name)).perform(typeText("jason00002"));
//            onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE))))
//                .perform(click( ));
//            fu.waitformoment();
//            onView(withId(R.id.gf_signup_hr_email)).perform(typeText("jason+00001@upwlabs.com"));
//            onView(withId(R.id.gf_signup_content)).perform(typeText("jason+00001@upwlabs.com"));
//            onView(withId(R.id.gf_signup_cc_self)).perform(click());
//
//
//            solo.getCurrentActivity();
//            onView(withText("SEND")).perform(click());
//            assertTrue(this.solo.waitForText("Email sent!"));
//            fu.waitformoment();
//            onView(withText("About")).check(matches(isDisplayed()));
//            onView(withText("What")).check(matches(isDisplayed()));
//            mu.switchmenu("home");
//            fu.logoutapp(getInstrumentation());
//
//        }catch (Exception e) {
//            Assert.assertTrue(false);
//            mu.switchmenu("home");
//            fu.logoutapp(getInstrumentation());
//        }
//    }

    @Override
    protected void tearDown() throws Exception {
        super.tearDown();
    }
}
