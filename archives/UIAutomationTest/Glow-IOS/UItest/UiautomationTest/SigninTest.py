import unittest
import os
from random import randint
from selenium import webdriver
import Utils.BaseUtils
import Utils.SignupUtils


class SinginTest(unittest.TestCase):

    def setUp(self):
        # set up appium
        app = os.path.abspath("/Users/jason/Library/Developer/Xcode/DerivedData/emma-csfadnfvrgkeoeadzqdghrpmzekf/Build/Products/Debug-iphoneos/emmadev.app")
        self.driver = webdriver.Remote(
            # command_executor = 'http://192.168.1.8:4723/wd/hub',
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
    
    def test_loginwithrightemail(self):
        buttons = Utils.BaseUtils.find_all_buttons(self.driver)
        buttons[1].click()
        # wait = Selenium::WebDriver::Wait.new :timeout => 10
        # wait.until { @driver.find_element(:name, 'Email').displayed? }
        Utils.BaseUtils.waittime(3)
        Utils.BaseUtils.login_with_email(self.driver,"jason+00001@upwlabs.com","123456")
        Utils.BaseUtils.wati_until_element(self.driver,10,len(Utils.BaseUtils.find_all_buttons(self.driver))!=0)
        self.assertTrue(len(Utils.BaseUtils.find_all_buttons(self.driver))>5)
        Utils.BaseUtils.waittime(5)

    def test_loginwithrightwrongemail(self):
        buttons = Utils.BaseUtils.find_all_buttons(self.driver)
        buttons[1].click()
        # wait = Selenium::WebDriver::Wait.new :timeout => 10
        # wait.until { @driver.find_element(:name, 'Email').displayed? }
        Utils.BaseUtils.waittime(3)
        Utils.BaseUtils.login_with_email(self.driver,"jason+00001@upwlabs.com","wuwuwu")
        Utils.BaseUtils.waittime(3)
        Utils.BaseUtils.passAlert(self, self.driver, "Wrong email and password combination.")


    def test_forgetpassword(self):
        buttons = Utils.BaseUtils.find_all_buttons(self.driver)
        buttons[1].click()
        Utils.BaseUtils.forgetPassword(self.driver, "jason+00001@upwlabs.com")
        Utils.BaseUtils.waittime(3)
        alert = self.driver.switch_to_alert()
        Utils.BaseUtils.passAlert(self, self.driver, "Email sent! An email has been sent to your email address, please check the email on this device.")
        Utils.BaseUtils.waittime(3)

    def test_forgetpasswordwithunrregemail(self):
        buttons = Utils.BaseUtils.find_all_buttons(self.driver)
        buttons[1].click()

        Utils.BaseUtils.forgetPassword(self.driver, "jason+woo@upwlabs.com")
        Utils.BaseUtils.waittime(3)
        alert = self.driver.switch_to_alert()
        Utils.BaseUtils.passAlert(self, self.driver, "Email hasn't been registered.")
        Utils.BaseUtils.waittime(3)

    def test_signin_with_facebook(self):
        buttons = Utils.BaseUtils.find_all_buttons(self.driver)
        buttons[1].click()
        Utils.BaseUtils.waittime(3)
        Utils.BaseUtils.login_with_fb(self.driver)
        Utils.BaseUtils.waittime(10)
        Utils.BaseUtils.wati_until_element(self.driver,10,len(Utils.BaseUtils.find_all_buttons(self.driver))!=0)
        self.assertTrue(len(Utils.BaseUtils.find_all_buttons(self.driver))>5)
        Utils.BaseUtils.waittime(5)

    def test_login_with_mfp(self):
        buttons = Utils.BaseUtils.find_all_buttons(self.driver)
        buttons[1].click()
        Utils.BaseUtils.waittime(3)
        Utils.BaseUtils.login_with_mfp(self.driver)
        Utils.BaseUtils.waittime(10)
        Utils.BaseUtils.wati_until_element(self.driver,10,len(Utils.BaseUtils.find_all_buttons(self.driver))!=0)
        self.assertTrue(len(Utils.BaseUtils.find_all_buttons(self.driver))>5)
        Utils.BaseUtils.waittime(5)

    def test_login_with_fitbit(self):
        buttons = Utils.BaseUtils.find_all_buttons(self.driver)
        buttons[1].click()
        Utils.BaseUtils.waittime(3)
        Utils.BaseUtils.login_with_fitbit(self.driver)
        Utils.BaseUtils.waittime(15)
        #lack of verification

    def test_login_with_jawbone(self):
        buttons = Utils.BaseUtils.find_all_buttons(self.driver)
        buttons[1].click()
        Utils.BaseUtils.waittime(3)
        Utils.BaseUtils.login_with_jawbone(self.driver)
        Utils.BaseUtils.waittime(10)
        #lack of verification

    def tearDown(self):
        self.driver.quit()

if __name__ == '__main__':
    unittest.main()