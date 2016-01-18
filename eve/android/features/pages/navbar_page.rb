require 'calabash-android/abase'

class NavbarPage < Calabash::ABase
  def trait
    "AppCompatImageView"
  end

  def open(page)
    sleep 1
    case page.downcase
    when 'home'
      touch "AppCompatImageView index:0"
    when 'community'
      touch "AppCompatImageView index:1"
    when 'alert'
      touch "AppCompatImageView index:2"
    when 'me'
      touch "AppCompatImageView index:3"
    end
  end

end