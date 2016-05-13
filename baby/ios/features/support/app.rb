require 'yaml'

module Baby

  def embed(x,y=nil,z=nil)
  end
  
  def get_email
    "i#{Time.now.to_i}@g.com"
  end

  def random_group_name
    "TestGroup" + ('0'..'9').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-3..-1]
  end

  def already_logged_in?
    element_exists "UITabBar"
  end

  def clean_up_page
    forum_page.back_to_home
    app_page.pass_sso
    app_page.finish_tutorial
  end

  def touch_if_element_exists(args)
    touch args if element_exists args
  end
  
  def logout_if_already_logged_in
    sleep 0.5
    clean_up_page
    if already_logged_in?
      app_page.open("me")
      app_page.open_settings
      app_page.logout
    end
  end

  def wait_touch(query_str)
    wait_for_elements_exist [query_str], :post_timeout => 0.5
    begin
      wait_for_none_animating :timeout  => 3
    rescue RuntimeError
      log_error "touch #{query_str} animation not finished."
    end
    touch(query_str)
    wait_for_none_animating :timeout  => 10
  end

  def relaunch_app
    launcher = Calabash::Cucumber::Launcher.new
    launcher.relaunch(:reset => true)
  end

end