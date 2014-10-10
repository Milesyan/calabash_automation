import json
import unittest
from random import randint
# from selenium import webdriver
from appium import webdriver

from Utils import BaseUtils,SignupUtils,OnboardingUtils,HomeUtils,ForumUtils

class kaylee_forumTest(unittest.TestCase):

	def setUp(self):
        # set up appium
		self.driver = webdriver.Remote(
            command_executor = BaseUtils.CONTENT_URL,
            desired_capabilities= BaseUtils.CAPABILITIES)
		self._values = []

	def test_community_tutorials(self):
		OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
		BaseUtils.waittime()
		ForumUtils.finish_community_tutorils(self.driver)

	# def test_search_topic(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.search_topic(self.driver,"a")
	# 	self.assertTrue(self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").is_displayed())

	# def test_search_notexist_topic(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.search_topic(self.driver,"asdf")
	# 	self.assertEqual(self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").get_attribute("name"),"No result")

	# def test_search_comment(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.search_comment(self.driver,"a")
	# 	self.assertTrue(self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").is_displayed())

	# def test_search_notexist_comment(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.search_comment(self.driver,"12w12")
	# 	self.assertEqual(self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").get_attribute("name"),"No result")

	# def test_community_add_empty_topic(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.add_topic(self.driver,"","")
	# 	self.assertTrue(self.driver.find_element_by_name("Post").is_displayed)
	
	# def test_community_add_normal_topic(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.add_topic(self.driver,"jason test kaylee forum","jason test")
	# 	BaseUtils.waittime(5)

	# def test_community_discard_add_topic(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.discard_add_normal_topic(self.driver,"jason test kaylee forum","jason test")
	# 	BaseUtils.waittime(5)

	# def test_community_add_anonymously_topic(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.add_topic(self.driver,"jason test kaylee forum","jason test",True)
	# 	BaseUtils.waittime(5)

	# def test_community_add_empty_comment(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.add_comment(self.driver,"")
	# 	BaseUtils.waittime(5)
	# 	self.assertTrue(self.driver.find_element_by_name("Post").is_displayed)

	# def test_community_add_normal_comment(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.add_comment(self.driver,"jason comment test")

	# def test_community_add_short_comment(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.add_comment(self.driver,"test")
	# 	self.assertTrue(BaseUtils.waitforstatusbar(self.driver,10,"Sorry, the content is too short"))

	# def test_add_normal_poll(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.add_poll(self.driver,"UI automation test",['A','B'],anonymously=False)
	# 	BaseUtils.waittime(5)

	# def test_vore_poll(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.add_poll(self.driver,"UI automation test",['A','B'],anonymously=False)
	# 	BaseUtils.waittime(5)
	# 	ForumUtils.vote_poll(self.driver,1)

	# def test_add_empty_poll(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	ForumUtils.add_poll(self.driver,"",['A','B'],anonymously=False)
	# 	BaseUtils.waittime(5)
	# 	self.assertTrue(self.driver.find_element_by_name("Post").is_displayed)

	# def test_community_swipe_among_rooms(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	ForumUtils.finish_community_tutorils(self.driver)
	# 	BaseUtils.swipe_left(self.driver,5)
	# 	BaseUtils.swipe_right(self.driver,5)
	# 	BaseUtils.swipe_up(self.driver,5)
	# 	BaseUtils.swipe_down(self.driver,5)

	def tearDown(self):
		self.driver.quit()


if __name__ == '__main__':
    unittest.main()