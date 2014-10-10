import unittest
import os
from datetime import datetime
import sys

from random import randint
from selenium import webdriver

import Utils.BaseUtils
import Utils.SignupUtils

NONTTC_DAILY_LOG = ['Did you have sex?, FEMALE POSITION DURING MALE EJACULATION, BIRTH CONTROL USED', 'Physical discomfort?, SYMPTOMS', 'Emotional discomfort?, I\'M FEELING', 
				 'Update weight', 'Did you exercise?, DURATION', 'Additional info', 'Update BBT','Performed CM check?, CM TEXTURE, CM AMOUNT', 'Any spotting?, HOW IT LOOKS',
				 'Cervical feel/position?', 'Did you smoke?, CIGARETTE(S), 1, 10, 20+', 'Did you drink alcohol?, GLASS(ES), 1, 5, 10+', 'Ovulation test, TEST RESULT', 'Pregnancy test, TEST RESULT', 
				 'Medication / supplement', 'Add a new med / supplement','Feel stressed?, STRESS LEVEL, Low, Medium, High','Cervical position?'
				]

class DailylogTest(unittest.TestCase):

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

	def test_nonttc_dailylog(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35050@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[1].click()
		Utils.BaseUtils.waittime(8)

		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(17, len(rows))
		for row in rows:
			if row.get_attribute("name") in NONTTC_DAILY_LOG:
				self.assertTrue(True)
			else:
				self.assertTrue(True)

	def test_considering_dailylog(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35051@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[1].click()
		Utils.BaseUtils.waittime(8)
		
		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(16, len(rows))
		for row in rows:
			# print "con" + row.get_attribute("name")
			# print row.get_attribute("name")
			if row.get_attribute("name") == "Did you have sex?, FEMALE POSITION DURING MALE EJACULATION, Female orgasm?":
				self.assertTrue(True)
				continue
			if row.get_attribute("name") in NONTTC_DAILY_LOG:
				self.assertTrue(True)
			else:
				self.assertTrue(False)

	def test_ttc_dailylog(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35052@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[1].click()
		Utils.BaseUtils.waittime(8)
		
		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(17, len(rows))
		for row in rows:
			# print "ttc" + row.get_attribute("name")
			if row.get_attribute("name") == "Did you have sex?, FEMALE POSITION DURING MALE EJACULATION, Female orgasm?":
				self.assertTrue(True)
				continue
			if row.get_attribute("name") in NONTTC_DAILY_LOG:
				self.assertTrue(True)
			else:
				self.assertTrue(False)

	def test_pregnant_dailylog(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35055@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[1].click()
		Utils.BaseUtils.waittime(8)
		
		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(17, len(rows))
		for row in rows:
			# print "pre" + row.get_attribute("name")
			if row.get_attribute("name") == "Did you have sex?, FEMALE POSITION DURING MALE EJACULATION, Female orgasm?":
				self.assertTrue(True)
				continue
			if row.get_attribute("name") in NONTTC_DAILY_LOG:
				self.assertTrue(True)
			else:
				self.assertTrue(False)

	def test_add_dailylog(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35060@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		rows[1].click()
		Utils.BaseUtils.waittime(8)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		# sex
		buttons[3].click()
		try:
			driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
			Utils.BaseUtils.waittime(3)
		except:
			pass
		Utils.BaseUtils.waittime(2)
		buttons[9].click()
		try:
			driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
			Utils.BaseUtils.waittime(3)
		except:
			pass

		Utils.SignupUtils.swipe_up(self.driver)
		# discomfort
		buttons[11].click()
		try:
			driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
			Utils.BaseUtils.waittime(3)
		except:
			pass
		Utils.BaseUtils.waittime(2)

		Utils.SignupUtils.swipe_up(self.driver)
		# save
		self.driver.find_element_by_name("Save all changes").click()
		Utils.BaseUtils.waittime(2)

		self.assertTrue(self.driver.find_element_by_name("Logged!, Log daily to get health tips!").is_displayed)

	def test_add_note(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35062@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		table = self.driver.find_element_by_name("Empty list")
		rows = table.find_elements_by_tag_name("tableCell")
		before = len(rows)

		Utils.SignupUtils.swipe_up(self.driver)
		Utils.SignupUtils.swipe_up(self.driver)
		Utils.SignupUtils.swipe_up(self.driver)
		Utils.BaseUtils.waittime(2)

		self.driver.find_element_by_name("Add a note...").click()
		Utils.BaseUtils.waittime(5)

		self.driver.execute_script("UIATarget.localTarget().frontMostApp().keyboard().typeString(\"jason test\\n\");")
		Utils.BaseUtils.waittime(3)

		Utils.SignupUtils.swipe_down(self.driver)
		Utils.SignupUtils.swipe_down(self.driver)
		table = self.driver.find_element_by_name("Empty list")
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(before + 1, len(rows))

	def test_delete_note(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35062@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		before = len(rows)

		Utils.SignupUtils.swipe_up(self.driver)
		Utils.SignupUtils.swipe_up(self.driver)
		Utils.SignupUtils.swipe_up(self.driver)
		Utils.SignupUtils.swipe_up(self.driver)
		Utils.BaseUtils.waittime(2)

		self.driver.find_element_by_name("Add a note...").click()
		Utils.BaseUtils.waittime(5)

		self.driver.execute_script("UIATarget.localTarget().frontMostApp().keyboard().typeString(\"jason delete test\\n\");")
		Utils.BaseUtils.waittime(3)
		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(before + 1, len(rows))

		x = rows[5].location['x']
		y = rows[5].location['y']
		row = rows[5].size
		x1 = row['width']
		y1 = row['height']
		Utils.SignupUtils.swipe_left(self.driver,x+x1*7/8,y+y1/2,x+x1*1/8,y+y1/2)
		Utils.BaseUtils.waittime(1)
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		for button in buttons:
			if button.get_attribute("name") == "Delete":
				button.click()

		Utils.SignupUtils.swipe_down(self.driver)
		Utils.SignupUtils.swipe_down(self.driver)
		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		self.assertEqual(before, len(rows))

	def test_add_dailylog_hidden(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35060@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		before = len(rows)
		print before

		rows[1].click()
		Utils.BaseUtils.waittime(8)

		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		# sex
		buttons[3].click()
		try:
			driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
			Utils.BaseUtils.waittime(3)
		except:
			pass
		Utils.BaseUtils.waittime(2)
		buttons[9].click()
		try:
			driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
			Utils.BaseUtils.waittime(3)
		except:
			pass

		Utils.SignupUtils.swipe_up(self.driver)
		# discomfort
		buttons[11].click()
		try:
			driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
			Utils.BaseUtils.waittime(3)
		except:
			pass
		Utils.BaseUtils.waittime(2)

		Utils.SignupUtils.swipe_up(self.driver)


		#dailylog customize
		self.driver.find_element_by_name("dailylog customize").click()
		Utils.BaseUtils.waittime(2)

		Utils.SignupUtils.swipe_down(self.driver)
		Utils.SignupUtils.swipe_down(self.driver)
		Utils.SignupUtils.swipe_down(self.driver)

		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[3]/switch[1]").click()
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_name("Save").click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		self.assertIsNotNone(table)
	    # is number of cells/rows inside table correct
		rows = table.find_elements_by_tag_name("tableCell")
		after = len(rows)
		print after

		self.assertTrue(before != after)


	def tearDown(self):
		self.driver.quit()


if __name__ == '__main__':
    unittest.main()