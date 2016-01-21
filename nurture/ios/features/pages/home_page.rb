require 'calabash-cucumber/ibase'

class HomePage < Calabash::IBase
  def trait
    "*"
  end

  def finish_tutorial
    wait_for_elements_exist("all * marked:'Swipe left or right to navigate through days'", :timeout => 20)
    sleep 1
    #until_element_does_not_exist("all * marked:'Swipe left or right to navigate through days'", action: lambda {flick "UIScrollView", {x:50, y:0}; sleep 1})
    flick "UIScrollView", {x:50, y:0}
    sleep 1
    swipe :down
    wait_for_elements_exist "* marked:'TODAY'", :timeout => 10
    touch "* marked:'TODAY'"
    sleep 1
    wait_for_elements_exist "GLHomeDailyLogEntryCell", :timeout => 10
    touch "GLHomeDailyLogEntryCell"
    wait_for_none_animating
    touch "* id:'back'"
    sleep 1
  end

  def close_insights_popup
    sleep 1
    wait_for(:timeout => 10, :retry_frequency => 1) do
      element_exists "* id:'icon-cancel-shadow'"
    end
    touch "* id:'icon-cancel-shadow'"
  end

  def keyboard_input(n)
    wait_touch "UIKBKeyView index:#{n}"
  end
end