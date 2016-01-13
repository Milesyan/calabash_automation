require 'calabash-cucumber/ibase'
class MePage < Calabash::IBase


  def trait
    "*"
  end

  def open_settings
    wait_touch "* marked:'Account settings'"
  end


  def await
    wait_for(:timeout => 10, :retry_frequency => 2) do
      tab_bar_page.open "me"
      element_exists "* marked:'Tell friends about Glow Baby'"
    end
    self
  end
end