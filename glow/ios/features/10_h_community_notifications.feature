
Feature: Test all community notifications
''' TYPE_FORUM_REPLY_CREATOR = 1050
    TYPE_FORUM_REPLY_CREATOR_2 = 1085  # 6 comments
    TYPE_FORUM_REPLY_CREATOR_3 = 1086  # 16 comments
    TYPE_FORUM_REPLY_CREATOR_4 = 1087  # 50 comments

    TYPE_FORUM_REPLY_PARTICIPANT = 1051
    TYPE_FORUM_SUBREPLY = 1053
    TYPE_FORUM_TOPIC_LIKED_DAILY = 1055  # only in app notification
    TYPE_FORUM_REPLY_LIKED = 1059
    TYPE_FORUM_POLL_VOTED = 1060

    TYPE_FORUM_INVITE_TO_GROUP = 1068
    TYPE_FORUM_REPLY_PHOTO_CREATOR = 1088
    TYPE_FORUM_REPLY_PHOTO_CREATOR_2 = 1089

    TYPE_FORUM_NEW_FOLLOWER = 1091
    TYPE_FORUM_FOLLOWERS_SUMMARY = 1092'''
  @wip
  Scenario Outline: Test different notification types
    Given I create a new forum user with name "Miles"
    Given the notification test data for type <ntf_type> has been prepared through www 
    And I login as the new user "Miles" created through www
    And I open "alert" page
    Then I check the text and click the buttons for this type of notification
    And I should see the page is navigating to the right page
    And I go back to community page
    And I logout
    
    Examples: 
        | ntf_type |  
        | 1050     |  
        | 1085     |  
        | 1086     |  
        | 1087     |  
        | 1051     |  
        | 1053     |  
        | 1055     |  
        | 1059     |  
        | 1060     |  
        | 1088     |  
        | 1089     |  
        | 1091     |  
