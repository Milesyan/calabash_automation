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

  def logout_if_already_logged_in
    sleep 2
    if element_exists "UITabBarButton"
      nav_page.open("Me")
      me_page.logout
    end
  end
end