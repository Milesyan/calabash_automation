require 'calabash-android/cucumber'
require 'active_support/all'

require_relative 'app'
require_relative 'pages'
require_relative 'user'
require_relative '../../../www/nurture_android_forum_test'

include NurtureForumAndroid
include NurtureHelper

ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
