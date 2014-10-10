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
                'platformName': 'iOS',
                'deviceName': 'iPhone Simulator,',
                'app': Utils.BaseUtils.APP_PATH
                # 'app': "/Users/jason/Library/Developer/Xcode/DerivedData/emma-cwilhcksnuwkmwedfynijtortmke/Build/Products/Debug-iphonesimulator/emmadev.app"
                # 'app': "/Users/jason/Library/Developer/Xcode/DerivedData/emma-fbhmxtjxouvmzbaihdvinvcvyfwe/Build/Products/Debug-iphoneos/emmadev.app"
                # 'app': "/Users/jason/Library/Developer/Xcode/DerivedData/emma-fbhmxtjxouvmzbaihdvinvcvyfwe/Build/Products/Debug-iphonesimulator/emmadev.app"
            })
		self._values = []


	# def test_community_tutorials(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
		
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(3)
	# 	self.assertTrue(self.driver.find_element_by_name("Add a comment").is_displayed())


	# def test_community_search_topic(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#search the topic
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIASearchBar[1]/UIASearchBar[1]").send_keys("BBT")
	# 	self.driver.execute_script("mobile: tap", {"touchCount":"1", "x":"258", "y":"520"})
	# 	Utils.BaseUtils.waittime(5)
	# 	self.assertTrue(self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").is_displayed())

	# def test_community_search_comments(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#search the topic
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIASegmentedControl[1]/UIAButton[2]").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIASearchBar[1]/UIASearchBar[1]").send_keys("Test")
	# 	self.driver.execute_script("mobile: tap", {"touchCount":"1", "x":"258", "y":"520"})
	# 	Utils.BaseUtils.waittime(5)
	# 	self.assertTrue(self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").is_displayed())

	# def test_community_search_notexist_topic(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#search the topic
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIASearchBar[1]/UIASearchBar[1]").send_keys("12W12S")
	# 	Utils.BaseUtils.waittime(1)
	# 	self.driver.execute_script("mobile: tap", {"touchCount":"1", "x":"258", "y":"540"})
	# 	Utils.BaseUtils.waittime(5)
	# 	self.assertEqual(self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").get_attribute("name"),"No result")

	# def test_community_add_empty_topic(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty topic
	# 	self.driver.find_element_by_name("Topic").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Next").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.assertTrue(self.driver.find_element_by_name("Next").is_displayed)

	# def test_community_add_normal_topic(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty topic
	# 	self.driver.find_element_by_name("Topic").click()
	# 	Utils.BaseUtils.waittime(2)	
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATextField[1]").send_keys("jason test")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys("jason test")
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys("jason test")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Next").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Done!").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.passAlert(self,self.driver)
	# 	self.driver.find_element_by_name("Done").click()
	# 	Utils.BaseUtils.waittime(2)

	# def test_community_discard_add_normal_topic(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty topic
	# 	self.driver.find_element_by_name("Topic").click()
	# 	Utils.BaseUtils.waittime(2)	
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATextField[1]").send_keys("jason test")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys("jason test")
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys("jason test")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Close").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Discard").click()
	# 	Utils.BaseUtils.waittime(2)

	# def test_community_add_anonymously_topic(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty topic
	# 	self.driver.find_element_by_name("Topic").click()
	# 	Utils.BaseUtils.waittime(2)	
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATextField[1]").send_keys("jason test")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys("jason test")
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys("jason test")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Add Anonymously").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Next").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Done!").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.passAlert(self,self.driver)
	# 	self.driver.find_element_by_name("Done").click()
	# 	Utils.BaseUtils.waittime(2)

	# def test_community_add_empty_comment(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(5)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty comment
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[2]/UIATableCell[1]/UIAStaticText[1]").click()
	# 	Utils.BaseUtils.waittime(5)
	# 	self.driver.find_element_by_name("Add a comment").click()
	# 	Utils.BaseUtils.waittime(5)
	# 	# self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason comment test")
	# 	self.driver.find_element_by_name("Post").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.assertTrue(self.driver.find_element_by_name("Post").is_displayed)

	# def test_community_add_normal_comment(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(5)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty comment
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[2]/UIATableCell[1]/UIAStaticText[1]").click()
	# 	Utils.BaseUtils.waittime(5)
	# 	self.driver.find_element_by_name("Add a comment").click()
	# 	Utils.BaseUtils.waittime(5)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys("jason comment test")
	# 	# self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason comment test")
	# 	self.driver.find_element_by_name("Post").click()
	# 	Utils.BaseUtils.waittime(2)
		
	# def test_community_add_empty_poll(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(5)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty topic
	# 	self.driver.find_element_by_name("Poll").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Next").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.assertTrue(self.driver.find_element_by_name("Next").is_displayed)

	# def test_community_add_normal_poll(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty topic
	# 	self.driver.find_element_by_name("Poll").click()
	# 	Utils.BaseUtils.waittime(2)	
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]/UIATextField[1]").send_keys("jason test")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[2]/UIATextField[1]").send_keys("A")
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[4]/UIATextField[1]").send_keys("B")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Next").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Done!").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.passAlert(self,self.driver)
	# 	self.driver.find_element_by_name("Done").click()
	# 	Utils.BaseUtils.waittime(2)

	# def test_community_discard_add_normal_poll(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty topic
	# 	self.driver.find_element_by_name("Poll").click()
	# 	Utils.BaseUtils.waittime(2)	
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]/UIATextField[1]").send_keys("jason test")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[2]/UIATextField[1]").send_keys("A")
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[4]/UIATextField[1]").send_keys("B")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Close").click()
	# 	Utils.BaseUtils.waittime(2)

	# 	self.driver.find_element_by_name("Discard").click()
	# 	Utils.BaseUtils.waittime(2)

	# def test_community_add_anonymously_poll(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty topic
	# 	self.driver.find_element_by_name("Poll").click()
	# 	Utils.BaseUtils.waittime(2)	
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]/UIATextField[1]").send_keys("jason test")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[2]/UIATextField[1]").send_keys("A")
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[4]/UIATextField[1]").send_keys("B")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Add Anonymously").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Next").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Done!").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.passAlert(self,self.driver)
	# 	self.driver.find_element_by_name("Done").click()
	# 	Utils.BaseUtils.waittime(2)

	# def test_community_add_normal_photo_pic(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty topic
	# 	self.driver.find_element_by_name("Photo").click()
	# 	Utils.BaseUtils.waittime(2)	
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]/UIAStaticText[1]").click()
	# 	Utils.BaseUtils.waittime(2)

	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIACollectionView[1]/UIACollectionCell[1]").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Choose").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]/UIATextView[1]").send_keys("BBBBB")
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Next").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Done!").click()
	# 	Utils.BaseUtils.waittime(8)
	# 	Utils.BaseUtils.passAlert(self,self.driver)
	# 	self.driver.find_element_by_name("Done").click()
	# 	Utils.BaseUtils.waittime(2)

	# def test_community_discord_normal_photo_pic(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	#Add empty topic
	# 	self.driver.find_element_by_name("Photo").click()
	# 	Utils.BaseUtils.waittime(2)	
	# 	try:
	# 		Utils.BaseUtils.passAlert(self,self.driver)
	# 	except:
	# 		pass
	# 	self.driver.find_element_by_name("Cancel").click()
	# 	Utils.BaseUtils.waittime(2)

	# def test_community_hot_topic(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	# table = self.driver.find_element_by_class_name('UIATableView')

	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Me").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)

	# 	table = self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[2]")
	# 	self.assertIsNotNone(table)
	# 	rows = table.find_elements_by_class_name('UIATableCell')
	# 	self.assertTrue(len(rows)>10)

	# def test_community_new_topic(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Me").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("NEW").click()
	# 	Utils.BaseUtils.waittime(5)
		
	# 	# table = self.driver.find_element_by_class_name('UIATableView')
	# 	table = self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[2]")
	# 	self.assertIsNotNone(table)
	# 	rows = table.find_elements_by_class_name('UIATableCell')
	# 	self.assertTrue(len(rows)>10)

	# def test_bookmark_bookmarked_create_participate(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[2].click()
	# 	Utils.BaseUtils.waittime(2)

	# 	self.driver.find_element_by_name("Created").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Participated").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Bookmarked").click()
	# 	Utils.BaseUtils.waittime(2)

	# def test_groups_join_recommanded_group(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	self.driver.find_element_by_name("Groups").click()
	# 	Utils.BaseUtils.waittime(2)

	# 	self.driver.find_element_by_name("Join").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Create a group").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.assertTrue(self.driver.find_element_by_name("Create a group").is_displayed)

	# def test_groups_join_mygroups(self):
	# 	Utils.BaseUtils.waittime(3)
	# 	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	# 	buttons[1].click()
	# 	Utils.BaseUtils.waittime(3)
	# 	Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
	# 	Utils.BaseUtils.waittime(15)

	# 	#finish toturials
	# 	self.driver.find_element_by_name("Community").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
	# 	Utils.BaseUtils.waittime(2)
	# 	Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
	# 	Utils.BaseUtils.waittime(2)

	# 	self.driver.find_element_by_name("Groups").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("My Groups").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.driver.find_element_by_name("Create a group").click()
	# 	Utils.BaseUtils.waittime(2)
	# 	self.assertTrue(self.driver.find_element_by_name("Create a group").is_displayed)

	# 	table = self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[2]")
	# 	self.assertIsNotNone(table)
	# 	rows = table.find_elements_by_class_name('UIATableCell')
	# 	self.assertTrue(len(rows)>0)

	def test_like_topic(self):
		Utils.BaseUtils.waittime(3)
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.FORUM_BASE_USER,Utils.BaseUtils.FORUM_BASE_PASSWORD)
		Utils.BaseUtils.waittime(15)

		#finish toturials
		self.driver.find_element_by_name("Community").click()
		Utils.BaseUtils.waittime(2)
		Utils.BaseUtils.clickbuttonbyname(self.driver,"Let's get started!")
		Utils.BaseUtils.waittime(2)
		Utils.BaseUtils.clickbuttonbyname(self.driver,"gl community back")
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[2]")
		self.assertIsNotNone(table)
		rows = table.find_elements_by_class_name('UIATableCell')
		rows[2].click()
		Utils.BaseUtils.waittime(2)

		self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIAButton[2]").click()
		Utils.BaseUtils.waittime(2)

		self.driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIAButton[2]").click()
		Utils.BaseUtils.waittime(2)
		

   	def tearDown(self):
		self.driver.quit()

if __name__ == '__main__':
    unittest.main()