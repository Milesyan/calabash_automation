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

10046  ln -s common/android/features/1* eve/android/features/
10047  ln -s common/android/features/1* nurture/android/features/
10048  ln -s common/android/features/1* glow/android/features/
10049  ln -s common/android/features/1* baby/android/features/
10050  ln -s common/android/pages/* nurture/android/features/pages


10058  ln -s common/android/pages/* glow/android/features/pages
10059  ln -s common/android/pages/* baby/android/features/pages
10060  ln -s common/android/pages/* eve/android/features/pages
10061  ln -s common/android/steps/* nurture/android/features/step_definitions
10062  ln -s common/android/steps/* eve/android/features/step_definitions
10063  ln -s common/android/steps/* glow/android/features/step_definitions
10064  ln -s common/android/steps/* baby/android/features/step_definitions
10065  ln -s common/ios/features/1* glow/ios/features/
10066  ln -s common/ios/features/1* nurture/ios/features/
10067  ln -s common/ios/features/1* eve/ios/features/
10068  ln -s common/ios/features/1* baby/ios/features/
10069  ln -s common/ios/pages/* glow/ios/features/pages
10070  ln -s common/ios/pages/* nurture/ios/features/pages
10071  ln -s common/ios/pages/* eve/ios/features/pages
10072  ln -s common/ios/pages/* baby/ios/features/pages
10073  ln -s common/ios/steps/* glow/ios/features/step_definitions
10074  ln -s common/ios/steps/* nurture/ios/features/step_definitions
10075  ln -s common/ios/steps/* eve/ios/features/step_definitions
10076  ln -s common/ios/steps/* baby/ios/features/step_definitions