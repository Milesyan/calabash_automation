for APP in 'eve' 'glow' 'baby' 'nurture'
do
  rm -r ${APP}/ios/features/1*
  rm -r ${APP}/ios/features/pages/forum_page.rb
  rm -r ${APP}/ios/features/pages/premium_page.rb
  rm -r ${APP}/ios/features/step_definitions/forum_steps.rb
  rm -r ${APP}/ios/features/step_definitions/premium_steps.rb
  rm -r ${APP}/android/features/1*
  rm -r ${APP}/android/features/pages/forum_page.rb
  rm -r ${APP}/android/features/pages/premium_page.rb
  rm -r ${APP}/android/features/step_definitions/forum_steps.rb
  rm -r ${APP}/android/features/step_definitions/premium_steps.rb
  rm -r ${APP}/www/public/ForumApi.rb
  rm -r ${APP}/www/public/ForumApiAndroid.rb
  rm -r ${APP}/www/public/test_helper.rb
  rm -r ${APP}/www/public/ios_minitest.rb
  rm -r ${APP}/www/public/android_minitest.rb
  rm -r ${APP}/ios/.config/*
  rm -r ${APP}/android/.config/*


  ln common/android/features/1* ${APP}/android/features/
  ln common/android/pages/* ${APP}/android/features/pages
  ln common/android/steps/* ${APP}/android/features/step_definitions
  ln common/ios/features/1* ${APP}/ios/features/
  ln common/ios/pages/* ${APP}/ios/features/pages
  ln common/ios/steps/* ${APP}/ios/features/step_definitions
  ln common/www/ForumApi.rb ${APP}/www/public
  ln common/www/ForumApiAndroid.rb ${APP}/www/public
  ln common/www/test_helper.rb ${APP}/www/public
  ln common/www/ios_minitest.rb ${APP}/www/public
  ln common/www/android_minitest.rb ${APP}/www/public
  ln common/.config/* ${APP}/ios/.config/
  ln common/.config/* ${APP}/android/.config/
done