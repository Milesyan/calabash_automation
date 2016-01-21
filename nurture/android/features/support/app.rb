module NurtureHelper
  def date_str(t)
    t.strftime("%Y/%m/%d")
  end
    
  def time_str(t)
    t.strftime("%H:%M")
  end

  def today
    Time.now
  end

  def logout_if_already_logged_in
    sleep 1
    if element_exists "* id:'tab'"
      nav_page.logout
    end
  end

  def wait_touch(query_str)
    sleep 1
    wait_for_elements_exist([query_str])
    touch(query_str)
  end
  
  def random_str(len = 8)
    ('a'..'z').to_a.shuffle[0,len].join
  end
end