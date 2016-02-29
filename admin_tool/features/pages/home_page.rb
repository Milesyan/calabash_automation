class HomePage
  def search(email)
    sleep 1
    first('input').set email
    click_on "Search"
    sleep 1
    puts current_url
    m = %r(http://admindash.glowing.com\/user\/(\d+)).match current_url
    $user.id = m[1]
    puts $user.id
  end
end