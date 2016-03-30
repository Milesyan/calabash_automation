require 'calabash-android/cucumber'
require 'active_support/all'

require_relative 'app'
require_relative 'pages'
require_relative 'user'
require_relative '../../../www/public/noah_android_forum_test'
require_relative 'event_logger.rb'


include BabyAndroid
include NoahForumAndroid
include GlowLogger
include BabyHelper

ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
