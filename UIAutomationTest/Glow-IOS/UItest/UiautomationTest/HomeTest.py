import unittest
import os
from datetime import datetime
import sys

from random import randint
from selenium import webdriver

import Utils.BaseUtils
import Utils.SignupUtils

class HomeTest(unittest.TestCase):

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
                # 'app': "/Users/jason/Library/Developer/Xcode/DerivedData/emma-fbhmxtjxouvmzbaihdvinvcvyfwe/Build/Products/Debug-iphoneos/emmadev.app"
                # 'app': "/Users/jason/Library/Developer/Xcode/DerivedData/emma-fbhmxtjxouvmzbaihdvinvcvyfwe/Build/Products/Debug-iphonesimulator/emmadev.app"
            })
		self._values = []

	def test_swipe_calendar(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.HOME_BASE_USER,Utils.BaseUtils.HOME_BASE_PASSWORD)
		Utils.BaseUtils.waittime(8)
		Utils.SignupUtils.swipe_left(self.driver)
		Utils.BaseUtils.waittime(3)
		Utils.SignupUtils.swipe_down(self.driver)
		Utils.BaseUtils.waittime(3)
		Utils.SignupUtils.swipe_down(self.driver)
		Utils.BaseUtils.waittime(3)
		Utils.SignupUtils.swipe_left(self.driver)
		Utils.BaseUtils.waittime(3)

	def test_change_background_takephoto(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.HOME_BASE_USER,Utils.BaseUtils.HOME_BASE_PASSWORD)
		Utils.BaseUtils.waittime(8)
		self.driver.find_element_by_name("background photo update").click()
		Utils.BaseUtils.waittime(5)
		self.driver.find_element_by_name("Take photo").click()
		Utils.BaseUtils.waittime(5)
		self.driver.find_element_by_name("PhotoCapture").click()
		Utils.BaseUtils.waittime(5)
		self.driver.find_element_by_name("Use Photo").click()
		Utils.BaseUtils.waittime(5)

	def test_change_background_fromimages(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.HOME_BASE_USER,Utils.BaseUtils.HOME_BASE_PASSWORD)
		Utils.BaseUtils.waittime(10)
		self.driver.find_element_by_name("background photo update").click()
		Utils.BaseUtils.waittime(5)
		self.driver.find_element_by_name("Choose from library").click()
		Utils.BaseUtils.waittime(5)
		try:
			alert = self.driver.switch_to_alert()
			alert.accept()
		except Exception as err:
			print(err) 
		finally:
			self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[1]/text[1]").click()
			Utils.BaseUtils.waittime(3)
			self.driver.find_element_by_xpath("//window[1]/UIACollectionView[1]/UIACollectionCell[1]").click()
			Utils.BaseUtils.waittime(5)

	def test_back_totoday(self):
		today = datetime.now()
		month = today.strftime('%b').upper()
		day = today.day
		year = today.year
		today_str = month + (" %d, " % day) + ("%d " % year)
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.HOME_BASE_USER,Utils.BaseUtils.HOME_BASE_PASSWORD)
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.swipe_left(self.driver)
		Utils.BaseUtils.waittime(3)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[0].click()
		Utils.BaseUtils.waittime(3)
		self.assertEqual(self.driver.find_element_by_xpath("//window[1]/tableview[1]/group[1]").get_attribute("name"),today_str)

	def test_swipe_from_small_to_big(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.HOME_BASE_USER,Utils.BaseUtils.HOME_BASE_PASSWORD)
		Utils.BaseUtils.waittime(8)
		Utils.SignupUtils.swipe_down(self.driver)
		Utils.BaseUtils.waittime(3)
		Utils.SignupUtils.swipe_down(self.driver)
		Utils.BaseUtils.waittime(3)

	def test_swipe_from_big_to_small(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.HOME_BASE_USER,Utils.BaseUtils.HOME_BASE_PASSWORD)
		Utils.BaseUtils.waittime(8)
		Utils.SignupUtils.swipe_down(self.driver)
		Utils.BaseUtils.waittime(3)
		Utils.SignupUtils.swipe_down(self.driver)
		Utils.BaseUtils.waittime(3)
		Utils.SignupUtils.swipe_down(self.driver)
		Utils.BaseUtils.waittime(3)

	def test_tomorrow_message(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,Utils.BaseUtils.HOME_BASE_USER,Utils.BaseUtils.HOME_BASE_PASSWORD)
		Utils.BaseUtils.waittime(15)
		Utils.SignupUtils.swipe_left_tomorrow(self.driver)
		tomorrow_str = "You can get a sneak peek to tomorrow's plan by completing today's."
		self.assertEqual(self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[2]").get_attribute("name"),tomorrow_str)
		

   	def tearDown(self):
		self.driver.quit()


if __name__ == '__main__':
    unittest.main()