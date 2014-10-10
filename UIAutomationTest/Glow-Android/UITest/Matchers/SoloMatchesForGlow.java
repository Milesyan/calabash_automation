package com.glow.test.UITest.Matchers;

import com.jayway.android.robotium.solo.Solo;

import static junit.framework.Assert.assertTrue;

/**
 * Created by jason on 14-3-27.
 */
public class SoloMatchesForGlow {


    public void checktoast(String toaststr, Solo solo){
        assertTrue(solo.waitForText("Android and Windows are Selected"));
    }
}
