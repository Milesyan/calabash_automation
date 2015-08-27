import json
import unittest
from random import randint
# from selenium import webdriver
from appium import webdriver

from Utils import BaseUtils,SignupUtils,OnboardingUtils,HomeUtils

class kaylee_homeTest(unittest.TestCase):

	def setUp(self):
        # set up appium
		self.driver = webdriver.Remote(
            command_executor = BaseUtils.CONTENT_URL,
            desired_capabilities= BaseUtils.CAPABILITIES)
		self._values = []

	def test_homeview_scroll_down_up(self):
		OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
		BaseUtils.waittime()
		BaseUtils.swipe_down(self.driver,2)
		BaseUtils.swipe_up(self.driver,2)

	# def test_homeview_scroll_up_down(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_up(self.driver,2)
	# 	BaseUtils.swipe_down(self.driver,2)
		
	# def test_switch_weelyview(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	HomeUtils.clicktodaybutton(self.driver)
	# 	BaseUtils.waittime()
	# 	HomeUtils.clicktodaybutton(self.driver)

	# def test_homeview_swipe_left(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_left(self.driver,5)

	# def test_homeview_swipe_right(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_right(self.driver,5)

	# def test_future_view(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_right(self.driver,2)
		
	# def test_see_all_appointments(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_up(self.driver,2)
	# 	HomeUtils.click_see_all_appointments(self.driver)
	# 	BaseUtils.waittime(3)
	# 	self.assertTrue(self.driver.find_element_by_name("APPOINTMENTS").is_displayed())
	# 	BaseUtils.waittime(3)

	# def test_goto_suggest_articel(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_up(self.driver,5)
	# 	HomeUtils.click_suggest_article(self.driver)
	# 	BaseUtils.waittime(3)
	# 	self.assertTrue(self.driver.find_element_by_name("Suggestions").is_displayed())
	# 	BaseUtils.waittime(3)

	# def test_goto_suggest_articel(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_up(self.driver,5)
	# 	HomeUtils.suggest_article(self,"www.163.com")
	# 	self.assertTrue(BaseUtils.waitforstatusbarinapp(self.driver,10,"Thanks, article suggested succesfully!"))

	# def test_goto_suggest_wrong_articel(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_up(self.driver,5)
	# 	HomeUtils.click_suggest_article(self.driver)
	# 	BaseUtils.waittime(3)
	# 	self.assertTrue(self.driver.find_element_by_name("Suggestions").is_displayed())
	# 	textfields = self.driver.find_elements_by_class_name("UIATextField")
	# 	textfields[0].send_keys("zzzzzz")
	# 	self.driver.hide_keyboard('Next')
	# 	self.assertTrue(BaseUtils.waitforstatusbarinapp(self.driver,10,"Failed to get preview of the article",1,7))

	# def test_backto_today(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_left(self.driver,7)
	# 	HomeUtils.click_backtoday(self.driver)
	# 	HomeUtils.clicktodaybutton(self.driver)
	# 	BaseUtils.waittime()
	# 	HomeUtils.clicktodaybutton(self.driver)

	# def test_notodaylogs(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.UN_DAILY_LOG)
	# 	BaseUtils.waittime()
	# 	self.assertTrue(HomeUtils.today_no_dailylog(self.driver))

	# def test_scroll_weekly_view(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	HomeUtils.clicktodaybutton(self.driver)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_up(self.driver,5)
	# 	BaseUtils.swipe_down(self.driver,5)

	# def test_goto_article(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	OnboardingUtils.gotoarticle(self.driver,1)
	# 	buttons = self.driver.find_elements_by_class_name('UIAButton')
	# 	buttons[0].click()
	# 	BaseUtils.waittime(5)

	# def test_articles(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	OnboardingUtils.gotoarticle(self.driver,1)
	# 	buttons = self.driver.find_elements_by_class_name('UIAButton')
	# 	buttons[0].click()
	# 	BaseUtils.waittime(5)
	# 	OnboardingUtils.gotoarticle(self.driver,2)
	# 	buttons = self.driver.find_elements_by_class_name('UIAButton')
	# 	buttons[0].click()
	# 	BaseUtils.waittime(5)

	# def test_photo_add(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	OnboardingUtils.click_home_button_by_name(self.driver,"Add photo")
	# 	BaseUtils.waittime()
	# 	self.driver.find_element_by_name("Take photo").click()
	# 	BaseUtils.waittime(5)
	# 	self.driver.find_element_by_name("PhotoCapture").click()
	# 	BaseUtils.waittime(5)
	# 	self.driver.find_element_by_name("Use Photo").click()
	# 	BaseUtils.waittime(5)
	# 	self.driver.find_element_by_name("Post").click()
	# 	BaseUtils.waittime(5)

	def test_photo_btimelapse(self):
		OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
		BaseUtils.waittime()
		OnboardingUtils.click_home_button_by_name(self.driver,"icon play")
		self.assertTrue(BaseUtils.waitforstatusbarinapp(self.driver,5,"Take two more photos to view timelapse!"))

	# def test_photo_edit(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_up(self.driver,2)
	# 	OnboardingUtils.click_home_button_by_name(self.driver,"Edit photo")
	# 	BaseUtils.waittime()
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[3]/UIAActionSheet[1]/UIAButton[1]").click()
	# 	BaseUtils.waittime(5)
	# 	self.driver.find_element_by_name("Post").click()
	# 	BaseUtils.waittime(5)

	# def test_photo_remove(self):
	# 	OnboardingUtils.purge_signin(self.driver,BaseUtils.MOM)
	# 	BaseUtils.waittime()
	# 	BaseUtils.swipe_up(self.driver,2)
	# 	OnboardingUtils.click_home_button_by_name(self.driver,"Edit photo")
	# 	BaseUtils.waittime()
	# 	self.driver.find_element_by_name("Delete photo").click()
	# 	BaseUtils.waittime()
	# 	self.driver.find_element_by_name("Yes").click()
	# 	BaseUtils.waittime(5)
	# 	try:
	# 		passAlert(driver)
	# 	except:
	# 		pass
	# 	BaseUtils.waittime(5)
	# 	OnboardingUtils.click_home_button_by_name(self.driver,"Add photo")

	def tearDown(self):
		self.driver.quit()


if __name__ == '__main__':
    unittest.main()