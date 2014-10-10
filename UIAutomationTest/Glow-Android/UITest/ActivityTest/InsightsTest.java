package com.glow.test.UITest.ActivityTest;

import android.test.ActivityInstrumentationTestCase2;
import android.util.Log;

import com.glow.android.R;
import com.glow.android.ui.SignInActivity;
import com.glow.test.UITest.ActionsGlow.SwipeGlow;
import com.glow.test.UITest.Utils.FuncUtils;
import com.glow.test.UITest.Utils.MenuUtils;
import com.glow.test.UITest.Utils.SinginUtils;
import com.google.android.apps.common.testing.ui.espresso.Espresso;
import com.jayway.android.robotium.solo.Solo;

import junit.framework.Assert;

import static com.glow.test.UITest.Matchers.ViewMatchersForGlow.isonthetop;
import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isDisplayed;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.is;

/**
 * Created by jason on 14-4-4.
 */
public class InsightsTest extends ActivityInstrumentationTestCase2<SignInActivity> {

    private SignInActivity signinactivity;
    private FuncUtils fu = new FuncUtils();
    private SinginUtils su = new SinginUtils();
    private MenuUtils mu = new MenuUtils();
    private SwipeGlow sg = new SwipeGlow();
    private Solo solo;
//    private Solo solo;

    @SuppressWarnings("deprecation")
    public InsightsTest() {
        super("com.glow.android", SignInActivity.class);
    }

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        signinactivity = getActivity();
        fu.starts(getInstrumentation());
        solo = new Solo(getInstrumentation(), getActivity());
    }

    //Testcase 73 Insights page show
    public void testcase73(){
        try{
            su.setinfo();
            fu.waitformoment(10000);

            onView(withId(R.id.action_notification)).perform(click());
            fu.waitformoment();
            onView(allOf(withText("Notifications"), is(isonthetop(1)))).check(matches(isDisplayed()));
            onView(allOf(withText("Insights"), is(isonthetop(1)))).check(matches(isDisplayed()));
            Espresso.pressBack();
            fu.logoutapp(getInstrumentation());
        }catch (Exception e){
            fu.logoutapp(getInstrumentation());
            Log.e("Insights Test", e.getMessage());
            Assert.assertTrue(false);
        }
    }

    @Override
    protected void tearDown() throws Exception {
        super.tearDown();

    }


}
