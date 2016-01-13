require 'calabash-cucumber/ibase'
class MePage < Calabash::IBase


  def trait
    "*"
  end
  def await
    wait_for(:timeout => 10, :retry_frequency => 2) do
      close_invite_partner_popup
      tab_bar_page.open "me"
      element_exists "* marked:'Tell friends about Glow Baby'"
    end
    self
  end
end