require 'calabash-android/cucumber'
require 'active_support/all'

require_relative 'app'
require_relative 'pages'
require_relative 'user'
require_relative '../../../www/noah_android_forum_test'

include BabyAndroid
include NoahForumAndroid
include BabyHelper

ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
