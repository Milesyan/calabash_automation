from appium import webdriver
import selenium.webdriver.support.ui as ui
from selenium.webdriver.support.ui import WebDriverWait
from BaseUtils import waittime,assertTrue,swipe_up

def purge_signin(driver,userinfo):
	onboading_signin(driver,userinfo)
	waittime(10)
	try:
		finfish_tutorials(driver)
	except:
		print "finfish_tutorials error!"

def onboading_signup(driver,userinfo):
	driver.find_element_by_name("Start your journey now").click()
	waittime(3)
	assertTrue(driver.find_element_by_name("Tell us a little bit about your baby!").is_displayed(),"check go to onboarding step1 page!")
	#step1
	driver.find_element_by_name("Choose").click()
	waittime()
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"280", "y":"380"})
	waittime()
	driver.find_elements_by_class_name('UIAButton')[-2].click()
	waittime()
	driver.find_element_by_name("M/D/Y").click()
	waittime()
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"280", "y":"380"})
	waittime()
	driver.find_element_by_name("Next").click()
	waittime()
	assertTrue(driver.find_element_by_name("How did you get pregnant?").is_displayed(),"check go to onboarding step2 page!")
	#step2
	driver.find_element_by_name("Choose").click()
	waittime()
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"280", "y":"380"})
	waittime()
	driver.find_element_by_name("Weight").click()
	waittime()
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"280", "y":"380"})
	waittime()
	driver.find_element_by_name("Height").click()
	waittime()
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"280", "y":"380"})
	waittime()
	driver.find_elements_by_class_name('UIAButton')[-1].click()
	waittime()
	driver.find_element_by_name("Next").click()
	waittime()
	assertTrue(driver.find_element_by_name("Full name").is_displayed(),"check go to onboarding step3 page!")
	#step3
	textfields = driver.find_elements_by_class_name("UIATextField")
	textfields[0].send_keys(userinfo[0])
	textfields[1].send_keys(userinfo[1])
	secure = driver.find_elements_by_class_name("UIASecureTextField")
	secure[0].send_keys(userinfo[2])
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"180", "y":"300"})
	waittime()
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"280", "y":"380"})
	waittime()
	driver.find_element_by_name("Next").click()
	
def dismiss_partner_invited(driver):
	try:
		driver.find_element_by_name("popup close").click()
	except:
		print "no invited partern page"
	finally:
		waittime(3)
# 		

def finfish_tutorials(driver):
	#step 1
	driver.swipe(start_x=15.00, start_y=88.50, end_x=265.00, end_y=88.50, duration=800)
	waittime(3)

	#step 2
	driver.swipe(start_x=165.00, start_y=88.50, end_x=165.00, end_y=418.50, duration=800)
	waittime(3)

	#step 3
	image = driver.find_elements_by_class_name("UIAImage")[5]
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":image.location['x']+20, "y":image.location['y']+20})
	waittime(3)
	
	#step4
	driver.find_element_by_name("Later").click()
	waittime(3)

	#step5
	dismiss_partner_invited(driver)
	waittime(3)
	assertTrue(driver.find_element_by_name("Community").is_displayed(),"check go to home page!")

def onboading_signin(driver,userinfo):
	driver.find_element_by_name("Log in").click()
	waittime(3)
	assertTrue(driver.find_element_by_name("Forgot password").is_displayed(),"check in signin page!")
	textfields = driver.find_elements_by_class_name("UIATextField")
	textfields[0].send_keys(userinfo[0])
	secure = driver.find_elements_by_class_name("UIASecureTextField")
	secure[0].send_keys(userinfo[1])
	waittime()
	driver.find_element_by_name("Next").click()

def onboading_goto_signinpage(driver):
	driver.find_element_by_name("Log in").click()
	waittime(3)
	assertTrue(driver.find_element_by_name("Forgot password").is_displayed(),"check in signin page!")

def onboading_partner_signup(driver,userinfo):
	driver.find_element_by_name("Sign up").click()
	waittime(3)
	textfields = driver.find_elements_by_class_name("UIATextField")
	textfields[0].send_keys(userinfo[0])
	textfields[1].send_keys(userinfo[1])
	secure = driver.find_elements_by_class_name("UIASecureTextField")
	secure[0].send_keys(userinfo[2])
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"180", "y":"300"})
	waittime()
	driver.execute_script("mobile: tap", {"touchCount":"1", "x":"280", "y":"380"})
	waittime()
	driver.find_element_by_name("Next").click()	

def gotoarticle(driver,index):
	swipe_up(driver,2)
	table = driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[2]/UIATableView[2]")
	rows = table.find_elements_by_class_name("UIATableCell")
	tmp_index = 0;
	for i in range(1, len(rows)-1):
		if rows[i].get_attribute("name") == "DAILY PREGNANCY SCOOP":
			tmp_index = i
	rows[tmp_index+index+1].click()
	waittime(5)

def add_comment(driver,text):
	driver.find_element_by_name("Add a comment").click()
	waittime(3)
	driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]").send_keys(text)
	driver.find_element_by_name("Post").click()

def add_photo(driver):
	driver.find_element_by_name("Add photo").click()

def click_home_button_by_name(driver,name):
	table = driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[2]/UIATableView[2]")
	buttons = table.find_elements_by_class_name('UIAButton')
	for button in buttons:
		if button.get_attribute("name") == name:
			button.click()

def click_home_button_by_name_index(driver,name,index):
	table = driver.find_element_by_xpath("//UIAApplication[1]/UIAWindow[1]/UIAScrollView[2]/UIATableView[2]")
	buttons = table.find_elements_by_class_name('UIAButton')
	tmp_index = 0;
	for button in buttons:
		if button.get_attribute("name") == name:
			break
		tmp_index = tmp_index + 1
	buttons[tmp_index+index].click()
