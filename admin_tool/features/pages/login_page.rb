class LoginPage
  def login(email, password)
    fill_in "login-username", with: email
    fill_in "login-password", with: password
    sleep 1
    click_on "Login"
    sleep 1
  end
end