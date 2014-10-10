import unittest
import os
from random import randint
from selenium import webdriver

import Utils.BaseUtils
import Utils.SignupUtils
import json

class GlowFirstTest(unittest.TestCase):

	def setUp(self):
        # set up appium
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
	
	def test_glowfirst_page(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		self.driver.find_element_by_name("Glow First").click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("Details").is_displayed)
		self.assertTrue(self.driver.find_element_by_name("Apply").is_displayed)

	def test_glowfirst_detail_page(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		self.driver.find_element_by_name("Glow First").click()
		Utils.BaseUtils.waittime(5)
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[0].click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("TERMS").is_displayed)

	def test_glowfirst_clinics(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		self.driver.find_element_by_name("Glow First").click()
		Utils.BaseUtils.waittime(5)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[0].click()
		Utils.BaseUtils.waittime(2)
		self.assertTrue(self.driver.find_element_by_name("TERMS").is_displayed)
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[3].click()
		try:
			alert = self.driver.switch_to_alert()
			alert.accept()
			buttons[3].click()
		except Exception as err:
			print(err) 
		finally:
			table = self.driver.find_element_by_tag_name("tableView")
	        self.assertIsNotNone(table)
	        # is number of cells/rows inside table correct
	        rows = table.find_elements_by_tag_name("tableCell")
	        self.assertTrue(10 == len(rows) or 1 == len(rows))

	def test_glowfirst_self_fund(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		self.driver.find_element_by_name("Glow First").click()
		Utils.BaseUtils.waittime(5)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(2)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(2)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[3].click()
		buttons[4].click()
		buttons[5].click()
		buttons[6].click()
		buttons[7].click()
		Utils.BaseUtils.waittime(2)
		buttons[2].click()
		try:
			alert = self.driver.switch_to_alert()
			alert.accept()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			print(err) 
		finally:
			buttons = Utils.BaseUtils.find_all_buttons(self.driver)
			buttons[2].click()
			table = self.driver.find_element_by_tag_name("tableView")
			self.assertIsNotNone(table)
	        # is number of cells/rows inside table correct
			rows = table.find_elements_by_tag_name("tableCell")
			self.assertEqual(4, len(rows))
		text_fields = self.driver.find_elements_by_tag_name("textField")
		text_fields[0].send_keys("4005550000000019")
		text_fields[1].send_keys("0615")
		text_fields[2].send_keys("0019")
		text_fields[3].send_keys("jason")

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(5)
		alert = self.driver.switch_to_alert()
		alert.accept()

	def test_glowfirst_employee_fund(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		self.driver.find_element_by_name("Glow First").click()
		Utils.BaseUtils.waittime(5)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(2)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[3].click()
		Utils.BaseUtils.waittime(2)
		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(3, len(rows))
		text_fields = self.driver.find_elements_by_tag_name("textField")
		text_fields[0].send_keys("jason+34001@upwlabs.com")
		text_fields[1].send_keys("jason")

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(5)
		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(1, len(rows))

	def test_glowfirst_employee_fund_switch(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		self.driver.find_element_by_name("Glow First").click()
		Utils.BaseUtils.waittime(5)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(2)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[3].click()
		Utils.BaseUtils.waittime(2)

		text_fields = self.driver.find_elements_by_tag_name("textField")
		text_fields[0].send_keys("jason+34001@upwlabs.com")
		text_fields[1].send_keys("jason")

		self.driver.find_elements_by_tag_name("text")[7].click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_name("Cancel").click()
		Utils.BaseUtils.waittime(2)


	def test_glowfirst_employee_fund_via_paystub(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+34001@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)
		self.driver.find_element_by_name("Glow First").click()
		Utils.BaseUtils.waittime(5)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(2)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[3].click()
		Utils.BaseUtils.waittime(2)


		self.driver.find_elements_by_tag_name("text")[7].click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_name("Take photo").click()
		Utils.BaseUtils.waittime(5)
		self.driver.find_element_by_name("PhotoCapture").click()
		Utils.BaseUtils.waittime(5)
		self.driver.find_element_by_name("Use Photo").click()
		Utils.BaseUtils.waittime(5)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[2].click()
		Utils.BaseUtils.waittime(5)

   	def tearDown(self):
		self.driver.quit()

if __name__ == '__main__':
    unittest.main()