rm -r eve/ios/features/1*
rm -r eve/ios/features/pages/forum_page.rb
rm -r eve/ios/features/pages/premium_page.rb
rm -r eve/ios/features/step_definitions/forum_steps.rb
rm -r eve/ios/features/step_definitions/premium_steps.rb

rm -r nurture/ios/features/1*
rm -r nurture/ios/features/pages/forum_page.rb
rm -r nurture/ios/features/pages/premium_page.rb
rm -r nurture/ios/features/step_definitions/forum_steps.rb
rm -r nurture/ios/features/step_definitions/premium_steps.rb

rm -r glow/ios/features/1*
rm -r glow/ios/features/pages/forum_page.rb
rm -r glow/ios/features/pages/premium_page.rb
rm -r glow/ios/features/step_definitions/forum_steps.rb
rm -r glow/ios/features/step_definitions/premium_steps.rb

rm -r baby/ios/features/1*
rm -r baby/ios/features/pages/forum_page.rb
rm -r baby/ios/features/pages/premium_page.rb
rm -r baby/ios/features/step_definitions/forum_steps.rb
rm -r baby/ios/features/step_definitions/premium_steps.rb

rm -r eve/android/features/1*
rm -r eve/android/features/pages/forum_page.rb
rm -r eve/android/features/pages/premium_page.rb
rm -r eve/android/features/step_definitions/forum_steps.rb
rm -r eve/android/features/step_definitions/premium_steps.rb

rm -r nurture/android/features/1*
rm -r nurture/android/features/pages/forum_page.rb
rm -r nurture/android/features/pages/premium_page.rb
rm -r nurture/android/features/step_definitions/forum_steps.rb
rm -r nurture/android/features/step_definitions/premium_steps.rb

rm -r glow/android/features/1*
rm -r glow/android/features/pages/forum_page.rb
rm -r glow/android/features/pages/premium_page.rb
rm -r glow/android/features/step_definitions/forum_steps.rb
rm -r glow/android/features/step_definitions/premium_steps.rb

rm -r baby/android/features/1*
rm -r baby/android/features/pages/forum_page.rb
rm -r baby/android/features/pages/premium_page.rb
rm -r baby/android/features/step_definitions/forum_steps.rb
rm -r baby/android/features/step_definitions/premium_steps.rb

ln common/android/features/1* eve/android/features/
ln common/android/features/1* nurture/android/features/
ln common/android/features/1* glow/android/features/
ln common/android/features/1* baby/android/features/
ln common/android/pages/* nurture/android/features/pages


ln common/android/pages/* glow/android/features/pages
ln common/android/pages/* baby/android/features/pages
ln common/android/pages/* eve/android/features/pages
ln common/android/steps/* nurture/android/features/step_definitions
ln common/android/steps/* eve/android/features/step_definitions
ln common/android/steps/* glow/android/features/step_definitions
ln common/android/steps/* baby/android/features/step_definitions
ln common/ios/features/1* glow/ios/features/
ln common/ios/features/1* nurture/ios/features/
ln common/ios/features/1* eve/ios/features/
ln common/ios/features/1* baby/ios/features/
ln common/ios/pages/* glow/ios/features/pages
ln common/ios/pages/* nurture/ios/features/pages
ln common/ios/pages/* eve/ios/features/pages
ln common/ios/pages/* baby/ios/features/pages
ln common/ios/steps/* glow/ios/features/step_definitions
ln common/ios/steps/* nurture/ios/features/step_definitions
ln common/ios/steps/* eve/ios/features/step_definitions
ln common/ios/steps/* baby/ios/features/step_definitions