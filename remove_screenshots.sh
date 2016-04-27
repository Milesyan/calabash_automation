for APP in 'eve' 'glow' 'baby' 'nurture'
do
  rm ./${APP}/android/features/screenshots/*
  rm ./${APP}/ios/features/screenshots/*

  rm ./${APP}/android/test_servers/*
  rm ./${APP}/android/*.html

  # rm ./${APP}/ios/*.html
  # rm ./${APP}/android/*.html
  rm ./${APP}/android/.irb-history
  rm ./${APP}/ios/.irb-history


  rm ./${APP}/android/*.png
  rm ./${APP}/ios/*.png
  
  rm ./${APP}/android/reports/*
  rm ./${APP}/ios/reports/*
done

# rm **/*.png
# rm **/*.html
# rm **/.irb-history