module BabyHelper

  def date_str(t)
    t.strftime("%Y/%m/%d")
  end
    
  def today
    Time.now
  end

  def wait_touch(query_str)
    wait_for_elements_exist([query_str])
    touch(query_str)
    wait_for_none_animating
  end

  def logout_if_already_logged_in
    sleep 1
    wait_for_none_animating
    if element_exists "UITabBar"
      nav_page.open("Me")
      me_page.logout
    end
  end
end