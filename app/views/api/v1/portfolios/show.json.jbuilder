json.array! @portfolio.investment_portfolios.each do |investment_portfolio|
  json.id investment_portfolio.id
  json.ticker investment_portfolio.ticker.upcase
  json.portfolio_id investment_portfolio.portfolio_id
  json.investment_id investment_portfolio.investment_id
  json.purchase_price investment_portfolio.purchase_price
  json.purchase_date investment_portfolio.purchase_date
  json.shares investment_portfolio.shares
  json.cost_basis investment_portfolio.cost_basis
  json.alpha investment_portfolio.alpha
  json.standard_deviation investment_portfolio.standard_deviation
  json.sharpe investment_portfolio.sharpe
  json.correlation investment_portfolio.correlation
end


