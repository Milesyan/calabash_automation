module Eve
  def wait_touch(query_str)
    wait_for_elements_exist [query_str], :post_timeout => 0.5
    touch query_str
    wait_for_none_animating :timeout => 30
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
  
  def already_logged_in?
    element_exists "UITabBar"
  end

  def back_to_home
    counter = 0
    while element_exists("* marked:'Back'") ||
      element_exists("* marked:'Done'") ||
      element_exists("* marked:'Close'") ||
      element_exists("* marked:'Cancel'") ||
      element_exists("* id:'gl-foundation-popup-close'")||
      element_exists("* id:'gl-community-back.png'")||
      element_exists("* marked:'OK'") do
      touch "* marked:'Back'" if element_exists "* marked:'Back'"
      touch "* marked:'Close'" if element_exists "* marked:'Close'"
      touch "* marked:'Cancel'" if element_exists "* marked:'Cancel'"
      touch "* marked:'Done'" if element_exists "* marked:'Done'"
      touch "* id:'gl-foundation-popup-close'" if element_exists "* id:'gl-foundation-popup-close'"
      touch "* id:'gl-community-back.png'" if element_exists "* id:'gl-community-back.png'"
      touch "* marked:'OK'" if element_exists "* marked:'OK'"
      counter += 1
      break if counter > 3
    end
    sleep 1
  end

  def clean_up_page
    back_to_home
    app_page.pass_sso
    app_page.finish_tutorial
  end

  def logout_if_already_logged_in
    clean_up_page
    if already_logged_in?
      app_page.open("Me")
      app_page.logout
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

  def log_msg(msg)
    puts magenta(msg)
  end

  def log_error(msg)
    puts light_red(msg)
  end
  
end