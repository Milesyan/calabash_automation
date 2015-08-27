import unittest
import os
from datetime import datetime
import sys

from random import randint
from selenium import webdriver

import Utils.BaseUtils
import Utils.SignupUtils

class CommunityTest(unittest.TestCase):

	def setUp(self):
        # set up appium
		app = os.path.abspath("/Users/jason/Library/Developer/Xcode/DerivedData/emma-csfadnfvrgkeoeadzqdghrpmzekf/Build/Products/Debug-iphoneos/emmadev.app")
		self.driver = webdriver.Remote(
            command_executor = Utils.BaseUtils.CONTENT_URL,
            desired_capabilities={
                # 'browserName': '',
                'browserName': 'iOS',
                'device': 'iPhone Simulator',
                # 'device': 'iPhone Retina (4-inch 64-bit)',
                'platform': 'Mac',
                'version': '7.1',
                'app': Utils.BaseUtils.APP_PATH
                # 'app': "/Users/jason/Library/Developer/Xcode/DerivedData/emma-fbhmxtjxouvmzbaihdvinvcvyfwe/Build/Products/Debug-iphoneos/emmadev.app"
                # 'app': "/Users/jason/Library/Developer/Xcode/DerivedData/emma-fbhmxtjxouvmzbaihdvinvcvyfwe/Build/Products/Debug-iphonesimulator/emmadev.app"
            })
		self._values = []


	def test_community_tutorials(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)

	def test_community_search_topic(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#search the topic
		self.driver.find_element_by_xpath("//window[1]/navigationBar[1]/button[1]").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/searchbar[1]").send_keys("BBT")
		self.driver.execute_script("mobile: tap", {"touchCount":"1", "x":"258", "y":"520"})
		Utils.BaseUtils.waittime(5)
		self.assertTrue(self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[1]").is_displayed())

	def test_community_search_comments(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#search the comments
		self.driver.find_element_by_xpath("//window[1]/navigationBar[1]/button[1]").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/segmented[1]/button[2]").click()
		self.driver.find_element_by_xpath("//window[1]/searchbar[1]").send_keys("BBT")
		self.driver.execute_script("mobile: tap", {"touchCount":"1", "x":"258", "y":"520"})
		Utils.BaseUtils.waittime(5)
		self.assertTrue(self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[1]").is_displayed())

	def test_community_search_notexist_topic(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#search the topic
		self.driver.find_element_by_xpath("//window[1]/navigationBar[1]/button[1]").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/searchbar[1]").send_keys("12W12")
		self.driver.execute_script("mobile: tap", {"touchCount":"1", "x":"258", "y":"520"})
		Utils.BaseUtils.waittime(5)
		self.assertEqual(self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[1]").get_attribute("name"),"No result")

	def test_community_add_empty_topic(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add empty topic
		self.driver.find_element_by_name("Add topic").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_name("Post").click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Post").is_displayed)

	def test_community_add_normal_topic(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add normal topic
		self.driver.find_element_by_name("Add topic").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason test")
		self.driver.find_element_by_name("Post").click()
		Utils.BaseUtils.waittime(6)
	  try:
			passAlert(self.driver)
		except:
			pass
		self.driver.find_element_by_name("Skip").click()
		Utils.BaseUtils.waittime(2)

	def test_community_discard_add_normal_topic(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add normal topic
		self.driver.find_element_by_name("Add topic").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason test")
		self.driver.find_element_by_name("Close").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_name("Discard").click()
		Utils.BaseUtils.waittime(2)

	def test_community_add_anonymously_topic(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add normal topic
		self.driver.find_element_by_name("Add topic").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason test")
		self.driver.find_element_by_name("Add Anonymously").click()
		self.driver.find_element_by_name("Post").click()
		Utils.BaseUtils.waittime(6)
		try:
			passAlert(self.driver)
		except:
			pass
		self.driver.find_element_by_name("Skip").click()
		Utils.BaseUtils.waittime(2)

	def test_community_add_empty_comment(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add empty comment
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/tableview[2]/cell[2]").click()
		Utils.BaseUtils.waittime(8)
		self.driver.find_element_by_name("Add a comment").click()
		Utils.BaseUtils.waittime(5)
		# self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason comment test")
		self.driver.find_element_by_name("Post").click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Post").is_displayed)

	def test_community_add_normal_comment(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add empty comment
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/tableview[2]/cell[2]").click()
		Utils.BaseUtils.waittime(8)
		self.driver.find_element_by_name("Add a comment").click()
		Utils.BaseUtils.waittime(5)
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason comment test")
		self.driver.find_element_by_name("Post").click()
		Utils.BaseUtils.waittime(2)

	def test_community_swipe_among_rooms(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		
		Utils.SignupUtils.swipe_left(self.driver)
		Utils.BaseUtils.waittime(1)
		Utils.SignupUtils.swipe_left(self.driver)
		Utils.BaseUtils.waittime(1)
		Utils.SignupUtils.swipe_left(self.driver)
		Utils.BaseUtils.waittime(1)
		Utils.SignupUtils.swipe_left(self.driver)
		Utils.BaseUtils.waittime(1)
		Utils.SignupUtils.swipe_left(self.driver)
		Utils.BaseUtils.waittime(1)

		Utils.SignupUtils.swipe_right(self.driver)
		Utils.BaseUtils.waittime(1)
		Utils.SignupUtils.swipe_right(self.driver)
		Utils.BaseUtils.waittime(1)
		Utils.SignupUtils.swipe_right(self.driver)
		Utils.BaseUtils.waittime(1)
		Utils.SignupUtils.swipe_right(self.driver)
		Utils.BaseUtils.waittime(1)
		Utils.SignupUtils.swipe_right(self.driver)
		Utils.BaseUtils.waittime(1)

	def test_community_add_empty_comment(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(20)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add empty comment
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/tableview[2]/cell[2]").click()
		Utils.BaseUtils.waittime(8)
		self.driver.find_element_by_name("Add a comment").click()
		Utils.BaseUtils.waittime(5)
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("            ")
		self.driver.find_element_by_name("Post").click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Post").is_displayed)

	def test_community_add_empty_poll(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add empty topic
		self.driver.find_element_by_name("Create poll").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_name("Post").click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Post").is_displayed)

	def test_community_add_normal_poll(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add normal topic
		self.driver.find_element_by_name("Create poll").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[1]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[2]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[3]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_name("Post").click()
		Utils.BaseUtils.waittime(6)
		try:
			passAlert(self.driver)
		except:
			pass
		self.driver.find_element_by_name("Skip").click()
		Utils.BaseUtils.waittime(2)

	def test_community_discard_add_normal_poll(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add normal topic
		self.driver.find_element_by_name("Create poll").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[1]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[2]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[3]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_name("Close").click()
		Utils.BaseUtils.waittime(2)

	def test_community_add_anonymously_poll(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add normal topic
		self.driver.find_element_by_name("Create poll").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[1]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[2]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[3]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_name("Add Anonymously").click()
		self.driver.find_element_by_name("Post").click()
		Utils.BaseUtils.waittime(6)
		try:
			passAlert(self.driver)
		except:
			pass
		self.driver.find_element_by_name("Skip").click()
		Utils.BaseUtils.waittime(2)

	def test_community_vote_poll(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.finish_community_tutorils(self.driver)
		Utils.BaseUtils.waittime(5)
		#Add normal topic
		self.driver.find_element_by_name("Create poll").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[1]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[2]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[3]/textfield[1]").send_keys("jason test")
		self.driver.find_element_by_name("Add Anonymously").click()
		self.driver.find_element_by_name("Post").click()
		Utils.BaseUtils.waittime(6)
		try:
			passAlert(self.driver)
		except:
			pass
		self.driver.find_element_by_name("Skip").click()
		Utils.BaseUtils.waittime(2)
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		before = len(buttons)
		buttons[6].click()
		Utils.BaseUtils.waittime(3)
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		after = len(buttons)
		self.assertTrue(after < before)

   	def tearDown(self):
		self.driver.quit()

if __name__ == '__main__':
    unittest.main()