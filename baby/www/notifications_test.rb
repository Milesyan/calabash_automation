require 'minitest/autorun'
require 'minitest/reporters'
require "google/api_client"
require "google_drive"
require "smarter_csv"
require_relative 'noah_ios_test'
require_relative 'noah_test_helper'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class BabyDevelopmentTest < Minitest::Test
  include BabyIOS
  include BabyTestHelper
  
  attr_accessor :csv, :user_control_notifications

  def setup
    @csv = SmarterCSV.process('./data/baby_notifications.csv')
  end

  def create_user
    BabyUser.new.signup
  end

  def set_time_zone()
    
  end

  def import_notifications
    session = GoogleDrive.saved_session("config/config.json")
    ws = session.spreadsheet_by_key("1AJyHDNIRQbeMZGLwDmxUV4q-C-PS3JCSTsNjT6ZJz24").worksheets[0]
    ws.export_as_file "data/baby_notifications.csv"
  end

  def test_true
    assert true
  end

  def test_csv
    #puts @csv[1][:user_control].to_s.downcase
    @user_control_notifications = @csv.select { |n| n[:user_control].to_s.downcase == "yes" }
    @user_control_notifications.each do |un|
      puts un[:logic]
    end
  end

  def test_baby
    u = create_user
    baby = u.new_born_baby relation: "Mother", birthday: date_str(2.days.ago)
    u.add_born_baby(baby)
  end


end