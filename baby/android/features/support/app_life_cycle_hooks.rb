require 'calabash-android/management/adb'
require 'calabash-android/operations'

Before do |scenario|
  start_test_server_in_background
    logger.start
end

After do |scenario|
  if scenario.failed?
    screenshot_embed
  end
  logger.stop
  # logger.pull_log(user: $user).pretty
  # logger.diff
  # logger.clear
  shutdown_test_server
end
