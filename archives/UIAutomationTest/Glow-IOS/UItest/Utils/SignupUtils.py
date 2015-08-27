import unittest
import os
from random import randint
import random
from selenium import webdriver
import time
import json
import selenium.webdriver.support.ui as ui
import Utils.BaseUtils
from pymouse import PyMouse
from pykeyboard import PyKeyboard

def rand_str(length):
    return ''.join(random.choice('abcdefghijklmnopqrstuvw01234567890') for i in xrange(length))

def signup_ttc_with_email(driver, *userinfo):
	#assert
	assert 1 == 1
	# args = {'strategy': 'name', 'selector': 'Log in', 'action': 'tap'}
	# self.driver.execute_script("mobile: findAndAct", args)
	# Utils.BaseUtils.waittime(5)

	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[0].click()
	Utils.BaseUtils.waittime(3)

	# # go to step2
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[2].click()
	Utils.BaseUtils.waittime(3)

	# # appium bug try to use js to instuments js
	# # table = self.driver.find_element_by_name("Empty list")
	# # self.assertIsNotNone(table)
	# # rows = table.find_elements_by_tag_name("tableCell")
	# # rows[2].click()
	# # window.popover().tableViews()[0].cells()["District of Columbia"]
	# # script = '''
	# # 	var target = UIATarget.localTarget();
	# # 	var app = target.frontMostApp();
	# # 	var window = app.mainWindow();
	# # 	buttons = window.buttons();
	# # 	buttons[3].tap();
	# # 	'''
	# # self.driver.execute_script(script)
	# # click the first question
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[3].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"47", "y":"305"})
	Utils.BaseUtils.waittime(3)


	# # # click the second question
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[4].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"47", "y":"305"})
	Utils.BaseUtils.waittime(3)

	# # # click the third question
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[5].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
	Utils.BaseUtils.waittime(3)

	# # # click the forth question
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[6].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
	Utils.BaseUtils.waittime(3)

	# # click the fifth question
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[7].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
	Utils.BaseUtils.waittime(3)

	#next step
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[2].click()
	Utils.BaseUtils.waittime(5)


	# step2
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[3].click()
	Utils.BaseUtils.waittime(3)
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"47", "y":"305"})
	Utils.BaseUtils.waittime(3)

	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[4].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"103", "y":"215"})
	Utils.BaseUtils.waittime(3)

	driver.find_element_by_name("Done").click()
	Utils.BaseUtils.waittime(3)


	driver.find_element_by_name("Next").click()
	Utils.BaseUtils.waittime(3)

	# step3
	textfields = driver.find_elements_by_tag_name("textField")
	textfields[0].send_keys(userinfo[0])
	textfields[1].send_keys(userinfo[1])

	secure = driver.find_elements_by_tag_name("secure")
	
	secure[0].send_keys(userinfo[2])
	# self.driver.find_element_by_name("Full name").send_keys("jason")
	# self.driver.find_element_by_name("Email").send_keys("jason+0000000004@upwlabs.com")
	# self.driver.find_element_by_name("Password").send_keys("123456")
	driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.63, y:0.53}});")
	Utils.BaseUtils.waittime(3)
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"47", "y":"305"})
	driver.find_element_by_name("Next").click()
	Utils.BaseUtils.waittime(3)

	driver.find_element_by_name("Yes, it's correct!").click()
	Utils.BaseUtils.waittime(15)
	assert driver.find_element_by_xpath("//window[1]/tableview[1]/cell[3]")!= None


def signup_non_ttc_with_email(driver, *userinfo):
	#assert
	assert 1 == 1
	# args = {'strategy': 'name', 'selector': 'Log in', 'action': 'tap'}
	# self.driver.execute_script("mobile: findAndAct", args)
	# Utils.BaseUtils.waittime(5)

	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[0].click()
	Utils.BaseUtils.waittime(3)

	# # go to step2
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[3].click()
	Utils.BaseUtils.waittime(3)

	# # appium bug try to use js to instuments js
	# # table = self.driver.find_element_by_name("Empty list")
	# # self.assertIsNotNone(table)
	# # rows = table.find_elements_by_tag_name("tableCell")
	# # rows[2].click()
	# # window.popover().tableViews()[0].cells()["District of Columbia"]
	# # script = '''
	# # 	var target = UIATarget.localTarget();
	# # 	var app = target.frontMostApp();
	# # 	var window = app.mainWindow();
	# # 	buttons = window.buttons();
	# # 	buttons[3].tap();
	# # 	'''
	# # self.driver.execute_script(script)


	# # click the first question
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[3].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
	Utils.BaseUtils.waittime(3)


	# # # click the second question
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[4].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
	Utils.BaseUtils.waittime(3)

	# # # click the third question
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[5].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
	Utils.BaseUtils.waittime(3)

	# # # click the forth question
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[6].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"261", "y":"365"})
	Utils.BaseUtils.waittime(3)

	#next step
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[2].click()
	Utils.BaseUtils.waittime(5)


	# step2
	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[3].click()
	Utils.BaseUtils.waittime(3)
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"47", "y":"305"})
	Utils.BaseUtils.waittime(3)

	buttons = Utils.BaseUtils.find_all_buttons(driver)
	buttons[4].click()
	Utils.BaseUtils.waittime(3)

	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"103", "y":"215"})
	Utils.BaseUtils.waittime(3)

	driver.find_element_by_name("Done").click()
	Utils.BaseUtils.waittime(3)


	driver.find_element_by_name("Next").click()
	Utils.BaseUtils.waittime(3)

	# step3
	textfields = driver.find_elements_by_tag_name("textField")
	textfields[0].send_keys(userinfo[0])
	textfields[1].send_keys(userinfo[1])

	secure = driver.find_elements_by_tag_name("secure")
	
	secure[0].send_keys(userinfo[2])
	# self.driver.find_element_by_name("Full name").send_keys("jason")
	# self.driver.find_element_by_name("Email").send_keys("jason+0000000004@upwlabs.com")
	# self.driver.find_element_by_name("Password").send_keys("123456")
	driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[\"Empty list\"].tapWithOptions({tapOffset:{x:0.63, y:0.53}});")
	Utils.BaseUtils.waittime(3)
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"47", "y":"305"})
	driver.find_element_by_name("Next").click()
	Utils.BaseUtils.waittime(3)

	driver.find_element_by_name("Yes, it's correct!").click()
	Utils.BaseUtils.waittime(15)
	assert driver.find_element_by_xpath("//window[1]/tableview[1]/cell[3]")!= None

def finfish_tutorials(driver):

	#step 1
	#This is a known issue with Instruments for Xcode 5+, If you'd like this to work downgrade to Xcode 4.6 and it will.
	args = {"touchCount": 1, "startX": 255.00, "startY": 135.00, "endX": 15.00, "endY": 135.00, "duration": 1.2}
	driver.execute_script("mobile: swipe", args)
	Utils.BaseUtils.waittime(3)

	#step 2
	args = {"touchCount": 1, "startX": 165.00, "startY": 88.50, "endX": 165.00, "endY": 445.50, "duration": 1.2}
	try:
		driver.execute_script("mobile: swipe", args)
	finally:
		pass
	Utils.BaseUtils.waittime(3)

	#step 3
	args = {"touchCount": 1, "startX": 165.00, "startY": 88.50, "endX": 165.00, "endY": 445.50, "duration": 1.2}
	try:
		driver.execute_script("mobile: swipe", args)
	finally:
		pass
	Utils.BaseUtils.waittime(3)

	#step 4
	driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().buttons()[1].tap();")
	Utils.BaseUtils.waittime(5)
	#cancle invite
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"35", "y":"104"})


	Utils.BaseUtils.waittime(10)
	#assert
	assert driver.find_element_by_xpath("//window[1]/tableview[1]/group[2]")!= None

def swipe_left(driver, startX=None, startY=None, endX=None, endY=None):
	if startX == None:
		startX = 255.00
	if startY == None:
		startY = 135.00
	if endX == None:
		endX = 15.00
	if endY == None:
		endY = 135.00
	args = {"touchCount": 1, "startX": startX, "startY": startY, "endX": endX, "endY": endY, "duration": 1.2}
	try:
		driver.execute_script("mobile: swipe", args)
	finally:
		pass
	Utils.BaseUtils.waittime(3)

def swipe_right(driver):
	args = {"touchCount": 1, "startX": 15.00, "startY": 135.00, "endX": 255.00, "endY": 135.00, "duration": 1.2}
	try:
		driver.execute_script("mobile: swipe", args)
	finally:
		pass
	Utils.BaseUtils.waittime(3)

def swipe_down(driver):
	args = {"touchCount": 1, "startX": 165.00, "startY": 88.50, "endX": 165.00, "endY": 445.50, "duration": 1.2}
	try:
		driver.execute_script("mobile: swipe", args)
	finally:
		pass
	Utils.BaseUtils.waittime(3)

def swipe_up(driver):
	args = {"touchCount": 1, "startX": 165.00, "startY": 445.50, "endX": 165.00, "endY": 155.50, "duration": 1.2}
	try:
		driver.execute_script("mobile: swipe", args)
	finally:
		pass
	Utils.BaseUtils.waittime(3)

def swipe_left_tomorrow(driver):
	args = {"touchCount": 1, "startX": 160.00, "startY": 150.00, "endX": 95.00, "endY": 150.00, "duration": 1.2}
	try:
		driver.execute_script("mobile: swipe", args)
	finally:
		pass
	Utils.BaseUtils.waittime(3)

def swipe_down_periodlog(driver):
	args = {"touchCount": 1, "startX": 165.00, "startY": 200, "endX": 165.00, "endY": 500, "duration": 1.5}
	try:
		driver.execute_script("mobile: swipe", args)
	finally:
		pass
	Utils.BaseUtils.waittime(3)

def finish_community_tutorils(driver):
	driver.find_element_by_name("Community").click()
	Utils.BaseUtils.waittime(2)
	driver.find_element_by_xpath("//window[1]/navigationBar[1]").click()
	Utils.BaseUtils.waittime(2)
	driver.find_element_by_xpath("//window[1]/tableview[2]/cell[2]/text[1]").click()
	Utils.BaseUtils.waittime(2)
	swipe_left(driver)
	Utils.BaseUtils.waittime(3)

def click_NFP(driver):
	driver.execute_script("UIATarget.localTarget().frontMostApp().mainWindow().scrollViews()[0].staticTexts()[5].tapWithOptions({tapOffset:{x:0.81, y:0.26}});")
	Utils.BaseUtils.waittime(3)

def click_popclose(driver):
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"25", "y":"115"})
	Utils.BaseUtils.waittime(3)




