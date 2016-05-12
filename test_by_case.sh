for APP in 'eve' 'glow' 'baby' 'nurture'
do
  m ${APP}/www/${APP}_android_forum_minitest.rb:445
  m ${APP}/www/${APP}_ios_forum_minitest.rb:483
done