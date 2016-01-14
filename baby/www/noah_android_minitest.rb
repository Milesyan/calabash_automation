require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'noah_android_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NoahTest < Minitest::Test
  include BabyAndroid

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def create_user
    BabyUser.new.signup
  end

  def test_signup_user
    u = create_user
    assert_rc u.res
    assert_equal 1, u.res["data"]["user"]["major"]
    assert_equal "F", u.res["data"]["user"]["gender"]

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

  def test_sign_up_with_duplicated_email_and_correct_password
    u = create_user
    u2 = BabyUser.new(email: u.email, password: u.password).signup
    assert_equal u.user_id, u2.user_id
  end

  def test_sign_up_with_duplicated_email_and_wrong_password
    u = create_user
    u2 = BabyUser.new(email: u.email, password: "wrong_pwd").signup
    assert_equal 4000101, u2.res["rc"]
    assert_equal "Sorry, the email is already registered by another user.", u2.res["msg"]
  end

  def test_login_with_wrong_email_and_correct_password
    u = create_user
    u.login(email: "wrong" + u.email, password: u.password)
    assert_equal 4000102, u.res["rc"]
    assert_equal "Sorry, wrong email or password.", u.res["msg"]
  end

  def test_login_with_correct_email_but_wrong_password
    u = create_user
    u.login email: u.email, password: "wrong" + u.password
    assert_equal 4000102, u.res["rc"]
    assert_equal "Sorry, wrong email or password.", u.res["msg"] 
  end

  def test_forgot_password
    skip("not implemented yet")
  end

  def test_mother_add_one_born_boy
    u = create_user
    baby = u.new_born_baby relation: "Mother", gender: "M"
    u.add_born_baby baby
    assert_rc u.res
    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal "M", actual_baby["gender"]
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Mother", u.res["data"]["UserBabyRelation"]["update"].first["relation"]

    u.login
    assert_equal 1, u.res["data"]["babies"].size
  end

  def test_father_add_one_born_girl
    u = create_user
    baby = u.new_born_baby relation: "Father", gender: "F"
    u.add_born_baby baby
    assert_rc u.res
    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal "F", actual_baby["gender"]
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Father", u.res["data"]["UserBabyRelation"]["update"].first["relation"]

    u.login
    assert_equal 1, u.res["data"]["babies"].size
  end

  def test_mother_add_one_upcoming_baby
    u = create_user
    baby = u.new_upcoming_baby relation: "Mother"
    u.add_upcoming_baby baby
    assert_rc u.res

    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal "", actual_baby["gender"] # no gender
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Mother", u.res["data"]["UserBabyRelation"]["update"].first["relation"]
    assert_equal 1, u.res["data"]["UserBabyRelation"]["update"].first["role"]
  end

  def test_father_add_one_upcoming_baby
    u = create_user
    baby = u.new_upcoming_baby relation: "Father"
    u.add_upcoming_baby baby
    assert_rc u.res

    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal "", actual_baby["gender"] # no gender
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Father", u.res["data"]["UserBabyRelation"]["update"].first["relation"]
    assert_equal 1, u.res["data"]["UserBabyRelation"]["update"].first["role"]
  end

  def test_mother_invites_father
    u = create_user
    baby = u.new_born_baby relation: "Mother", gender: "M"
    u.add_born_baby baby

    partner = BabyUser.new relation: "Father"
    u.invite_family partner: partner
    assert_rc u.res

    assert_equal 3, partner.status # partner's status
    assert_equal "M", partner.gender
    partner_relation = u.res["data"]["UserBabyRelation"]["update"].select { |v| v["relation"] == "Father"}
    partner_relation_update = partner_relation.first

    assert_equal "Father", partner_relation_update["relation"]
    assert_equal partner.user_id, partner_relation_update["user_id"]
    assert_equal "#{partner.user_id}_#{u.current_baby.baby_id}", partner_relation_update["user_baby_id"].to_s

    partner.signup user: partner
    baby = Baby.new partner.res["data"]["babies"].first["Baby"].symbolize_keys
    assert_equal u.current_baby.baby_id, baby.baby_id
  end

  def test_father_invites_mother
    u = create_user
    baby = u.new_born_baby relation: "Father", gender: "F"
    u.add_born_baby baby

    partner = BabyUser.new relation: "Mother"
    u.invite_family partner: partner
    assert_rc u.res
    assert_equal 3, partner.status
    assert_equal "F", partner.gender

    partner_relation = u.res["data"]["UserBabyRelation"]["update"].select { |v| v["relation"] == "Mother"}
    partner_relation_update = partner_relation.first

    assert_equal "Mother", partner_relation_update["relation"]
    assert_equal partner.user_id, partner_relation_update["user_id"]
    assert_equal "#{partner.user_id}_#{u.current_baby.baby_id}", partner_relation_update["user_baby_id"].to_s

    partner.signup user: partner
    baby = Baby.new partner.res["data"]["babies"].first["Baby"].symbolize_keys
    assert_equal u.current_baby.baby_id, baby.baby_id
  end

  def test_mother_disconnects_pending_father
    u = create_user
    baby = u.new_born_baby relation: "Mother", gender: "F"
    u.add_born_baby baby

    partner = BabyUser.new relation: "Father"
    u.invite_family partner: partner
    assert_equal 3, partner.status
    assert_equal "M", partner.gender

    u.disconnect_family baby, partner
    assert_rc u.res

    removed_partners = u.res["data"]["UserBabyRelation"]["remove"].select { |v| v["relation"] == "Father"}
    removed_partner = removed_partners.first
    assert_equal partner.user_id, removed_partner["user_id"]
    assert_equal "Father", removed_partner["relation"]
    
    partner.signup user: partner
    assert_rc partner.res
    assert_equal 0, partner.res["data"]["babies"].size
    assert_equal "M", partner.res["data"]["user"]["gender"]
    assert_equal 0, partner.res["data"]["user"]["current_baby_id"]
    assert_equal 1, partner.res["data"]["user"]["major"]
    assert_equal 0, partner.res["data"]["user"]["status"]

  end

  # def test_mother_disconnects_connected_father
  #   u = create_user
  #   baby = u.new_born_baby relation: "Mother", gender: "M"
  #   u.add_born_baby baby

  #   partner = BabyUser.new relation: "Father"
  #   u.invite_family partner: partner
  #   assert_equal 3, partner.status
  #   assert_equal "M", partner.gender
  # end

end