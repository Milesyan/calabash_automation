require 'calabash-android/management/adb'
require 'calabash-android/operations'

Before do |scenario|
  # logger.start
  sleep 0.5
  start_test_server_in_background
end

After do |scenario|
  if scenario.failed?
    screenshot_embed
  end
  shutdown_test_server
  sleep 0.3
  # logger.stop
  # logger.pull_log(user:$user).pretty
  # logger.diff
  # logger.clear
end
