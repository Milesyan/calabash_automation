module BabyHelper

  def embed(x,y=nil,z=nil)
  end
  
  def date_str(t)
    t.strftime("%Y/%m/%d")
  end
    
  def time_str(t)
    t.strftime("%H:%M")
  end

  def today
    Time.now
  end

  def clean_up_page
    forum_page.back_to_home
    app_page.finish_tutorial
  end

  def logout_if_already_logged_in
    sleep 0.5
    clean_up_page
    if element_exists "* id:'tab'"
      app_page.logout
    end
  end

  def wait_touch(query_str)
    wait_for_elements_exist [query_str], :post_timeout => 0.5
    touch query_str
  end

  def touch_if_element_exists(args)
    touch args if element_exists args
  end
  
  def random_str(len = 8)
    ('a'..'z').to_a.shuffle[0,len].join
  end
  
  def random_group_name
    "TestGroup" + ('0'..'9').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-3..-1]
  end
  
end