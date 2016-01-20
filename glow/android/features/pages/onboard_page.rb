require 'calabash-android/abase'
class OnboardPage < Calabash::ABase

  def trait
    #"* id:'partner_sign_up'"
    "*" 
  end

  def tap_login
    puts "TOUCH LOGIN HERE "
    touch "* id:'log_in'"
  end
end