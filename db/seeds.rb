require_relative '../config/environment'
require 'faker'

stock_array = ['AAPL', 'AMZN', 'GOOGL', 'FB', 'CRM', 'CMCSA', 'DIS', 'NFLX',
  'SPOT', 'DAL', 'UAL', 'AAL', 'NKE', 'IBM', 'JPM', 'VZ', 'T', 'K']

# i = 0
# 19.times do
#
#
#   new_quote = IEX::Resources::Quote.get(stock_array[i])
#   new_chart = IEX::Resources::Chart.get(stock_array[i])
#
#   new_chart.each { |stock_date|
#     Stock.create(company: new_quote.company_name, symbol: new_quote.symbol, shares_available: rand(1500),
#     sector: new_quote.sector, date: stock_date.date.to_s,open_price: stock_date.open,
#     close_price: stock_date.close)
#   }
#   i += 1
#
# end

#
# 20.times do
#   Investor.create(name: Faker::Name.name, age: Faker::Number.between(15, 78), account_id: Faker::Number.between(0, 21),
#   city: Faker::Address.city, state: Faker::Address.state_abbr,
#   email: Faker::Internet.email, address: Faker::Address.street_address, phone_num: Faker::PhoneNumber.cell_phone)
# end

# 20.times do
#   Account.create(balance: Faker::Number.between(500, 20000), investor_id: Faker::Number.between(40, 60),
#   bank_id: Faker::Number.between(1, 6))
# end
