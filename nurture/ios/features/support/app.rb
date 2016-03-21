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

  def random_group_name
    "TestGroup" + ('0'..'9').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-3..-1]
  end
  

  def logout_if_already_logged_in
    common_page.close_chat_popup
    if element_exists "all * marked:'Swipe left or right to navigate through days'"
      puts "TUTORIAL IN LOGOUT PROCESS"
      common_page.finish_tutorial
    end
    common_page.close_chat_popup
    sleep 2
    if element_exists "UITabBarButton"
      common_page.open("Me")
      common_page.logout
    end
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
  def sky_blue(text); colorize(text, 95); end

  def log_msg(msg)
    puts magenta(msg)
  end

  def log_error(msg)
    puts light_red(msg)
  end
  
  def puts_m(msg)
    puts sky_blue(msg)
  end

  def puts_n(msg)
    puts yellow_background(msg)
  end

end