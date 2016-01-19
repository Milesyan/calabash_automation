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
end