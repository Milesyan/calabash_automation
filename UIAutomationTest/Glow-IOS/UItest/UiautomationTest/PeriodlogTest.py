import unittest
import os
from datetime import datetime
import sys

from random import randint
from selenium import webdriver

import Utils.BaseUtils
import Utils.SignupUtils

class PeriodlogTest(unittest.TestCase):

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

	def test_periodlog_home(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(2)

		close_btn = self.driver.find_element_by_name("Back")
		self.assertTrue(close_btn.is_displayed())
		close_btn.click()
		Utils.BaseUtils.waittime(5)
		buttons[2].click()
		Utils.BaseUtils.waittime(2)

	def test_periodlog_add_period(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(5)

        #go to top of calendar
		for i in range(1, 10):
			Utils.SignupUtils.swipe_down_periodlog(self.driver)
			Utils.BaseUtils.waittime(1)
		#add period log
		self.driver.execute_script("mobile: tap", {"touchCount":"1", "x":"58", "y":"188"})
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[3]/actionsheet[1]/button[1]").click()
		Utils.BaseUtils.waittime(2)

		#go to top of calendar
		for i in range(1, 3):
			Utils.SignupUtils.swipe_down_periodlog(self.driver)
			Utils.BaseUtils.waittime(1)
		self.driver.execute_script("mobile: tap", {"touchCount":"1", "x":"68", "y":"188"})
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_name("Delete").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[3]/actionsheet[1]/button[1]").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_name("Done").click()
		Utils.BaseUtils.waittime(5)
		close_btn = self.driver.find_element_by_name("Back")
		self.assertTrue(close_btn.is_displayed())
		close_btn.click()
		Utils.BaseUtils.waittime(5)
		buttons[2].click()
		Utils.BaseUtils.waittime(2)

   	def tearDown(self):
		self.driver.quit()


if __name__ == '__main__':
    unittest.main()