package com.glow.test.UITest.Utils;


import com.glow.android.R;
import com.glow.test.UITest.Matchers.RootMatchersForGlow;

import java.util.Random;

import static com.glow.test.UITest.Matchers.ViewMatchersForGlow.isonthetop;
import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.typeText;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isChecked;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isEnabled;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;


/**
 * Created by jason on 14-3-17.
 */
public class PickUtils {

    private FuncUtils fu = new FuncUtils();

    public void selectChildrenchoose(){
        String [] choosestring = {"No, not trying","Trying for 1st child","Trying for 2nd child","Trying for 3rd child","Trying for 4th child"};
        Random r = new Random();
        String choose = choosestring[r.nextInt(4)];
        onView(withId(R.id.children_count_picker)).perform(click());

        onView(withText(choose)).perform(click());
        if(choose != "No, not trying"){
            fu.waitformoment();
            onView(withId(R.id.ttc_length_text_view)).perform(click());
            onView(withText("Set")).perform(click());
        }else{

        }
    }

    public void selectBMI(){
        onView(withId(R.id.bmi_calculator)).perform(click());
        onView(withId(R.id.unit_spinner)).perform(click());
        onView(withText("KG/CM")).inRoot(RootMatchersForGlow.iswindowsfocus())
                .perform(click());
        onView(withId(R.id.kg_editor)).perform(typeText("65"));
        onView(withId(R.id.cm_editor)).perform(typeText("165"));
        onView(withText("Set")).perform(click());
    }

    public void selectcycleday(){
        onView(withId(R.id.cycle_length)).perform(click());
        onView(withText("25 days")).perform(click());
    }

    public void selectActive(){
        onView(withId(R.id.physical_activity_text_view)).perform(click());
        onView(withText("Very active (60+ mins daily average)")).perform(click());

    }


    public void fillinuserinfo(){
        String tmpstr = fu.getrandomemail(15);
        onView(withId(R.id.email)).perform(typeText("jason+"+tmpstr+"@upwlabs.com"));
        onView(withText("Done")).check(matches(not(isEnabled())));
        onView(withId(R.id.full_name)).perform(typeText("jason" + tmpstr));
        onView(withText("Done")).check(matches(not(isEnabled())));
        onView(withId(R.id.password)).perform(typeText("hui130124"));
        onView(withText("Done")).check(matches(not(isEnabled())));
        onView(withId(R.id.birthday)).perform(click());
        onView(withText("Done")).perform(click());
        onView(withId(R.id.female)).perform(click());
        onView(withId(R.id.female)).check(matches(isChecked()));
        onView(withText("Done")).check(matches(isEnabled()));
    }

    public void selectcycledaytoday(){
        onView(withId(R.id.first_pb)).perform(click());
        onView(withText("Today")).perform(click());
        fu.waitformoment(2000);
        onView(allOf(withText("Done"), is(isonthetop(1))))
                .perform(click());
    }



}
