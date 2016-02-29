
def logout_if_already_logged_in
  sleep 1
  el = first('nav#sidebar')
  page.execute_script("angular.element('#header-navbar').scope().logout();") unless el.nil?
  sleep 1
end