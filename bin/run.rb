require_relative '../config/environment'



welcome
username = user_imput
user = Investor.find_by(name: username)
login(username)


# binding.pry
