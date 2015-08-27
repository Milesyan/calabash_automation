import json
import unittest
from random import randint
# from selenium import webdriver
from appium import webdriver

from Utils import BaseUtils,SignupUtils,OnboardingUtils

class kaylee_signupTest(unittest.TestCase):

	def setUp(self):
        # set up appium
		self.driver = webdriver.Remote(
            command_executor = BaseUtils.CONTENT_URL,
            desired_capabilities= BaseUtils.CAPABILITIES)
		self._values = []

	# def test_signup_with_email(self):
	# 	OnboardingUtils.onboading_signup(self.driver,["jason","jason+" + BaseUtils.rand_str(15) + "@upwlabs.com", "123456"])
	# 	BaseUtils.waittime(10)
	# 	try:
	# 		OnboardingUtils.finfish_tutorials(self.driver)
	# 	except:
	# 		print "finfish_tutorials error!"
	# 	#need to add check
	# 	# self.assertTrue(self.driver.find_element_by_name("Community").is_displayed())

	# def test_signin_with_email(self):
	# 	OnboardingUtils.onboading_signin(self.driver,[BaseUtils.MOM[0],BaseUtils.MOM[1]])
	# 	BaseUtils.waittime(10)
	# 	try:
	# 		OnboardingUtils.finfish_tutorials(self.driver)
	# 	except:
	# 		print "finfish_tutorials error!"
	# 	#need to add check
	# 	# self.assertTrue(self.driver.find_element_by_name("Community").is_displayed())
	
	# def test_signin_with_unregister_email(self):
	# 	OnboardingUtils.onboading_signin(self.driver,["jason+e1111@upwlabs.com","123456"])
	# 	self.assertTrue(BaseUtils.waitforstatusbar(self.driver,5,"Wrong email and password combination."))

	# #when mom has no signup , dad need to wait
	# def test_signin_with_glowdad_email(self):
	# 	OnboardingUtils.onboading_signin(self.driver,BaseUtils.UN_DAD)
	# 	self.assertTrue(BaseUtils.waitforstatusbar(self.driver,5,"Need mom to use Nurture first"))

	# #when mom is glow user, and go to sign up flow
	# def test_signup_with_emmamom_email(self):
	# 	OnboardingUtils.onboading_signup(self.driver,["jason",BaseUtils.UN_MOM[0], BaseUtils.UN_MOM[1]])
	# 	self.assertTrue(BaseUtils.waitforstatusbar(self.driver,5,"This email is already registered by another user."))

	# #test signup register email
	# def test_signup_with_kayleemom_email(self):
	# 	OnboardingUtils.onboading_signup(self.driver,["jason",BaseUtils.MOM[0], BaseUtils.MOM[1]])
	# 	self.assertTrue(BaseUtils.waitforstatusbar(self.driver,5,"This email is already registered by another user."))

	# #test forget password
	# def test_forget_password(self):
	# 	OnboardingUtils.onboading_goto_signinpage(self.driver)
	# 	BaseUtils.forgetPassword(self.driver, BaseUtils.MOM[0])
	# 	BaseUtils.waittime(5)
	# 	self.assertTrue(BaseUtils.waitforstatusbar(self.driver,5,"Email sent, please check your mail box."))

	# def test_partner_signup_notexist(self):
	# 	OnboardingUtils.onboading_partner_signup(self.driver,["jason","jason+" + BaseUtils.rand_str(15) + "@upwlabs.com", "123456"])
	# 	self.assertTrue(BaseUtils.waitforstatusbar(self.driver,5,"This email is not invited as partner"))

	# def test_signup_with_emma_partneremail(self):
	# 	OnboardingUtils.onboading_signup(self.driver,["jason",BaseUtils.UN_DAD[0], BaseUtils.UN_DAD[1]])
	# 	self.assertTrue(BaseUtils.waitforstatusbar(self.driver,5,"This email is already registered by another user."))

	# def test_signup_with_kaylee_partneremail(self):
	# 	OnboardingUtils.onboading_signup(self.driver,["jason",BaseUtils.IV_DAD[0], BaseUtils.IV_DAD[1]])
	# 	self.assertTrue(BaseUtils.waitforstatusbar(self.driver,5,"This email is invited as partner, please go partner flow"))

	# def test_signuppartner_with_emma_momnotregister(self):
	# 	OnboardingUtils.onboading_partner_signup(self.driver,["jason",BaseUtils.UN_DAD[0], BaseUtils.UN_DAD[1]])
	# 	self.assertTrue(BaseUtils.waitforstatusbar(self.driver,5,"This email is not invited as partner"))

   	def tearDown(self):
		self.driver.quit()


if __name__ == '__main__':
    unittest.main()