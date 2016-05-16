require 'yaml'

module Glow
  def load_yamls
    fixtures_folder = File.expand_path("../fixtures", File.dirname(__FILE__))
    Dir[File.join(fixtures_folder, '*.yml')].map {|f| [File.basename(f, '.yml').to_s, YAML.load_file(f)]}
  end

  def get_email
    "i#{Time.now.to_i}@g.com"
  end

  def already_logged_in?
    element_exists "UITabBar"
  end

  def tutorial_finished?
    element_does_not_exist "* marked:'Swipe left or right to see different days'"
  end

  def logout_if_already_logged_in
    sleep 1
    unless tutorial_finished?
      home_page.finish_tutorial
    end
    
    if already_logged_in?
      tab_bar_page.open("me")
      me_page.open_settings
      settings_page.logout
    end
  end

  def close_premium_popup_if_needed
    begin
      wait_for time_out: 3, :retry_frequency => 0.5 do
        element_exists "* id:'sk-cross-close'"
      end
      touch "* id:'sk-cross-close'"
      puts "closed premium pop-up"
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

  def wait_touch(query_str)
    wait_for_elements_exist([query_str])
    touch(query_str)
    wait_for_none_animating
  end

  def relaunch_app
    launcher = Calabash::Cucumber::Launcher.new
    launcher.relaunch(:reset => true)
  end

end