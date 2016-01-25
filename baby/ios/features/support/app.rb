module BabyHelper

  def date_str(t)
    t.strftime("%Y/%m/%d")
  end
    
  def today
    Time.now
  end

  def wait_touch(query_str)
    begin 
      tries ||= 3
      wait_for_elements_exist([query_str])
      touch(query_str)
      wait_for_none_animating
    rescue Calabash::Cucumber::WaitHelpers::WaitError
      if (tries -= 1) > 0
        close_popup_if_needed
        puts "waiting timed out"
        retry
      else
      end
    end
  end

  def logout_if_already_logged_in
    sleep 1
    wait_for_none_animating
    if element_exists "UITabBar"
      nav_page.open("more")
      me_page.logout
    end
  end

  def close_popup_if_needed
    begin
      wait_for time_out: 3, :retry_frequency => 0.5 do
        element_exists "* id:'icon-close'"
      end
      touch "* id:'icon-close'"
      puts "closed pop-up"
    rescue
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