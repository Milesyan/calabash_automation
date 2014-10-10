import unittest
import os
from datetime import datetime
import sys

from random import randint
from selenium import webdriver

import Utils.BaseUtils
import Utils.SignupUtils

class GlossaryTest(unittest.TestCase):

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

	def test_glossary(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[0].click()
		Utils.BaseUtils.waittime(3)
		Utils.SignupUtils.click_NFP(self.driver)
		Utils.BaseUtils.waittime(10)
		Utils.SignupUtils.click_popclose(self.driver)


	def test_quickcancel_glossary(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[0].click()
		Utils.BaseUtils.waittime(3)
		Utils.SignupUtils.click_NFP(self.driver)
		Utils.BaseUtils.waittime(1)
		Utils.SignupUtils.click_popclose(self.driver)
		Utils.BaseUtils.passAlert(self, self.driver, "Could not connect to the server")

	def tearDown(self):
		self.driver.quit()


if __name__ == '__main__':
    unittest.main()