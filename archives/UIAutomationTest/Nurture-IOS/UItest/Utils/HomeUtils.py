import unittest
import os
import time
import json
from random import randint,choice

from selenium import webdriver
import selenium.webdriver.support.ui as ui
from selenium.webdriver.support.ui import WebDriverWait


def today():
	return time.strftime("%b %d, %Y", time.localtime())

def clicktodaybutton(driver):
	buttons = driver.find_elements_by_class_name('UIAButton')
	for button in buttons:
			if button.get_attribute("name") == today():
				driver.execute_script("mobile: tap", {"touchCount":"1", "x":button.location['x']+20, "y":button.location['y']+20})
				break;

def click_backtoday(driver):
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":250, "y":160})
	waittime(3)

def click_see_all_appointments(driver):
	buttons = driver.find_elements_by_class_name('UIAButton')
	for button in buttons:
		if button.get_attribute("name") == "See all appointments":
			driver.execute_script("mobile: tap", {"touchCount":"1", "x":button.location['x']+20, "y":button.location['y']+20})
			break;

def click_suggest_article(driver):
	buttons = driver.find_elements_by_class_name('UIAButton')
	for button in buttons:
		if button.get_attribute("name") == "Suggest an article":
			if button.location['y'] <= 0:
				continue
			driver.execute_script("mobile: tap", {"touchCount":"1", "x":button.location['x']+20, "y":button.location['y']+5})
			break;

def today_no_dailylog(driver):
	flag = False
	table = driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[2]/UIATableView[2]")
	rows = table.find_elements_by_class_name("UIATableCell")
	for row in rows:
		if "Complete today's log to learn unique insights about your pregnancy. And don't forget to add a picture of your belly!" in row.get_attribute("name"):
			flag = True
	return flag

def suggest_article(self,userlink):
	click_suggest_article(self.driver)
	waittime(3)
	self.assertTrue(self.driver.find_element_by_name("Suggestions").is_displayed())
	textfields = self.driver.find_elements_by_class_name("UIATextField")
	textfields[0].send_keys(userlink)
	waittime()
	self.driver.hide_keyboard('Next')
	waittime(5)
	self.driver.find_element_by_name("Stage, First trimester").click()
	waittime()
	self.driver.execute_script("mobile: tap", {"touchCount":"1", "x":"280", "y":"380"})
	waittime()
	self.driver.find_element_by_name("Next").click()

def waittime(num=None):
	if num:
		time.sleep(num)
	else:
		time.sleep(1)