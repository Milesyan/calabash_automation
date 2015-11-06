require 'calabash-android/abase'

class CommunityPage < Calabash::ABase
	def trait
    # "* id:'insight_indicator_title'"
    "*"
  end

  def fill_in_topic(arg1='')
  	if arg1 == 'Poll'
  		community_page.fill_in_poll
 		elsif arg1 == 'Post'
  		community_page.fill_in_post
  	elsif arg1 == 'Photo'
  		community_page.fill_in_photo
  	elsif arg1 == 'Link'
  		community_page.fill_in_link
  	end
  end

	def fill_in_poll
		enter_text "* id:'title_editor'","polltest"
		enter_text "* id:'text' index:0","Answer No1"
		enter_text "* id:'text' index:1","Answer No2"
		enter_text "* id:'text' index:2","Answer No3"
		touch "* id:'create_yes'"
	end
	
	def fill_in_post
		enter_text "* id:'title_editor'","posttest"
		enter_text "* id:'content_editor'","Answer No1"
		touch "* id:'insert_image_button'"
		#touch "* text:'Gallery'"
		perform_action('click_on_screen', 20, 8)
		#system("adb shell input keyevent KEYCODE_BACK")
		touch "* id:'create_yes'"
	end

	def fill_in_photo(flag=0)
		touch "* text:'Select from Gallery'"
		touch "* text:'Gallery'"
		#perform_action('click_on_screen', 20, 8)
		#system("adb shell input keyevent KEYCODE_BACK")
		sleep 2
		touch "* id:'create_yes'"
		enter_text "* id:'title_editor'","Testing Photo"
		if flag == 1
			touch "* id:'photo_topic_tmi_check'"
		end
		tap_when_element_exists "* id:'create_yes'"
	end

	def fill_in_link
		enter_text "* id:'title_editor'","linktest"
		enter_text "* id:'content_editor'","www.google.com"
		sleep 3
		touch "* id:'create_yes'"	
	end

	def touch_done
		tap_when_element_exists "* id:'create_yes'"
	end
	


	def choose_group
			touch "* id:'text1' * index:1"
	end

end