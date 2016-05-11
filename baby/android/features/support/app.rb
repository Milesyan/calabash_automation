module BabyHelper
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
  
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def red(text); colorize(text, 31); end
  def green(text); colorize(text, 32); end
  def yellow(text); colorize(text, 33); end
  def blue(text); colorize(text, 34); end
  def magenta(text); colorize(text, 35); end
  def cyan(text); colorize(text, 36); end
  def yellow_background(text); colorize(text, 43); end
  def magenta_background(text); colorize(text, 45); end
  def exchange_foreground_and_background(text); colorize(text, 7); end
  def light_red(text); colorize(text, 91); end

  def log_msg(msg)
    puts magenta(msg)
  end

  def log_error(msg)
    puts light_red(msg)
  end
end