import unittest
import os
from datetime import datetime
import sys

from random import randint
from selenium import webdriver

import Utils.BaseUtils
import Utils.SignupUtils

class MeTest(unittest.TestCase):

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

	def test_swich_from_considering_to_nttc(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[0].click()
		Utils.BaseUtils.waittime(2)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[3].click()
		Utils.BaseUtils.waittime(2)
		self.driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
		Utils.BaseUtils.waittime(2)
		buttons[2].click()
		Utils.BaseUtils.waittime(2)

		rows = table.find_elements_by_tag_name("tableCell")
		rows[2].click()
		Utils.BaseUtils.waittime(2)

	def test_swich_from_considering_to_ttc(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[2].click()
		Utils.BaseUtils.waittime(2)

	def test_goto_successstories_page(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[5].click()
		Utils.BaseUtils.waittime(20)
		# get the window handles (webview)
		handle = self.driver.window_handles
		self.driver.switch_to_window(handle[0])
		Utils.BaseUtils.waittime(5)

	def test_switch_from_ttc_to_pregnant(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34002@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[3].click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Share!").is_displayed)

		
	def test_cancel_successstories(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[3].click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Share!").is_displayed)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[0].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
		# is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(15, len(rows))

	def test_successstories_later(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[3].click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Share!").is_displayed)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[4].click()
		Utils.BaseUtils.waittime(2)

	def test_successstories_settings(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[3].click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Share!").is_displayed)
		
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(2)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(2)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[0].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
		# is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(15, len(rows))

	def test_share_successstories(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[3].click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Share!").is_displayed)

		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason test")
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("jason test")
		
		self.driver.find_element_by_name("Share!").click()
		Utils.BaseUtils.waittime(2)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(8)
		ss = self.driver.find_element_by_name("Success Stories")
		self.assertTrue(ss)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[0].click()
		Utils.BaseUtils.waittime(2)


		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[2].click()
		Utils.BaseUtils.waittime(3)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[(len(rows)-6)].click()
		Utils.BaseUtils.waittime(3)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)

	def test_share_successstories_empty(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[3].click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Share!").is_displayed)

		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("           ")
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/webview[1]").send_keys("           ")
		
		self.driver.find_element_by_name("Share!").click()
		Utils.BaseUtils.waittime(2)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(8)
		ss = self.driver.find_element_by_name("Success Stories")
		self.assertTrue(ss)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[0].click()
		Utils.BaseUtils.waittime(2)


		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[2].click()
		Utils.BaseUtils.waittime(3)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[(len(rows)-6)].click()
		Utils.BaseUtils.waittime(3)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)

	def test_export_pdf_report(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[11].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[13].click()
		Utils.BaseUtils.waittime(2)

	def test_settings_gender(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[12].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[3].click()
		Utils.BaseUtils.waittime(2)

		self.driver.find_element_by_xpath("//window[3]/actionsheet[1]/button[1]").click

	def test_settings_push_notifications(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[12].click()
		Utils.BaseUtils.waittime(2)

		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.85, y:0.88}});")
		Utils.BaseUtils.waittime(2)


		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.85, y:0.88}});")
		Utils.BaseUtils.waittime(2)

	def test_logout(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[12].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[15].click()
		Utils.BaseUtils.waittime(2)
		Utils.BaseUtils.passAlert(self, self.driver, "Are you sure? You are about to log out.")

	def test_helpcenter_faq(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[13].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[1].click()
		Utils.BaseUtils.waittime(10)

		ss = self.driver.find_element_by_name("FAQ")
		self.assertTrue(ss)

	def test_helpcenter_gg(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[13].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[2].click()
		Utils.BaseUtils.waittime(3)

		self.assertTrue(self.driver.find_element_by_name("Details").is_displayed)

	def test_helpcenter_gg(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[13].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[3].click()
		Utils.BaseUtils.waittime(3)

		try:
			alert = self.driver.switch_to_alert()
			alert.accept()
		except Exception as err:
			print(err) 
		finally:
			table = self.driver.find_element_by_tag_name("tableView")
	        self.assertIsNotNone(table)
	        # is number of cells/rows inside table correct
	        rows = table.find_elements_by_tag_name("tableCell")
	        self.assertTrue(10 == len(rows) or 1 == len(rows))

	def test_helpcenter_web(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[13].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[4].click()
		Utils.BaseUtils.waittime(10)

		ss = self.driver.find_element_by_name("Full control over your")
		self.assertTrue(ss)

	def test_helpcenter_blog(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[13].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[5].click()
		Utils.BaseUtils.waittime(10)

		ss = self.driver.find_element_by_name("I was shocked.")
		self.assertTrue(ss)

	def test_helpcenter_facebook(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[13].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[6].click()
		Utils.BaseUtils.waittime(10)

		ss = self.driver.find_element_by_name("Facebook")
		self.assertTrue(ss)

	def test_helpcenter_twitter(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+00005@upwlabs.com","hui130124")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Me").click()
		Utils.BaseUtils.waittime(5)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[13].click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[7].click()
		Utils.BaseUtils.waittime(10)

		ss = self.driver.find_element_by_name("TWEETS")
		self.assertTrue(ss)

	def tearDown(self):
		self.driver.quit()


if __name__ == '__main__':
    unittest.main()