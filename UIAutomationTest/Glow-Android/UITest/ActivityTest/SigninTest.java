package com.glow.test.UITest.ActivityTest;

import android.test.ActivityInstrumentationTestCase2;
import android.test.suitebuilder.annotation.LargeTest;

import com.glow.android.ui.SignInActivity;
import com.glow.test.UITest.Utils.FuncUtils;
import com.glow.test.UITest.Utils.SinginUtils;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isDisplayed;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.containsString;


/**
 * Created by jason on 14-3-18.
 */
@LargeTest
public class SigninTest extends ActivityInstrumentationTestCase2<SignInActivity> {

    private SignInActivity signinActivity;
    private FuncUtils fu = new FuncUtils();
    private SinginUtils su = new SinginUtils();

    @SuppressWarnings("deprecation")
    public SigninTest() {
        super("com.glow.android", SignInActivity.class);
    }

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        signinActivity = getActivity();
        fu.starts(getInstrumentation());
    }


    //    Testcaseid 4 signin the app
    public void testcase4() throws InterruptedException {
        su.setinfo();
        fu.waitformoment(10000);
        onView(withText("Today's important tasks")).check(matches(withText(containsString("Today's important tasks"))));
    }


    //Testcaseid 5 forget password with registered Email
    public void testcase5() throws InterruptedException {
        su.forgetpassword("jason+00001@upwlabs.com");
        fu.waitformoment(10000);
//        Toaster verify

    }

    //Testcaseid 6 forget password with unregistered Email
    public void testcase6() throws InterruptedException {
        su.forgetpassword("jason+10002@upwlabs.com");
        fu.waitformoment(10000);
        onView(withText("Email not registered")).check(matches(isDisplayed()));
    }


    @Override
    protected void tearDown() throws Exception {
        super.tearDown();
    }
}
