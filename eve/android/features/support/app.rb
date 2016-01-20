require 'yaml'

module Glow
  def load_yamls
    fixtures_folder = File.expand_path("../fixtures", File.dirname(__FILE__))
    Dir[File.join(fixtures_folder, '*.yml')].map {|f| [File.basename(f, '.yml').to_s, YAML.load_file(f)]}
  end


  def already_logged_in?
    element_exists "android.support.design.widget.by"
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
end