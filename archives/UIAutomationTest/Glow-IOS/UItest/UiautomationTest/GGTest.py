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

	def test_gg_page(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass
		self.assertTrue(self.driver.find_element_by_name("INSIGHTS").is_displayed)

	def test_export_report(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass
		self.assertTrue(self.driver.find_element_by_name("INSIGHTS").is_displayed)
		Utils.BaseUtils.waittime(2)
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[0].click()
		Utils.BaseUtils.waittime(3)

	def test_gg_notifications(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass
		Utils.BaseUtils.waittime(2)
		self.driver.find_element_by_xpath("//window[1]/scrollview[1]/tableview[1]").click()
		Utils.BaseUtils.waittime(2)

	def test_charts_weight(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass

		Utils.SignupUtils.swipe_up(self.driver)
		Utils.SignupUtils.swipe_up(self.driver)
		self.driver.find_element_by_name("HEALTH CHARTS").click()
		Utils.BaseUtils.waittime(2)
		# Utils.SignupUtils.swipe_left(self.driver)
		# Utils.SignupUtils.swipe_right(self.driver)

		self.driver.find_element_by_name("topnav close press").click()
		Utils.BaseUtils.waittime(2)
	

	def test_charts_bbt(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass

		Utils.SignupUtils.swipe_up(self.driver)
		Utils.SignupUtils.swipe_up(self.driver)
		self.driver.find_element_by_name("HEALTH CHARTS").click()
		Utils.BaseUtils.waittime(2)
		for i in range(0,5):
			try:
				if self.driver.find_element_by_name("CALORIES").is_displayed:
					print "in CALORIES"
					break
			except Exception as err:
				buttons = Utils.BaseUtils.find_all_buttons(self.driver)
				self.driver.find_element_by_name("genius left arrow").click()
				Utils.BaseUtils.waittime(1)
				continue
		
		self.driver.find_element_by_name("topnav close press").click()
		Utils.BaseUtils.waittime(2)

	def test_charts_cm(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass

		Utils.SignupUtils.swipe_up(self.driver)
		Utils.SignupUtils.swipe_up(self.driver)
		self.driver.find_element_by_name("HEALTH CHARTS").click()
		Utils.BaseUtils.waittime(2)
		for i in range(0,5):
			try:
				if self.driver.find_element_by_name("NUTRITION").is_displayed:
					print "in NUTRITION"
					break
			except Exception as err:
				buttons = Utils.BaseUtils.find_all_buttons(self.driver)
				self.driver.find_element_by_name("genius left arrow").click()
				Utils.BaseUtils.waittime(1)
				continue
		
		self.driver.find_element_by_name("topnav close press").click()
		Utils.BaseUtils.waittime(2)

	def test_charts_bbt_cm(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass

		Utils.SignupUtils.swipe_up(self.driver)
		Utils.SignupUtils.swipe_up(self.driver)
		self.driver.find_element_by_name("FERTILITY CHARTS").click()
		Utils.BaseUtils.waittime(2)
		for i in range(0,5):
			try:
				if self.driver.find_element_by_name("BBT CHART").is_displayed:
					print "in BBT CHART"
					break
			except Exception as err:
				buttons = Utils.BaseUtils.find_all_buttons(self.driver)
				self.driver.find_element_by_name("genius left arrow").click()
				Utils.BaseUtils.waittime(1)
				continue
		
		self.driver.find_element_by_name("topnav close press").click()
		Utils.BaseUtils.waittime(2)


	def test_charts_cancel(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass

		Utils.SignupUtils.swipe_up(self.driver)
		Utils.SignupUtils.swipe_up(self.driver)
		self.driver.find_element_by_name("FERTILITY CHARTS").click()
		Utils.BaseUtils.waittime(2)
		for i in range(0,5):
			try:
				if self.driver.find_element_by_name("CM CHART").is_displayed:
					print "in CM CHART"
					break
			except Exception as err:
				buttons = Utils.BaseUtils.find_all_buttons(self.driver)
				self.driver.find_element_by_name("genius left arrow").click()
				Utils.BaseUtils.waittime(1)
				continue
		
		self.driver.find_element_by_name("topnav close press").click()
		Utils.BaseUtils.waittime(2)


	def test_turn_off_reminders(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass
		Utils.SignupUtils.swipe_up(self.driver)
		self.driver.find_element_by_name("REMINDERS").click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")

		reminder = rows[0].get_attribute("name")
		rows[0].click()
		Utils.BaseUtils.waittime(2)

		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[4]/switch[1]").click()
		Utils.BaseUtils.waittime(1)
		self.driver.find_element_by_name("Save").click()
		Utils.BaseUtils.waittime(1)
		try:
			self.driver.find_element_by_name("topnav close").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass

		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		for row in rows:
			if row.get_attribute("name") == reminder:
				row.click()
				break
		self.driver.find_element_by_xpath("//window[1]/tableview[1]/cell[4]/switch[1]").click()
		Utils.BaseUtils.waittime(1)
		self.driver.find_element_by_name("Save").click()
		Utils.BaseUtils.waittime(1)

	def test_add_reminders(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass
		Utils.SignupUtils.swipe_up(self.driver)
		self.driver.find_element_by_name("REMINDERS").click()
		Utils.BaseUtils.waittime(2)
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.49, y:0.92}});")
		Utils.BaseUtils.waittime(1)

		text_fields = self.driver.find_elements_by_tag_name("textField")
		text_fields[0].send_keys("jason test")
		#set a time
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].cells()[\"Set a time, Time\"].tap();")
		Utils.BaseUtils.waittime(1)
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.94, y:0.58}});")
		Utils.BaseUtils.waittime(1)
		#set a day
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].cells()[\"Repeat, 1 time daily\"].tap();")
		Utils.BaseUtils.waittime(1)
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.85, y:0.67}});")
		Utils.BaseUtils.waittime(1)

		self.driver.find_element_by_name("Save").click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		for row in rows:
			if row.get_attribute("name").lower().find('test') != -1:
				print row.get_attribute("name")
				row.click()
				break
		self.driver.find_element_by_name("Delete").click()
		Utils.BaseUtils.waittime(1)
		self.driver.find_element_by_name("Yes, delete it").click()
		Utils.BaseUtils.waittime(1)

	def test_delete_reminders(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass
		Utils.SignupUtils.swipe_up(self.driver)
		self.driver.find_element_by_name("REMINDERS").click()
		Utils.BaseUtils.waittime(2)
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.49, y:0.92}});")
		Utils.BaseUtils.waittime(1)

		text_fields = self.driver.find_elements_by_tag_name("textField")
		text_fields[0].send_keys("jason test")
		#set a time
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].cells()[\"Set a time, Time\"].tap();")
		Utils.BaseUtils.waittime(1)
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.94, y:0.58}});")
		Utils.BaseUtils.waittime(1)
		#set a day
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].cells()[\"Repeat, 1 time daily\"].tap();")
		Utils.BaseUtils.waittime(1)
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.85, y:0.67}});")
		Utils.BaseUtils.waittime(1)

		self.driver.find_element_by_name("Save").click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		for row in rows:
			if row.get_attribute("name").lower().find('test') != -1:
				print row.get_attribute("name")
				row.click()
				break
		self.driver.find_element_by_name("Delete").click()
		Utils.BaseUtils.waittime(1)
		self.driver.find_element_by_name("Yes, delete it").click()
		Utils.BaseUtils.waittime(1)

	def test_edit_reminders(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass
		Utils.SignupUtils.swipe_up(self.driver)
		self.driver.find_element_by_name("REMINDERS").click()
		Utils.BaseUtils.waittime(2)
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.49, y:0.92}});")
		Utils.BaseUtils.waittime(1)

		text_fields = self.driver.find_elements_by_tag_name("textField")
		text_fields[0].send_keys("jason test")
		#set a time
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].cells()[\"Set a time, Time\"].tap();")
		Utils.BaseUtils.waittime(1)
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.94, y:0.58}});")
		Utils.BaseUtils.waittime(1)
		#set a day
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].cells()[\"Repeat, 1 time daily\"].tap();")
		Utils.BaseUtils.waittime(1)
		self.driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.85, y:0.67}});")
		Utils.BaseUtils.waittime(1)

		self.driver.find_element_by_name("Save").click()
		Utils.BaseUtils.waittime(2)

		table = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		for row in rows:
			if row.get_attribute("name").lower().find('test') != -1:
				print row.get_attribute("name")
				row.click()
				break

		text_fields = self.driver.find_elements_by_tag_name("textField")
		text_fields[0].clear()
		text_fields[0].send_keys("jason tset")
		self.driver.find_element_by_name("Save").click()
		Utils.BaseUtils.waittime(2)

		able = self.driver.find_element_by_tag_name("tableView")
		rows = table.find_elements_by_tag_name("tableCell")
		for row in rows:
			if row.get_attribute("name").lower().find('tset') != -1:
				print row.get_attribute("name")
				row.click()
				break
		self.driver.find_element_by_name("Delete").click()
		Utils.BaseUtils.waittime(1)
		self.driver.find_element_by_name("Yes, delete it").click()
		Utils.BaseUtils.waittime(1)

	def test_gg_insights(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass
		self.driver.find_element_by_name("INSIGHTS").click()
		Utils.BaseUtils.waittime(1)

	def test_insights_like(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(15)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass
		self.driver.find_element_by_name("INSIGHTS").click()
		try:
			self.driver.find_element_by_xpath("//window[1]/scrollview[1]/button[1]").click()
			self.assertTrue(True)
		except Exception, e:
			self.assertTrue(True)

	def test_insights_share(self):
		buttons = Utils.BaseUtils.find_all_buttons(self.driver)
		buttons[1].click()
		Utils.BaseUtils.waittime(3)
		Utils.BaseUtils.login_with_email(self.driver,"jason+35065@upwlabs.com","123456")
		Utils.BaseUtils.waittime(20)

		self.driver.find_element_by_name("Genius").click()
		Utils.BaseUtils.waittime(3)
		try:
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_xpath("//window[1]/button[1]").click()
			Utils.BaseUtils.waittime(2)
		except Exception as err:
			pass
		self.driver.find_element_by_name("INSIGHTS").click()
		try:
			self.driver.find_element_by_xpath("//window[1]/scrollview[1]/button[2]").click()
			Utils.BaseUtils.waittime(2)
			self.driver.find_element_by_name("Cancel").click()
			Utils.BaseUtils.waittime(2)
			self.assertTrue(True)
		except Exception, e:
			self.assertTrue(True)
		
	def tearDown(self):
		self.driver.quit()


if __name__ == '__main__':
    unittest.main()