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

  def logout_if_already_logged_in
    sleep 1
    if element_exists "* id:'tab'"
      me_page.logout
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

   def close_popup_if_needed
    begin
      wait_for time_out: 3, :retry_frequency => 0.5 do
        element_exists "* id:'close_button'"
      end
      touch "* id:'close_button'"
      puts "closed insight pop-up"
    rescue
    end   
  end
end