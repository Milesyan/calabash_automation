import unittest
import os
from random import randint
from selenium import webdriver

import Utils.BaseUtils
import Utils.SignupUtils
import json

class SingupTest(unittest.TestCase):

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

	def test_signup_ttc(self):
		Utils.SignupUtils.signup_ttc_with_email(self.driver, "jason", "jason+" + Utils.SignupUtils.rand_str(15) + "@upwlabs.com", "123456")
		Utils.SignupUtils.finfish_tutorials(self.driver)

	def test_signup_nonttc(self):
		Utils.SignupUtils.signup_non_ttc_with_email(self.driver, "jason", "jason+" + Utils.SignupUtils.rand_str(16) + "@upwlabs.com", "123456")
		Utils.SignupUtils.finfish_tutorials(self.driver)

	def test_signup_ttc_withexistemail(self):
		Utils.SignupUtils.signup_ttc_with_email(self.driver, "jason", "jason+00001@upwlabs.com", "123456")
		Utils.BaseUtils.passAlert(self, self.driver, "This email is already registered by another user.")

	def test_signup_nonttc_withexistemail(self):
		Utils.SignupUtils.signup_non_ttc_with_email(self.driver, "jason", "jason+00001@upwlabs.com", "123456")
		Utils.BaseUtils.passAlert(self, self.driver, "This email is already registered by another user.")

   	def tearDown(self):
		self.driver.quit()




if __name__ == '__main__':
    unittest.main()