package com.glow.test.UITest.ActivityTest;

import android.test.ActivityInstrumentationTestCase2;
import android.test.suitebuilder.annotation.LargeTest;

import com.glow.android.R;
import com.glow.android.ui.SignUpActivity;
import com.glow.android.ui.signup.BMIPicker;
import com.glow.test.UITest.PageAction.SignupAction;
import com.glow.test.UITest.Utils.FuncUtils;
import com.glow.test.UITest.Utils.PickUtils;
import com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isEnabled;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withEffectiveVisibility;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;


/**
 * Created by jason on 14-3-14.
 */

@LargeTest
@SuppressWarnings("unchecked")
public class SignupTest extends ActivityInstrumentationTestCase2<SignUpActivity> {

    private SignUpActivity signupActivity;
    private BMIPicker bmip;
    private FuncUtils fu = new FuncUtils();
    private PickUtils pu = new PickUtils();
    private SignupAction sa = new SignupAction();

    @SuppressWarnings("deprecation")
    public SignupTest() {
        super("com.glow.android", SignUpActivity.class);
    }

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        signupActivity = getActivity();
        fu.starts(getInstrumentation());
    }

    //Testcaseid 1 signup step 1
    public void testcase1() throws InterruptedException {

        onView(withText(R.string.onboarding_ttc_btn)).perform(click());
        fu.waitformoment();
        //Click the signup button
        //Check the status of next button
        onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE)))).check(matches(not(isEnabled())));

        //Random click the child choose picker
        pu.selectChildrenchoose();

        //Check the status of next button
        onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE)))).check(matches(not(isEnabled())));

        pu.selectActive();

        onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE)))).check(matches(not(isEnabled())));
        //Random enter BMI
        pu.selectBMI();
        fu.waitformoment();
        onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE)))).check(matches(isEnabled()));
        fu.waitformoment();
    }


    //Testcaseid 2 signup step 2
    public void testcase2() throws InterruptedException {

        onView(withText(R.string.onboarding_ttc_btn)).perform(click());
        fu.waitformoment();
        //Click the signup button
        //Check the status of next button
        onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE)))).check(matches(not(isEnabled())));

        //Random click the child choose picker
        pu.selectChildrenchoose();

        //Check the status of next button
        onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE)))).check(matches(not(isEnabled())));

        pu.selectActive();

        onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE)))).check(matches(not(isEnabled())));
        //Random enter BMI
        pu.selectBMI();
        fu.waitformoment();
        onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE)))).check(matches(isEnabled()));
        fu.waitformoment();

        onView(allOf(withText("Next"), is(withEffectiveVisibility(ViewMatchers.Visibility.VISIBLE)))).perform(click());
        pu.selectcycleday();
        fu.waitformoment();
        pu.selectcycledaytoday();
        fu.waitformoment();
    }

//    //Testcaseid 3 signup step 3
//    public void testcase3() throws InterruptedException {
//        fu.registernewuser();
//        fu.waitformoment(10000);
//    }


    @Override
    protected void tearDown() throws Exception {
        super.tearDown();
    }


}
