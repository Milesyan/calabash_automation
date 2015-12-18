Given(/^I finish the tutorial$/) do
  home_page.finish_tutorial
end

Given(/^I complete daily log$/) do
  home_page.complete_daily_log

  # Verify daily log
  if $user.instance_of? GlowUser
    wait_for timeout: 30, retry_frequency: 3 do
      # in order to let it save to the server
      $user.pull_content
      $user.res["daily_data"].size > 0 && $user.res["daily_data"].first["sleep"] == 28800
    end
    assert_equal 28800, $user.res["daily_data"].first["sleep"]
    assert_equal 11, $user.res["daily_data"].first["alcohol"]
    assert_equal 2570, $user.res["daily_data"].first["cervical_mucus"]
  end
end

Given(/^I complete daily log for female partner$/) do
  home_page.complete_daily_log
  if $user.instance_of? GlowUser
    wait_for timeout: 30, retry_frequency: 3 do
      $user.pull_content
      $user.res["daily_data"].size > 0
    end
    assert_equal 10, $user.res["daily_data"].first["exercise"]
    assert_equal 28800, $user.res["daily_data"].first["sleep"]
  end
end 

Given(/^I complete my daily log for male$/) do
  home_page.complete_daily_log "male"
  if $user.instance_of? GlowUser
    wait_for timeout: 30, retry_frequency: 3 do
      $user.pull_content
      $user.res["daily_data"].size > 0 && $user.res["daily_data"].first["heat_source"] == 34
    end
  end
  assert_equal 1, $user.res["daily_data"].first["erection"]
  assert_equal 10, $user.res["daily_data"].first["exercise"]
  assert_equal 34, $user.res["daily_data"].first["fever"]
  # assert_equal 771, $user.res["daily_data"].first["physical_symptom_1"] # random value
  # assert_equal 21, $user.res["daily_data"].first["smoke"] # unstable
end

Given(/^I complete ft log$/) do
  home_page.complete_ft_log

  # Verify fertility treatment log
  if $user.instance_of? GlowUser
    medical_logs = []
    wait_for timeout: 20, retry_frequency: 3 do
      # in order to let it save to the server
      $user.pull_content
      medical_logs = $user.res["medical_logs"]
      medical_logs.size > 15 
    end
    ml = medical_logs.map {|m| m = {m["data_key"] => m["data_value"]}}.reduce({}, :merge)
    assert_equal "80", ml["estrogenLevel"]
    assert_equal "3", ml["folliclesNumber"]
    assert_equal "1", ml["hCGTriggerShot"]
    assert_equal "80", ml["luteinizingHormoneLevel"]
  end
end
