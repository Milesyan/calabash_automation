require 'calabash-cucumber/ibase'

class HomePage < Calabash::IBase
  def trait
    "*"
  end

  def keyboard_input(n)
    wait_touch "UIKBKeyView index:#{n}"
  end
end