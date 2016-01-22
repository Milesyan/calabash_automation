require 'yaml'

module Glow
  def load_yamls
    fixtures_folder = File.expand_path("../fixtures", File.dirname(__FILE__))
    Dir[File.join(fixtures_folder, '*.yml')].map {|f| [File.basename(f, '.yml').to_s, YAML.load_file(f)]}
  end

  def get_email
    "a#{Time.now.to_i}@g.com"
  end

  def random_group_name
    "TestGroup" + ('0'..'9').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-3..-1]
  end
  
  def already_logged_in?
    element_exists "android.support.v7.widget.ActionMenuPresenter$OverflowMenuButton"
  end

  def logout_if_already_logged_in
    sleep 1
    wait_for_elements_do_not_exist("* id:'loading_view'", :timeout => 30)
    toolbar_page.logout if already_logged_in?
  end

  def wait_touch(query_str)
    sleep 1
    wait_for_elements_exist([query_str])
    touch(query_str)
  end
  
  def relaunch_app
    launcher = Calabash::Cucumber::Launcher.new
    launcher.relaunch(:reset => true)
  end

  def push_app_to_background(n)
    send_app_to_background(n)
  end

  def random_str(len = 8)
    ('a'..'z').to_a.shuffle[0,len].join
  end

  def is_ft_user?(type)
    ["prep", "med", "iui", "ivf"].include? type.downcase
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