# User.destroy_all
# Portfolio.destroy_all
# Investment.destroy_all
# InvestmentPortfolio.destroy_all

investment = Investment.create([
#     {ticker: "ko", name: "Coca Cola"},
#     {ticker: "xom", name: "Exxon Mobil"},
#     {ticker: "hd", name: "Home Depot"},
#     {ticker: "amzn", name: "Amazon"},
#     {ticker: "sbux", name: "Starbucks"},
#     {ticker: "ntrs", name: "Northern Trust"},
#     {ticker: "pfe", name: "Pfizer"},

#   {ticker: "TSLA", name: "Tesla"},
#   {ticker: "AAPL", name: "Apple"},
#   {ticker: "F", name: "Ford"},
#   {ticker: "GE", name: "General Electric"},
#   {ticker: "CMG", name: "Chipotle",
#   {ticker: "BABA", name: "Alibaba"},
#   {ticker: "JPM", name: "JP Morgan"},
#   {ticker: "NFLX", name: "Netflix"},
#   {ticker: "^GSPC", name: "S&P 500"}
])

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

  # InvestmentPortfolio.create([
  #   # {investment_id: investment.first.id, portfolio_id: portfolio.id},
  #   # {investment_id: investment.first.id + 2, portfolio_id: portfolio.id},
  #   # {investment_id: investment.first.id + 4, portfolio_id: portfolio.id},
  #   {investment_id: 81, portfolio_id: 42, ticker: "tsla"},
  #   {investment_id: 84, portfolio_id: 42, ticker: "ge"},
  #   {investment_id: 85, portfolio_id: 42, ticker: "cmg"},
  #   {investment_id: 87, portfolio_id: 42, ticker: "jpm"},
  #   {investment_id: 88, portfolio_id: 42, ticker: "nflx"}
  # ])
# end



