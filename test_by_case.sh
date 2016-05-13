if [ $1 != 0 ]
then
for APP in 'eve' 'glow' 'baby' 'nurture'
do
  m ${APP}/www/${APP}_android_forum_minitest.rb:$1
done
else 
  m eve/www/eve_android_forum_minitest.rb:-1
fi


if [ $2 != 0 ]
then
for APP in 'eve' 'glow' 'baby' 'nurture'
do
  m ${APP}/www/${APP}_ios_forum_minitest.rb:$2
done
else
  m eve/www/eve_android_forum_minitest.rb:-1
fi
