require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'noah_ios_test'
require_relative 'noah_test_helper'
require 'active_support/all'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NoahTest < Minitest::Test
  include BabyIOS  
  def setup
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def date_str(t)
    t.strftime("%Y/%m/%d")
  end

  def parse_date(date)
    Date.strptime(date, "%Y/%m/%d").to_time
  end

  def create_user
    BabyUser.new.signup
  end

  # Signup
  def test_user_signup
    # by default a new user's gender is F
    u = create_user
    assert_rc u.res
    assert_equal 0, u.res["data"]["babies"].size
    assert_equal u.email, u.res["data"]["user"]["email"]
    assert_equal u.first_name, u.res["data"]["user"]["first_name"]
    assert_equal u.last_name, u.res["data"]["user"]["last_name"]
    assert_equal u.birthday, u.res["data"]["user"]["birthday"]
    assert_equal 0, u.res["data"]["user"]["current_baby_id"]
    assert_equal "F", u.res["data"]["user"]["gender"]
    assert_equal 1, u.res["data"]["user"]["major"]
    assert_equal 0, u.res["data"]["user"]["status"]
    assert_equal 0, u.res["data"]["user"]["tutorial_status"]
    assert_equal 1, u.res["data"]["user"]["receive_push_notification"]
  end

  def test_login_with_nurture_user
    skip("not implemented yet")
  end

  def test_login_with_nurture_user_who_has_partner
    skip("not implemented yet")
  end

  def test_user_becomes_mother
    u = create_user
    baby = u.new_born_baby(relation: "Mother", gender: "M")
    u.add_born_baby(baby)

    assert_rc u.res
    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal u.current_baby.gender, actual_baby["gender"]
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Mother", u.res["data"]["UserBabyRelation"]["update"].first["relation"]
  end

  def test_user_becomes_father
    # by default a new user's gender is F
    # when the user adds a baby as father, gender will change to M
    u = create_user
    baby = u.new_born_baby(relation: "Father", gender: "M")
    u.add_born_baby(baby)

    assert_rc u.res
    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal u.current_baby.gender, actual_baby["gender"]
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Father", u.res["data"]["UserBabyRelation"]["update"].first["relation"]
  end

  def test_signup_with_duplicated_emails_with_correct_password
    u = create_user
    u2 = BabyUser.new.signup(email: u.email, password: u.password)
    assert_equal u.user_id, u2.user_id
  end

  def test_signup_with_duplicated_emails_but_wrong_password
    u = create_user
    u2 = BabyUser.new.signup(email: u.email, password: "wrong_pwd")
    assert_equal 4000101, u2.res["rc"]
    assert_equal "Your email has already been used to create a Glow account.", u2.res["msg"]
  end

  def test_invalid_login_with_wrong_email
    u = create_user
    u.login(email: "wrong_email", password: u.password)
    assert_equal 4000102, u.res["rc"]
    assert_equal "This email and password do not match. Please try again.", u.res["msg"]
  end

  def test_invalid_login_with_wrong_password
    u = create_user
    u.login(email: u.email, password: "wrong_password")
    assert_equal 4000102, u.res["rc"]
    assert_equal "This email and password do not match. Please try again.", u.res["msg"]
  end

  def test_forgot_password
    skip("not implemented yet")
  end

  def test_successful_login
    u = create_user
    user_id = u.user_id
    u.login
    assert_rc u.res
    assert_equal user_id, u.user_id
  end

  def test_login_with_updated_email
    u = create_user
    new_email = "new_" + u.email
    u.change_email(new_email)
    assert_rc u.res
    u.login(email: new_email)
    assert_rc u.res
  end

  def test_change_password_wrong_old_password
    u = create_user
    u.change_password(old: u.password + "wrong", new: "111111")
    assert_equal 4000204, u.res["rc"]
    assert_equal "Sorry, old password is not correct.", u.res["msg"]
  end

  def test_change_password_right_old_password
    u = create_user
    puts u.password
    u.change_password(old: u.password, new: "111111")
    assert_rc u.res
    u.login(email: u.email, password: '111111')
    assert_rc u.res
    assert_equal u.email, u.res["data"]["user"]["email"]
  end

  def test_mother_add_one_born_boy
    u = create_user
    baby = u.new_born_baby(relation: "Mother", gender: "M")
    u.add_born_baby(baby)

    assert_rc u.res
    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal u.current_baby.gender, actual_baby["gender"]
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Mother", u.res["data"]["UserBabyRelation"]["update"].first["relation"]

    u.login
    assert_equal 1, u.res["data"]["babies"].size
  end

  def test_mother_add_one_born_girl
    u = create_user
    baby = u.new_born_baby(relation: "Mother", gender: "F")
    u.add_born_baby(baby)

    assert_rc u.res
    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal u.current_baby.gender, actual_baby["gender"]
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Mother", u.res["data"]["UserBabyRelation"]["update"].first["relation"]

    u.login
    assert_equal 1, u.res["data"]["babies"].size
  end

  def test_mother_add_one_boy_with_birthday_in_far_future
    
  end

  def test_mother_add_one_boy_with_birthday_in_the_far_past
    
  end

  def test_mother_add_two_born_boys
    u = create_user
    baby1 = u.new_born_baby(relation: "Mother", gender: "M")
    u.add_born_baby(baby1)
    baby2 = u.new_born_baby(relation: "Mother", gender: "M")
    u.add_born_baby(baby2)

    baby_res = u.res["data"]["Baby"]["update"].first

    u.login
    assert_equal 2, u.res["data"]["babies"].size
    second_baby = u.babies[1]

    assert_equal second_baby.first_name, u.current_baby.first_name
    assert_equal second_baby.last_name, u.current_baby.last_name
    assert_equal "M", u.current_baby.gender
    assert_equal second_baby.baby_id, u.res["data"]["user"]["current_baby_id"]
  end

  def test_mother_add_two_born_girls
    u = create_user
    baby1 = u.new_born_baby(relation: "Mother", gender: "F")
    u.add_born_baby(baby1)
    baby2 = u.new_born_baby(relation: "Mother", gender: "F")
    u.add_born_baby(baby2)

    baby_res = u.res["data"]["Baby"]["update"].first

    u.login
    assert_equal 2, u.res["data"]["babies"].size
    second_baby = u.babies[1]

    assert_equal second_baby.first_name, u.current_baby.first_name
    assert_equal second_baby.last_name, u.current_baby.last_name
    assert_equal "F", u.current_baby.gender
    assert_equal second_baby.baby_id, u.res["data"]["user"]["current_baby_id"]
  end

  def test_mother_add_one_born_boy_and_one_born_girl
    u = create_user
    baby1 = u.new_born_baby(relation: "Mother", gender: "M")
    u.add_born_baby(baby1)
    baby2 = u.new_born_baby(relation: "Mother", gender: "F")
    u.add_born_baby(baby2)

    baby_res = u.res["data"]["Baby"]["update"].first

    u.login
    assert_equal 2, u.res["data"]["babies"].size
    second_baby = u.babies[1]

    assert_equal second_baby.first_name, u.current_baby.first_name
    assert_equal second_baby.last_name, u.current_baby.last_name
    assert_equal "F", u.current_baby.gender
    assert_equal second_baby.baby_id, u.res["data"]["user"]["current_baby_id"]
  end

  def test_father_add_two_born_boys
    u = create_user
    baby1 = u.new_born_baby(relation: "Father", gender: "M")
    u.add_born_baby(baby1)
    baby2 = u.new_born_baby(relation: "Father", gender: "M")
    u.add_born_baby(baby2)

    baby_res = u.res["data"]["Baby"]["update"].first

    u.login
    assert_equal 2, u.res["data"]["babies"].size
    second_baby = u.babies[1]

    assert_equal second_baby.first_name, u.current_baby.first_name
    assert_equal second_baby.last_name, u.current_baby.last_name
    assert_equal "M", u.current_baby.gender
    assert_equal second_baby.baby_id, u.res["data"]["user"]["current_baby_id"]
  end

  def test_father_add_two_born_girls
    u = create_user
    baby1 = u.new_born_baby(relation: "Father", gender: "F")
    u.add_born_baby(baby1)
    baby2 = u.new_born_baby(relation: "Father", gender: "F")
    u.add_born_baby(baby2)

    baby_res = u.res["data"]["Baby"]["update"].first

    u.login
    assert_equal 2, u.res["data"]["babies"].size
    second_baby = u.babies[1]

    assert_equal second_baby.first_name, u.current_baby.first_name
    assert_equal second_baby.last_name, u.current_baby.last_name
    assert_equal "F", u.current_baby.gender
    assert_equal second_baby.baby_id, u.res["data"]["user"]["current_baby_id"]
  end

  def test_father_add_one_born_boy_and_one_born_girl
    u = create_user
    baby1 = u.new_born_baby(relation: "Father", gender: "M")
    u.add_born_baby(baby1)
    baby2 = u.new_born_baby(relation: "Father", gender: "F")
    u.add_born_baby(baby2)

    baby_res = u.res["data"]["Baby"]["update"].first

    u.login
    assert_equal 2, u.res["data"]["babies"].size
    second_baby = u.babies[1]

    assert_equal second_baby.first_name, u.current_baby.first_name
    assert_equal second_baby.last_name, u.current_baby.last_name
    assert_equal "F", u.current_baby.gender
    assert_equal second_baby.baby_id, u.res["data"]["user"]["current_baby_id"]
  end

  def test_mother_invites_father
    u = create_user
    baby = u.new_born_baby(relation: "Mather", gender: "M")
    u.add_born_baby(baby)
    partner = BabyUser.new
    u.invite_family partner: partner, relation: "Father"
    assert_rc u.res
    # u.res["data"]["UserBabyRelation"]["update"] should have 2 items, one for self, the other for partner
    partner_relation = u.res["data"]["UserBabyRelation"]["update"].select { |v| v["relation"] == "Father"}
    partner_relation_update = partner_relation.first # should be only one
    
    assert_equal "Father", partner_relation_update["relation"]
    assert_equal partner.user_id, partner_relation_update["user_id"]
    assert_equal "#{partner.user_id}_#{u.current_baby.baby_id}", partner_relation_update["user_baby_id"].to_s

    partner.signup user: partner
    params = partner.res["data"]["babies"].first["Baby"].symbolize_keys

    baby = Baby.new(params)
    assert_equal u.current_baby.baby_id, baby.baby_id
  end

  def test_father_invites_mother
    u = create_user
    baby = u.new_born_baby(relation: "Father", gender: "M")
    u.add_born_baby(baby)

    partner = BabyUser.new
    u.invite_family partner: partner, relation: "Mather"
    assert_rc u.res

    partner_relation = u.res["data"]["UserBabyRelation"]["update"].select { |v| v["relation"] == "Mather"}
    partner_relation_update = partner_relation.first

    assert_equal "Mather", partner_relation_update["relation"]
    assert_equal partner.user_id, partner_relation_update["user_id"]
    assert_equal "#{partner.user_id}_#{u.current_baby.baby_id}", partner_relation_update["user_baby_id"].to_s

    # validate partner's baby after sign up
    partner.signup user: partner
    params = partner.res["data"]["babies"].first["Baby"].symbolize_keys

    baby = Baby.new(params)
    assert_equal u.current_baby.baby_id, baby.baby_id

  end

  def test_mother_add_one_upcoming_baby
    u = create_user
    baby = u.new_upcoming_baby(relation: "Mother")
    u.add_upcoming_baby(baby)
    assert_rc u.res

    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal "", actual_baby["gender"] # no gender
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Mother", u.res["data"]["UserBabyRelation"]["update"].first["relation"]

    # add the login steps here

  end

  def test_father_add_one_upcoming_baby
    u = create_user
    baby = u.new_upcoming_baby(relation: "Father")
    u.add_upcoming_baby(baby)
    assert_rc u.res

    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal "", actual_baby["gender"] # no gender
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Father", u.res["data"]["UserBabyRelation"]["update"].first["relation"]
  end

  def test_father_add_two_upcoming_babies
    u = create_user
    baby1 = u.new_upcoming_baby(relation: "Father")
    u.add_upcoming_baby(baby1)
    assert_rc u.res

    baby2 = u.new_upcoming_baby(relation: "Father")
    u.add_upcoming_baby(baby2)
    assert_rc u.res

    u.pull
    assert_equal 2, u.res["data"]["babies"].size
    assert_equal baby2.baby_id, u.current_baby.baby_id
  
  end

  def test_mother_add_three_upcoming_babies
    u = create_user
    baby1 = u.new_upcoming_baby(relation: "Mother")
    u.add_upcoming_baby(baby1)
    assert_rc u.res

    baby2 = u.new_upcoming_baby(relation: "Mother")
    u.add_upcoming_baby(baby2)
    assert_rc u.res

    baby3 = u.new_upcoming_baby(relation: "Mother")
    u.add_upcoming_baby(baby3)
    assert_rc u.res

    u.pull
    assert_equal 3, u.res["data"]["babies"].size
    assert_equal baby3.baby_id, u.current_baby.baby_id
  end

  def test_mother_disconnect_father
    u = create_user
    baby = u.new_born_baby(relation: "Mother")
    u.add_born_baby(baby)

    partner = BabyUser.new
    u.invite_family partner: partner, relation: "Father"
    partner.signup user: partner
    assert_equal 1, partner.res["data"]["babies"].size

    u.disconnect(baby, partner)
    assert_rc u.res

    # partner.login
    # assert_equal 0, partner.res["data"]["babies"].size
  end

  def test_mother_disconnect_pending_father
    u = create_user
    baby = u.new_born_baby(relation: "Mother")
    u.add_born_baby(baby)

    partner = BabyUser.new
    u.invite_family partner: partner, relation: "Father"

    u.disconnect(baby, partner)
    assert_rc u.res

    partner.signup user: partner
    assert_equal 0, partner.res["data"]["babies"].size
  end

  def test_add_bottle_feed
    u = create_user
    baby = u.new_born_baby relation: "Mother"
    u.add_born_baby(baby)
    feed = u.new_feed start_time: 15.minutes.ago
    u.add_feed(feed)
  end

  def test_add_bottle_feed_yesterday
    u = create_user
    baby = u.new_born_baby relation: "Mother", birthday: date_str(10.days.ago)
    u.add_born_baby(baby)
    feed = u.new_feed start_time: 25.hours.ago
    u.add_feed(feed)
  end

  def test_add_sleep_today
    u = create_user
    baby = u.new_born_baby relation: "Mother", birthday: date_str(10.days.ago)
    u.add_born_baby(baby)
    sleep = u.new_sleep start_time: 3.hours.ago, end_time: 1.minute.ago
    u.add_sleep(sleep)
  end

  def test_add_sleep_yesterday
    u = create_user
    baby = u.new_born_baby relation: "Mother", birthday: date_str(10.days.ago)
    u.add_born_baby(baby)
    sleep = u.new_sleep start_time: 30.hours.ago, end_time: 15.hours.ago
    u.add_sleep(sleep)
  end

  def test_add_diaper_today
    
  end

  def test_add_diaper_yesterday
    
  end

  def test_update_baby_profile
    u = create_user
    baby = u.new_born_baby relation: "Father", birthday: date_str(Date.today), birth_due_date: date_str(Date.today)
    u.add_born_baby(baby)

    baby.first_name += " updated"
    baby.last_name += " updated"

    new_birthday = parse_date(baby.birthday).days_ago(3)
    baby.birthday = date_str(new_birthday)

    new_birth_due_date = parse_date(baby.birthday).days_ago(5)
    baby.birth_due_date = new_birth_due_date

    baby.birth_weight = 2.5
    baby.birth_height = 40.0
    baby.birth_headcirc = 30.0

    u.update_baby_profile(baby)
    assert_rc u.res
    sleep 1
    u.pull
    res_baby = u.res["data"]["babies"].first["Baby"]["update"].detect {|b| b["baby_id"] == u.current_baby.baby_id }
    params = res_baby.symbolize_keys
    updated_baby = Baby.new(params)
    assert_equal baby.first_name, updated_baby.first_name
    assert_equal baby.last_name, updated_baby.last_name
    assert_equal baby.birthday, updated_baby.birthday
    assert_equal baby.birth_due_date, updated_baby.birth_due_date
    assert_equal baby.birth_height, updated_baby.birth_height
    assert_equal baby.birth_weight, updated_baby.birth_weight
    assert_equal baby.birth_headcirc, updated_baby.birth_headcirc
  end

  def test_update_email
    u = create_user
    new_email = "new_" + u.email
    u.change_email(new_email)
    assert_rc u.res
  end

  def test_turn_off_notifications
    u = create_user
    u.turn_off_push_notification
    assert_rc u.res
    sleep 2
    u.pull
    assert_equal 0, u.res["data"]["user"]["User"]["update"].first["receive_push_notification"]
  end

  def test_edit_my_own_profile
    skip("not implemented yet")
  end

  def test_text_instructions
    skip("not implemented yet")
  end

end