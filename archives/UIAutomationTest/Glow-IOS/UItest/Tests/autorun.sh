#!/bin/bash
cd '../UiautomationTest'
nosetests --with-xunit \
	GlowFirstTest.py \
	GlossaryTest.py \
	CommunityTest.py \
	DailylogTest.py \
	GGTest.py \
	HomeTest.py \
	SigninTest.py \
	SignupTest.py \
	PeriodlogTest.py \
	MeTest.py