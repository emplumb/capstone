json.array! @portfolios.each do |portfolio|
  json.id portfolio.id
  json.name portfolio.name
  json.user_id portfolio.user_id
  json.month_return portfolio.month_return
  json.ytd_return portfolio.ytd_return
  json.inception_return portfolio.inception_return
  json.alpha portfolio.alpha
  json.standard_deviation portfolio.standard_deviation
  json.sharpe portfolio.sharpe
  json.correlation portfolio.correlation
end
