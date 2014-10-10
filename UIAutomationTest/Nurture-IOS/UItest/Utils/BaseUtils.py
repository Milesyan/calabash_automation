import unittest
import os
import time
import json
from random import randint,choice

from selenium import webdriver
import selenium.webdriver.support.ui as ui
from selenium.webdriver.support.ui import WebDriverWait


CONTENT_URL = 'http://192.168.1.20:4723/wd/hub'
APP_PATH = "/Users/jason/Library/Developer/Xcode/DerivedData/"
APP_S = "kaylee-ctoxvyjugvbxemgfqcylxxmeceed/"
SIMULATOR = "Build/Products/Debug-iphonesimulator/kayleedev.app"
IPHONE = "Build/Products/Debug-iphoneos/kayleedev.app"
MOM = ["jason+e00001@upwlabs.com","123456"]
DAD = ["jason+e00002@upwlabs.com","123456"]
UN_MOM = ["jason+mom@upwlabs.com","123456"]
UN_DAD = ["jason+dad@upwlabs.com","123456"]
IV_MOM = ["jason+n00030@upwlabs.com","123456"]
IV_DAD = ["jason+n00031@upwlabs.com","123456"]
UN_DAILY_LOG = ["jason+e00003@upwlabs.com","123456"]
DAILY_LOG = ["jason+e00005@upwlabs.com","123456"]

CAPABILITIES = {
                'platformName': 'iOS',
                'deviceName': 'iPhone Simulator',
                'platform': 'Mac',
                'platformVersion': '7.1',
                'app': APP_PATH + APP_S + IPHONE
                	}



# def find_all_buttons(driver):
# 	buttons = driver.find_elements_by_tag_name("button")
# 	# for button in buttons:
# 	# 	print "button" + button.get_attribute("name")
# 	return buttons

# def login_with_email(driver, *userinfo):
# 	email = driver.find_element_by_id("Email")
# 	password = driver.find_element_by_id("Password")
# 	if len(userinfo)==0:
# 		email.send_keys(userinfo[0])
# 		password.send_keys(userinfo[1])
# 	else:
# 		email.send_keys(userinfo[0])
# 		password.send_keys(userinfo[1])

# 	driver.find_element_by_name("Next").click()

# def login_with_fb(driver, userinfo=None):
# 	facebook = driver.find_element_by_id("fb connect")
# 	facebook.click()
# 	waittime(5)

# def login_with_mfp(driver, userinfo=None):
# 	mfp = driver.find_element_by_id("mfp connect")
# 	mfp.click()
# 	waittime(5)

# def login_with_fitbit(driver, userinfo=None):
# 	fitbit = driver.find_element_by_id("Fitbit")
# 	fitbit.click()
# 	waittime(8)
# 	switch_mainview(driver)
# 	textfields = driver.find_element_by_id("email")
# 	secure = driver.find_element_by_id("password")
# 	if userinfo:
# 		textfields.send_keys(userinfo[0])
# 		secure.send_keys(userinfo[1])
# 	else:
# 		textfields.send_keys("jason+00003@upwlabs.com")
# 		secure.send_keys("hui130124")
# 	driver.find_element_by_id("oauth_login_allow").click()
# 	waittime(5)

# def login_with_jawbone(driver, userinfo=None):
# 	jawbone = driver.find_element_by_id("Jawbone")
# 	jawbone.click()
# 	waittime(8)
# 	switch_mainview(driver)
# 	try:
# 		textfields = driver.find_element_by_name("email")
# 		secure = driver.find_element_by_name("pwd")
# 		if userinfo:
# 			textfields.send_keys(userinfo[0])
# 			secure.send_keys(userinfo[1])
# 		else:
# 			textfields.send_keys("jason+00005@upwlabs.com")
# 			secure.send_keys("hui130124")
# 		driver.find_element_by_xpath("//button[@type='submit']").click()
# 		waittime(5)
# 	finally:
# 		driver.find_element_by_xpath("//button[@type='submit']").click()
# 	waittime(5)
	
# def switch_mainview(driver, index=None):
# 	if index == None:
# 		handle = driver.window_handles[0]
# 	else:
# 		handle = driver.window_handles[index]
# 	driver.switch_to_window(handle)

# def find(driver, id):
# 	try:
# 		e = driver.find_element_by_id(id)
# 		if e:
# 			return e
# 		else:
# 			return False
# 	finally:
# 		print "not found" 

# def wati_until_elementid(driver, timeout, id):
# 	element = None
# 	print "about to look for element"
# 	element = WebDriverWait(driver, timeout).until(find(driver, id))
# 	return element

# def wati_until_element(driver, timeout, condition):
# 	wait = ui.WebDriverWait(driver, timeout)
# 	wait.until(lambda driver: condition)

def passAlert(driver, alertstring=None):
	alert = driver.switch_to_alert()
	# check if title of alert is correct
	if alertstring != None:
		pass
		# self.assertEqual(alert.text, alertstring)
	if alert:
		alert.accept()

def forgetPassword(driver, email):
	driver.find_element_by_name("Forgot password").click()
	alert = driver.switch_to_alert()
	forgetpassword = driver.find_elements_by_class_name("UIATextField")
	forgetpassword[-1].send_keys(email)
	driver.find_element_by_name("Send").click()

# def adjustinhomeview(driver):
# 	element = wati_until_elementid(driver, 10, "background photo update")
# 	return element

# def getwebviewpage(driver):
# 	source = driver.page_source
# 	print source

# def getpage(driver):
# 	source = driver.page_source
# 	source = json.loads(source)
# 	print source

# def find_by_text_basic(driver, text_value, **kwargs):
#     s = '//*[contains(@text, "%s")]' % text_value
#     lst = driver.find_elements_by_xpath(s)
#     if lst:
#     	print 'not null'
#         return lst[0]
#     else:
#     	print 'null'
#         return None


def swipe_up(driver,num):
	for i in range(1, num):
		driver.swipe(start_x=165.00, start_y=418.50, end_x=165.00, end_y=88.50, duration=800)
		waittime(1)

def swipe_left(driver,num):
	for i in range(1, num):
		driver.swipe(start_x=35.00, start_y=88.50, end_x=288.50, end_y=88.50, duration=800)
		waittime(1)

def swipe_right(driver,num):
	for i in range(1, num):
		driver.swipe(start_x=288.50, start_y=88.50, end_x=35.00, end_y=88.50, duration=800)
		waittime(1)

def swipe_down(driver,num):
	for i in range(1, num):
		driver.swipe(start_x=165.00, start_y=88.50, end_x=165.00, end_y=418.50, duration=800)
		waittime(1)

def waittime(num=None):
	if num:
		time.sleep(num)
	else:
		time.sleep(1)

def waitforstatusbar(driver,number,msg):
	texts = driver.find_elements_by_class_name("UIAStaticText")
	print len(texts)
	for i in range(1, number):
		for text in texts:
			if msg in text.get_attribute("name"):
				return True
		time.sleep(1)
	return False

def waitforstatusbarinapp(driver,number,msg,stime,textoffset):
	texts = driver.find_elements_by_class_name("UIAStaticText")
	for i in range(1, number):
		if len(texts) != textoffset+1:
			time.sleep(stime)
			continue
		if texts[textoffset]:
			if msg in texts[textoffset].get_attribute("name"):
				return True
			else:
				time.sleep(stime)
				continue
			# print texts[textoffset].get_attribute("name")
		else:
			time.sleep(stime)
			continue
	return False

def assertTrue(flag,msg):
	if flag:
		return True
	else:
		raise Exception(msg + " Check Failed!")

def rand_str(length):
    return ''.join(choice('abcdefghijklmnopqrstuvw01234567890') for i in xrange(length))
