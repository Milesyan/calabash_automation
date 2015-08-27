import unittest
import os
import time
import json
from random import randint,choice

from BaseUtils import swipe_left,swipe_right,passAlert
from selenium import webdriver
import selenium.webdriver.support.ui as ui
from selenium.webdriver.support.ui import WebDriverWait


def finish_community_tutorils(driver):
	driver.find_element_by_name("Community").click()
	waittime(2)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIANavigationBar[1]").click()
	waittime(2)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[2]/UIATableCell[2]/UIAStaticText[1]").click()
	waittime(2)
	swipe_right(driver,2)
	waittime(3)

def search_topic(driver,text):
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIANavigationBar[1]/UIAButton[1]").click()
	waittime(2)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIASearchBar[1]").send_keys(text)
	waittime()
	driver.hide_keyboard('Search')
	waittime(5)

def search_comment(driver,text):
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIANavigationBar[1]/UIAButton[1]").click()
	waittime(2)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIASegmentedControl[1]/UIAButton[2]").click()
	waittime(2)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIASearchBar[1]").send_keys(text)
	waittime()
	driver.hide_keyboard('Search')
	waittime(5)

def add_topic(driver,text,description,anonymously=False):
	driver.find_element_by_name("Add topic").click()
	waittime(2)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATextField[1]").send_keys(text)
	waittime(2)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys(description)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys(description)
	if anonymously:
		driver.find_element_by_name("Add Anonymously").click()
	driver.find_element_by_name("Post").click()
	waittime(5)
	try:
		passAlert(driver)
		driver.find_element_by_name("Skip").click()
	except:
		pass
	

def add_poll(driver,text,options,anonymously=False):
	driver.find_element_by_name("Create poll").click()
	waittime(2)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[1]/UIATextField[1]").send_keys(text)
	waittime()
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[2]/UIATextField[1]").send_keys("A")
	waittime()
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATableView[1]/UIATableCell[4]/UIATextField[1]").send_keys("B")
	waittime()
	if anonymously:
		driver.find_element_by_name("Add Anonymously").click()
	driver.find_element_by_name("Post").click()
	waittime(5)
	try:
		passAlert(driver)
		driver.find_element_by_name("Skip").click()
	except:
		pass

def vote_poll(driver,index):
	buttons = driver.find_elements_by_class_name('UIAButton')
	before = len(buttons)
	buttons[5+index].click()
	waittime(3)
	buttons = Utils.BaseUtils.find_all_buttons(self.driver)
	after = len(buttons)
	self.assertTrue(after < before)

def discard_add_normal_topic(driver,text,description):
	driver.find_element_by_name("Add topic").click()
	waittime(2)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIATextField[1]").send_keys(text)
	waittime(2)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys(description)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys(description)
	driver.find_element_by_name("Close").click()
	waittime(2)
	driver.find_element_by_name("Discard").click()
	waittime(2)

def add_comment(driver,text):
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIATableView[2]/UIATableCell[2]").click()
	waittime(8)
	driver.find_element_by_name("Add a comment").click()
	waittime(3)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys(text)
	driver.find_element_by_name("Post").click()

def waittime(num=None):
	if num:
		time.sleep(num)
	else:
		time.sleep(1)