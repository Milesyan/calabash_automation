package com.glow.test.UITest.Matchers;

import android.view.View;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

import static org.hamcrest.Matchers.is;

/**
 * Created by jason on 14-3-18.
 */
public class ViewMatchersForGlow {

    public static int factnum = 0;

    public static Matcher<View> isonthetop(final int num) {
        factnum = factnum + 1;
        return new TypeSafeMatcher<View>() {
            @Override
            public void describeTo(Description description) {
                description.appendText("is onthetop");
            }

            @Override
            public boolean matchesSafely(View view) {
                if(factnum < num){
                    return false;
                }else{
                    factnum = 0;
                    return true;
                }
            }
        };
    }


//    public static Matcher<Toast> withView(Matcher<View> viewMatcher) {
//        return withToast(is(StringToast));
//    }
//    public static Matcher<Toast> withToast(final Matcher<String> StringToast){
//        return new TypeSafeMatcher<Toast>() {
//            @Override
//            public void describeTo(Description description) {
//                description.appendText("is withToast");
//                StringToast.describeTo(description);
//            }
//
//            @Override
//            public boolean matchesSafely(Toast toast) {
//
//                String displayedText = ((TextView)((LinearLayout)toast.getView()).getChildAt(0)).getText().toString();
//                return StringToast.matches(displayedText);
//            }
//        };
//    }

    public static Matcher<View> isduringdispear() {
        return new TypeSafeMatcher<View>() {
            @Override
            public void describeTo(Description description) {
                description.appendText("is onthetop");
            }


            @Override
            public boolean matchesSafely(View view) {
                int tmpnum = 0;
                boolean tmpflag = false;
                int id = view.getId();

                while(tmpnum < 50){

                    try {
                        Boolean flag = id != View.NO_ID && id != 0 && view.getResources() != null
                                && view.isShown();
                        Thread.sleep(200);
                        if(flag == true){
                            tmpflag = true;
                            break;
                        }else{
                            tmpnum = tmpnum + 1;
                        }

                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                return tmpflag;
            }
        };
    }



    public static Matcher<View> isSelected() {

        return new TypeSafeMatcher<View>() {
            @Override
            public void describeTo(Description description) {
                description.appendText("is selected");
            }

            @Override
            public boolean matchesSafely(View view) {
                int id = view.getId();

                return id != View.NO_ID && id != 0 && view.getResources() != null
                        && view.isSelected();
            }
        };
    }



    public static Matcher<View> withResourceName(String resourceName) {
        return withResourceName(is(resourceName));
    }

    public static Matcher<View> withResourceName(final Matcher<String> resourceNameMatcher) {
        return new TypeSafeMatcher<View>() {
            @Override
            public void describeTo(Description description) {
                description.appendText("with resource name: ");
                resourceNameMatcher.describeTo(description);
            }

            @Override
            public boolean matchesSafely(View view) {
                int id = view.getId();
                return id != View.NO_ID && id != 0 && view.getResources() != null
                        && resourceNameMatcher.matches(view.getResources().getResourceName(id));
            }
        };
    }

    public static Matcher<View> withDescription(String resourceName) {
        return withResourceName(is(resourceName));
    }

    public static Matcher<View> withDescription(final Matcher<String> DescriptionMatcher) {
        return new TypeSafeMatcher<View>() {
            @Override
            public void describeTo(Description description) {
                description.appendText("with Description name: ");
                DescriptionMatcher.describeTo(description);
            }

            @Override
            public boolean matchesSafely(View view) {
                int id = view.getId();
                return id != View.NO_ID && id != 0 && view.getResources() != null
                        && DescriptionMatcher.matches(view.getContentDescription());
            }
        };
    }

}
