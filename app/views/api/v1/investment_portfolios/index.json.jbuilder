json.array! @investment_portfolios.each do |investment_portfolio|
  json.id investment_portfolio.id
  json.portfolio_id investment_portfolio.portfolio_id
  json.investment_id investment_portfolio.investment_id
  json.investment_logo investment_portfolio.investment.logo
  json.ticker investment_portfolio.ticker
  json.purchase_date investment_portfolio.purchase_date
  json.purchase_price investment_portfolio.purchase_price
  json.shares investment_portfolio.cost_basis
  json.shares investment_portfolio.shares
  json.standard_deviation investment_portfolio.standard_deviation
  json.sharpe investment_portfolio.sharpe
  json.correlation investment_portfolio.correlation
end
