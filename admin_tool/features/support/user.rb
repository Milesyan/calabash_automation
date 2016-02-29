class User
  attr_accessor :email, :password, :id

  def initialize(args)
    @email = args[:email]
    @password = args[:password]
  end
end