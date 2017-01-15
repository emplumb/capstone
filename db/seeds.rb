# User.destroy_all
# Portfolio.destroy_all
# Investment.destroy_all
# InvestmentPortfolio.destroy_all

# investment = Investment.create([
#   {ticker: "TSLA", name: "Tesla", price: 198.69},
#   {ticker: "AAPL", name: "Apple", price: 115},
#   {ticker: "F", name: "Ford", price: 185},
#   {ticker: "GE", name: "General Electric", price: 31.50},
#   {ticker: "CMG", name: "Chipotle", price: 375.70},
#   {ticker: "BABA", name: "Alibaba", price: 91.2},
#   {ticker: "JPM", name: "JP Morgan", price: 84.73},
#   {ticker: "NFLX", name: "Netflix", price: 123.44},
#   {ticker: "^GSPC", name: "S&P 500"}
# ])

# 3.times do
#   first_name = Faker::Name.first_name
#   last_name = Faker::Name.last_name

#   user = User.new(
#     name: "#{first_name} #{last_name}",
#     email: "#{first_name.downcase}.#{last_name.downcase}@gmail.com",
#     username: "#{first_name}" + rand(1..99).to_s,
#     password: "password"
#     )
#   user.save

#   portfolio = Portfolio.create(user_id: user.id, name: user.username + " " + "Portfolio")

  InvestmentPortfolio.create([
    # {investment_id: investment.first.id, portfolio_id: portfolio.id},
    # {investment_id: investment.first.id + 2, portfolio_id: portfolio.id},
    # {investment_id: investment.first.id + 4, portfolio_id: portfolio.id},
    {investment_id: 89, portfolio_id: 47, ticker: "^GSPC"}
  ])
# end



