import unittest
import os
import time
import json
from random import randint

from selenium import webdriver
import selenium.webdriver.support.ui as ui
from selenium.webdriver.support.ui import WebDriverWait


FORUM_BASE_USER = "jason+a00005@upwlabs.com"
FORUM_BASE_PASSWORD = "123456"

HOME_BASE_USER = "jason+a00005@upwlabs.com"
HOME_BASE_PASSWORD = "123456"


CONTENT_URL = 'http://192.168.1.38:4723/wd/hub'
APP_PATH = "/Users/jason/Library/Developer/Xcode/DerivedData/emma-cwilhcksnuwkmwedfynijtortmke/Build/Products/Debug-iphonesimulator/emmadev.app"

def find_all_buttons(driver):
	buttons = driver.find_elements_by_class_name('UIAButton')
	# for button in buttons:
	# 	print "button" + button.get_attribute("name")
	return buttons

def clickbuttonbyname(driver,name):
	buttons = driver.find_elements_by_class_name('UIAButton')
	for button in buttons:
			if button.get_attribute("name") == name:
				driver.execute_script("mobile: tap", {"touchCount":"1", "x":button.location['x']+20, "y":button.location['y']+20})
				break;

def login_with_email(driver, *userinfo):
	email = driver.find_element_by_id("Email")
	password = driver.find_element_by_id("Password")
	if len(userinfo)==0:
		email.send_keys(userinfo[0])
		password.send_keys(userinfo[1])
	else:
		email.send_keys(userinfo[0])
		password.send_keys(userinfo[1])

	driver.find_element_by_name("Next").click()

def login_with_fb(driver, userinfo=None):
	facebook = driver.find_element_by_id("fb connect")
	facebook.click()
	waittime(5)

def login_with_mfp(driver, userinfo=None):
	mfp = driver.find_element_by_id("mfp connect")
	mfp.click()
	waittime(5)

def login_with_fitbit(driver, userinfo=None):
	fitbit = driver.find_element_by_id("Fitbit")
	fitbit.click()
	waittime(8)
	switch_mainview(driver)
	textfields = driver.find_element_by_id("email")
	secure = driver.find_element_by_id("password")
	if userinfo:
		textfields.send_keys(userinfo[0])
		secure.send_keys(userinfo[1])
	else:
		textfields.send_keys("jason+00003@upwlabs.com")
		secure.send_keys("hui130124")
	driver.find_element_by_id("oauth_login_allow").click()
	waittime(5)

def login_with_jawbone(driver, userinfo=None):
	jawbone = driver.find_element_by_id("Jawbone")
	jawbone.click()
	waittime(8)
	switch_mainview(driver)
	try:
		textfields = driver.find_element_by_name("email")
		secure = driver.find_element_by_name("pwd")
		if userinfo:
			textfields.send_keys(userinfo[0])
			secure.send_keys(userinfo[1])
		else:
			textfields.send_keys("jason+00005@upwlabs.com")
			secure.send_keys("hui130124")
		driver.find_element_by_xpath("//button[@type='submit']").click()
		waittime(5)
	finally:
		driver.find_element_by_xpath("//button[@type='submit']").click()
	waittime(5)
	
def switch_mainview(driver, index=None):
	if index == None:
		handle = driver.window_handles[0]
	else:
		handle = driver.window_handles[index]
	driver.switch_to_window(handle)

def find(driver, id):
	try:
		e = driver.find_element_by_id(id)
		if e:
			return e
		else:
			return False
	finally:
		print "not found" 

def wati_until_elementid(driver, timeout, id):
	element = None
	print "about to look for element"
	element = WebDriverWait(driver, timeout).until(find(driver, id))
	return element

def wati_until_element(driver, timeout, condition):
	wait = ui.WebDriverWait(driver, timeout)
	wait.until(lambda driver: condition)

def passAlert(self, driver, alertstring = None):
	alert = driver.switch_to_alert()
	# check if title of alert is correct
	if alertstring != None:
		self.assertEqual(alert.text, alertstring)
	alert.accept()

def forgetPassword(driver, email):
	driver.find_element_by_name("Forgot password").click()
	alert = driver.switch_to_alert()
	forgetpassword = driver.find_elements_by_id("Enter your email")
	forgetpassword.send_keys(email)
	driver.find_element_by_name("Send").click()

def adjustinhomeview(driver):
	element = wati_until_elementid(driver, 10, "background photo update")
	return element

def getwebviewpage(driver):
	source = driver.page_source
	print source

def getpage(driver):
	source = driver.page_source
	source = json.loads(source)
	print source

def find_by_text_basic(driver, text_value, **kwargs):
    s = '//*[contains(@text, "%s")]' % text_value
    lst = driver.find_elements_by_xpath(s)
    if lst:
    	print 'not null'
        return lst[0]
    else:
    	print 'null'
        return None

def waittime(num):
	time.sleep(num)
