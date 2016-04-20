require 'calabash-cucumber/launcher'


Before do |scenario|
  @calabash_launcher = Calabash::Cucumber::Launcher.new
  @calabash_launcher.relaunch
  @calabash_launcher.calabash_notify(self)   
end

After do |scenario|
  unless @calabash_launcher.calabash_no_stop? 
    puts "EXIT APP"
    calabash_exit
  end
end

at_exit do
end

