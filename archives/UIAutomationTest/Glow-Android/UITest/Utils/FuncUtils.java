package com.glow.test.UITest.Utils;

import android.app.Instrumentation;
import android.content.Context;

import com.glow.android.R;
import com.jayway.android.robotium.solo.Solo;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;
import java.util.Random;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.Espresso.openActionBarOverflowOrOptionsMenu;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isEnabled;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.not;


/**
 * Created by jason on 14-3-17.
 */

public class FuncUtils {

    private static final PickUtils pu = new PickUtils();

    private static final SimpleDateFormat UI_FORMATTER = new SimpleDateFormat("MMM d, yyyy");
    public void waitformoment(){
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public boolean solo_searchText(Solo solo,String text){
        return solo.searchText(text);
    }

    public void solo_goback(Solo solo){
        solo.goBack();
    }

    public void waitformoment(long time){
        try {
            Thread.sleep(time);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public String getrandomemail(int length){
        String str = "abcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuffer buf = new StringBuffer();
        for (int i = 0; i < length; i++) {
            int num = random.nextInt(36);
            buf.append(str.charAt(num));
        }
        return buf.toString();
    }

    public void logoutapp(Instrumentation instrumentation){
        try {
            openActionBarOverflowOrOptionsMenu(instrumentation.getTargetContext());
            onView(withText("Log out")).perform(click());
        }catch(Exception e){

        }
    }

    public void registernewuser(){
        waitformoment();

        //Check the status of next button
        onView(withId(R.id.next_action)).check(matches(not(isEnabled())));

        //Random click the child choose picker
        pu.selectChildrenchoose();

        //Check the status of next button
        onView(withId(R.id.next_action)).check(matches(not(isEnabled())));

        pu.selectcycleday();

        onView(withId(R.id.next_action)).check(matches(not(isEnabled())));

        //Random enter BMI
        pu.selectBMI();
        waitformoment();
        onView(withId(R.id.next_action)).check(matches(isEnabled()));

        onView(withId(R.id.next_action)).perform(click());

        waitformoment();
        pu.selectcycledaytoday();
        waitformoment();

        pu.fillinuserinfo();
        onView(withText("Done")).perform(click());

    }

    public String daystr(int date){
        Calendar cal=Calendar.getInstance();
        cal.add(cal.DATE,date);
        String weekDayStr = cal.getDisplayName(
                Calendar.DAY_OF_WEEK, Calendar.SHORT, Locale.getDefault());
        int intDay = cal.get(Calendar.DAY_OF_MONTH);
        String datestr = String.format("%s %d", weekDayStr, intDay);
        return datestr;
    }


    public String weekdaystr(int date){
        Calendar cal=Calendar.getInstance();
        cal.add(cal.DATE,date);
        String weekDayStr = cal.getDisplayName(
                Calendar.DAY_OF_WEEK, Calendar.SHORT, Locale.getDefault());
        int intDay = cal.get(Calendar.DAY_OF_MONTH);
        String datestr = String.format("%s", weekDayStr);
        return datestr;
    }

    public String monthdaystr(int date){
        Calendar cal=Calendar.getInstance();
        cal.add(cal.DATE,date);
        String weekDayStr = cal.getDisplayName(
                Calendar.DAY_OF_WEEK, Calendar.SHORT, Locale.getDefault());
        int intDay = cal.get(Calendar.DAY_OF_MONTH);
        String datestr = String.format("%d",intDay);
        return datestr;
    }


    public void actiontoday(){
        try{
            onView(withId(R.id.action_to_today)).perform(click());
        }catch (Exception e){

        }
    }

    public String getdateinfo(int date,Context context){
        Calendar calendar=Calendar.getInstance();
        calendar.add(Calendar.DATE, date);
        String dateinfo = UI_FORMATTER.format(calendar.getTime());
        String info = context.getString(R.string.home_important_tasks_other_day_caption, dateinfo);
        return info;
    }



    public void sendkeys(){



    }

    public void cleanup(){
//        android.os.Process.killProcess(android.os.Process.myPid());
    }

    public void starts(Instrumentation instrumentation){
        try {
            waitformoment(5000);
            openActionBarOverflowOrOptionsMenu(instrumentation.getTargetContext());
            onView(withText("Log out")).perform(click());
        }catch(Exception e){

        }

    }

}
