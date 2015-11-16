require 'calabash-android/abase'

class CommunityPage < Calabash::ABase
	def trait
    # "* id:'insight_indicator_title'"
    "*"
  end

 	def touch_topictype(arg1)
 		arg1=arg1.downcase
 		if arg1 == 'poll'
 			touch "* id:'create_poll_btn'"
 		elsif arg1 == "post"
 			touch "* id:'create_topic_btn'"
 		elsif arg1 == "photo"
 			touch "* id:'create_photo_btn'"
 		elsif arg1 == "link"
 			touch "* id:'create_url_btn'"
 		end
 	end
		
    
	def fill_in_poll
		touch "* id:'create_poll_btn'"
		enter_text "* id:'title_editor'","polltest"
		enter_text "* id:'text' index:0","Answer No1"
		enter_text "* id:'text' index:1","Answer No2"
		enter_text "* id:'text' index:2","Answer No3"
		touch "* id:'create_yes'"
	end
	
	def fill_in_post
		touch "* id:'create_topic_btn'"
		enter_text "* id:'title_editor'","posttest"
		enter_text "* id:'content_editor'","Answer No1"
		touch "* id:'insert_image_button'"
		#touch "* text:'Gallery'"
		perform_action('click_on_screen', 20, 8)
		#system("adb shell input keyevent KEYCODE_BACK")
		touch "* id:'create_yes'"
	end

	def fill_in_photo(flag=0)
		touch "* id:'create_photo_btn'"
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
		touch "* id:'create_url_btn'"
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

	def fill_in_title(arg1)
		if arg1 == 'short'
    	enter_text "* id:'title_editor'","abc"
  	elsif arg1 == 'long'
   		enter_text "* id:'title_editor'","abcdefg_auto"
  	else
   		clear_text_in "* id:'title_editor'"
   		enter_text "* id:'title_editor'",arg1
   	end
  end

  def fill_in_content(arg1)
  	if arg1 == 'short'
    	enter_text "* id:'title_editor'","abc"
  	elsif arg1 == 'long'
   	  enter_text "* id:'title_editor'","abcdefg_auto"
    else
      clear_text_in "* id:'title_editor'"
      enter_text "* id:'title_editor'",arg1
    end
  end

  def fill_in_pollanswer(arg1)
  	if arg1 == 'short'
      enter_text "* id:'text' index:0","Ans"
      enter_text "* id:'text' index:1","Ans"
    elsif arg1 == 'long'
      enter_text "* id:'text' index:0","answer 1"
      enter_text "* id:'text' index:1","answer 2"
    elsif 
      enter_text "* id:'text' index:0",arg1 
      enter_text "* id:'text' index:1",arg1 
    end
  end

  def touch_created_topic(arg1)
  	arg1.downcase
   	if arg1 == "post"
  	  touch "* text:'posttest' index:0"
    elsif arg1 == "poll"
      touch "* text:'polltest' index:0"
    elsif arg1 == "link"
      touch "* text:'linktest' index:0"
    elsif arg1 == "photo"
      touch "* text:'phototest' index:0"
    end
  end
end