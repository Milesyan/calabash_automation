module Nurture
  def wait_touch(query_str)
    wait_for_elements_exist([query_str])
    touch(query_str)
    wait_for_none_animating
  end

  def touch_if_elements_exist(query_str)
    sleep 1
    touch query_str if element_exists(query_str)
  end

  def get_email
    "ni#{Time.now.to_i}@g.com"
  end

  def close_premium_popup_if_necessary
    onboard_page.close_premium_popup
  end

  def finish_tutorial_if_necessary  
    home_page.finish_tutorial if tutorial_popup?
  end

  def logout_if_already_logged_in
    sleep 1
    if element_exists "UITabBarButton"
      nav_page.open("Me")
      me_page.logout
    end
  end

  def tutorial_popup?
    #element_exists "all * marked:'Swipe left or right to navigate through days'"
    sleep 2
    element_exists "all * marked:'Here\\'s how you use Glow Nurture!'"
  end
end