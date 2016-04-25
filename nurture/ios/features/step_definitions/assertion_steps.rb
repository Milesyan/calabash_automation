Then(/^I assert the www response of created topic$/) do 
  res = $user.get_created.res
  assert_equal $user.topic_titile, res["topics"][0]["title"]
  assert_equal $user.user_id, res["topics"][0]["user_id"]
end