# Automated Tests for Glow

## Initial setup
  
##### Install RVM
`$ \curl -sSL https://get.rvm.io | bash -s stable`

##### Install Ruby 2.2.1, and make it default your default Ruby
`$ rvm install 2.2.1`

`$ rvm use 2.2.1 --default`

##### Install required gems
`$ bundle install`

## Run WWW automated tests
open the www folder and run the www automated test, e.g.:

`m glow_ios_minitest.rb`

## Run Calabash UI automated tests

##### Configurate your test scripts
Open the features/suppport folder, create a copy of env.rb

`cp env.rb.example env.rb`

##### For iOS, e.g.:

`cucumber -t @regression`

##### For Android, e.g.:

`calabash-android run path_to_your_apk_file -t @regression`
