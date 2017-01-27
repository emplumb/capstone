/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("portfoliosCtrl", function($scope, $http, $location) {

    $scope.setup = function() {
      var useLocalStorage = false;

      $scope.portfolioId = (/portfolios\/(\d+)/.exec($location.absUrl())[1]);

      $http.get("/api/v1/portfolios/" + $scope.portfolioId).then(function(response) {
        $scope.investmentPortfolios = response.data;

        $scope.getTotalCost = function() {
          var sum = 0;
          for (var i = 0; i < $scope.investmentPortfolios.length; i++) {
            sum += parseInt($scope.investmentPortfolios[i].cost_basis);
          }
          return sum;
        };

        var sumCurrentValue = 0;
        $scope.totalCurrentValue = 0;
        $scope.totalGainLoss = 0;
        var numberinvestmentPortfoliosLoaded = 0;
        $scope.totalWeighting = 0;
        $scope.totalPortfolioRisk = 0;
        $scope.totalPortfolioSharpe = 0;
        $scope.totalPortfolioCorrelation = 0;

        $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
          // retrieves current stock prices
          $http.get("/api/v1/stockprices/" + investmentPortfolio.investment_id).then(function(response) {

            var stockData = response;

            investmentPortfolio.logo = stockData.data.logo;
            investmentPortfolio.costBasis = parseFloat(investmentPortfolio.cost_basis);

            $scope.currentPrice = stockData.data.daily_prices.slice(-1)[0][1];

            investmentPortfolio.currentValue = parseFloat($scope.currentPrice * investmentPortfolio.shares);
            $scope.totalCurrentValue += investmentPortfolio.currentValue;

            investmentPortfolio.gainLoss = parseFloat(investmentPortfolio.currentValue) - parseFloat(investmentPortfolio.cost_basis);
            $scope.totalGainLoss += parseFloat(investmentPortfolio.gainLoss);

            // ensures totalCurrentValue isn't calculated until all currentValues are looped through
            numberinvestmentPortfoliosLoaded++;
            if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {

              $scope.investmentPortfolios.forEach(function(investmentPortfolio) {

                investmentPortfolio.weighting = parseFloat(investmentPortfolio.currentValue / $scope.totalCurrentValue);
                $scope.totalWeighting += investmentPortfolio.weighting;
                // console.log($scope.totalWeighting);

                $scope.totalPortfolioRisk += ($scope.totalWeighting * investmentPortfolio.standard_deviation);

                $scope.totalPortfolioSharpe += parseFloat($scope.totalWeighting * investmentPortfolio.sharpe);
                $scope.totalPortfolioCorrelation += parseFloat($scope.totalWeighting * investmentPortfolio.correlation);
              });
            }
          });
          // retrieves beginning of year stock prices and calculates return
          // $http.get("https://www.quandl.com/api/v3/datasets/YAHOO/" + investmentPortfolio.ticker + "/data.json?start_date=20170103&column_index=6&order=desc&api_key=bPnMRipgQCRwCypH1Sfa").then(function(stockData) {
          //   var prices = stockData.data.dataset_data.data;
          //   var beginningYearPrice = prices[prices.length - 1];
          //   var yesterdayPrice = prices[0];
          //   console.log('beginning', beginningYearPrice[1]);
          //   console.log('yesterday1', yesterdayPrice[1]);

          if (useLocalStorage) {
            console.log("whoa");
            response = JSON.parse(localStorage.getItem('beginningYearDataResponse'));
            var stockData = response.data.results;
            var beginningYearPrice = stockData[stockData.length - 1].open;
            var yesterdayPrice = stockData[0].close;
            investmentPortfolio.ytdReturn = parseFloat((yesterdayPrice - beginningYearPrice) / beginningYearPrice);
            if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
              $scope.weightedYtdReturn = 0;
              $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
                $scope.weightedYtdReturn += parseFloat(investmentPortfolio.weighting * investmentPortfolio.ytdReturn);
                console.log($scope.weightedYtdReturn);
              });
            }

            response = JSON.parse(localStorage.getItem('sixMonthDataResponse'));
            stockData = response.data.results;
            var sixMonthAgoPrice = stockData[stockData.length - 1].open;
            yesterdayPrice = stockData[0].close;
            investmentPortfolio.sixMonthReturn = parseFloat((yesterdayPrice - sixMonthAgoPrice) / sixMonthAgoPrice);
            if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
              $scope.weightedSixMonthReturn = 0;
              $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
                $scope.weightedSixMonthReturn += parseFloat(investmentPortfolio.weighting * investmentPortfolio.sixMonthReturn);
                console.log($scope.weightedSixMonthReturn);
              });
            }

            response = JSON.parse(localStorage.getItem('purchaseDataResponse'));
            stockData = response.data.results;
            var purchasePrice = stockData[stockData.length - 1].open;
            yesterdayPrice = stockData[0].close;
            investmentPortfolio.sinceInceptionReturn = parseFloat((yesterdayPrice - purchasePrice) / purchasePrice);
            if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
              $scope.weightedSinceInceptionReturn = 0;
              $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
                $scope.weightedSinceInceptionReturn += parseFloat(investmentPortfolio.weighting * investmentPortfolio.sinceInceptionReturn);
                console.log($scope.weightedSinceInceptionReturn);
              });
            }
          } else {
            $http.get("http://marketdata.websol.barchart.com/getHistory.json?&key=3fc25ea9bf9dda282aa4df91dbc82e1f&startDate=20170103&type=daily&order=desc&symbol=" + investmentPortfolio.ticker).then(function(response) {

              localStorage.setItem('beginningYearDataResponse', JSON.stringify(response));

              var stockData = response.data.results;

              var beginningYearPrice = stockData[stockData.length - 1].open;
              var yesterdayPrice = stockData[0].close;

              investmentPortfolio.ytdReturn = parseFloat((yesterdayPrice - beginningYearPrice) / beginningYearPrice);

              if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
                $scope.weightedYtdReturn = 0;
                $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
                  $scope.weightedYtdReturn += parseFloat(investmentPortfolio.weighting * investmentPortfolio.ytdReturn);
                  console.log($scope.weightedYtdReturn);

                });
              }
            });

            // // retrieves prices 6 months ago and calculates return
            // // $http.get("https://www.quandl.com/api/v3/datasets/YAHOO/" + investmentPortfolio.ticker + "/data.json?start_date=20170727&column_index=6&order=desc&api_key=bPnMRipgQCRwCypH1Sfa").then(function(stockData) {
            // //   var prices = stockData.data.dataset_data.data;
            // //   var sixMonthAgoPrice = prices[prices.length - 1];
            // //   var yesterdayPrice = prices[0];
            // //   console.log('6 months', sixMonthAgoPrice[1]);
            // //   console.log('yesterday2', yesterdayPrice[1]);

            $http.get("http://marketdata.websol.barchart.com/getHistory.json?&key=3fc25ea9bf9dda282aa4df91dbc82e1f&startDate=20160727&type=daily&order=desc&symbol=" + investmentPortfolio.ticker).then(function(response) {

              localStorage.setItem('sixMonthDataResponse', JSON.stringify(response));


              var stockData = response.data.results;

              var sixMonthAgoPrice = stockData[stockData.length - 1].open;
              var yesterdayPrice = stockData[0].close;

              investmentPortfolio.sixMonthReturn = parseFloat((yesterdayPrice - sixMonthAgoPrice) / sixMonthAgoPrice);

              if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
                $scope.weightedSixMonthReturn = 0;
                $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
                  $scope.weightedSixMonthReturn += parseFloat(investmentPortfolio.weighting * investmentPortfolio.sixMonthReturn);
                  console.log($scope.weightedSixMonthReturn);
                });
              }
            });

            // retrieves prices since inception and calculates return
            // $http.get("https://www.quandl.com/api/v3/datasets/YAHOO/" + investmentPortfolio.ticker + "/data.json?start_date=" + investmentPortfolio.purchase_date + "&column_index=6&order=desc&api_key=bPnMRipgQCRwCypH1Sfa").then(function(stockData) {
            //   var prices = stockData.data.dataset_data.data;
            //   var purchasePrice = prices[prices.length - 1];
            //   var yesterdayPrice = prices[0];
            //   console.log('purch price', purchasePrice[1]);
            //   console.log('yesterday3', yesterdayPrice[1]);

            $http.get("http://marketdata.websol.barchart.com/getHistory.json?&key=3fc25ea9bf9dda282aa4df91dbc82e1f&startDate=" + investmentPortfolio.purchase_date + "&type=daily&order=desc&symbol=" + investmentPortfolio.ticker).then(function(response) {

              localStorage.setItem('purchaseDataResponse', JSON.stringify(response));

              var stockData = response.data.results;
              var purchasePrice = stockData[stockData.length - 1].open;
              var yesterdayPrice = stockData[0].close;

              investmentPortfolio.sinceInceptionReturn = parseFloat((yesterdayPrice - purchasePrice) / purchasePrice);

              if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
                $scope.weightedSinceInceptionReturn = 0;
                $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
                  $scope.weightedSinceInceptionReturn += parseFloat(investmentPortfolio.weighting * investmentPortfolio.sinceInceptionReturn);
                  console.log($scope.weightedSinceInceptionReturn);

                });
              }
            });
          }


        });
      });
    };
    $scope.orderAttribute = 'ticker';
    $scope.isOrderDescending = false;

    $scope.changeOrderAttribute = function(inputAttribute) {
      if (inputAttribute === $scope.orderAttribute) {
        $scope.isOrderDescending = !$scope.isOrderDescending;
      } else {
        $scope.isOrderDescending = false;
      }
      $scope.orderAttribute = inputAttribute;
    };

    $scope.searchTicker = function(inputTicker) {
      $http.get("https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.quotes+where+symbol+in+('" + inputTicker + "')&format=json&env=store://datatables.org/alltableswithkeys&callback=").then(function(response) {
        var stockInfo = response.data.query.results.quote;
        $scope.name = stockInfo.Name;
        $scope.symbol = stockInfo.Symbol;
        $scope.price = stockInfo.LastTradePriceOnly;
        $scope.openPrice = stockInfo.Open;
        $scope.percentChange = parseFloat(stockInfo.ChangeinPercent);
      });
    };

    $scope.addInvestment = function(inputDollarAmount) {

      var params = {
        portfolioId: $scope.portfolioId,
        costBasis: inputDollarAmount,
        ticker: $scope.symbol,
        purchasePrice: $scope.price,
        purchaseDate: "2017-01-26",
        shares: parseInt(inputDollarAmount / $scope.price),
        standardDeviation: 0.0836,
        sharpe: 0.67,
        correlation: 0.61
      };
      $http.post('/api/v1/investment_portfolios', params).then(function(response) {
        $scope.investmentPortfolios.push(response.data);
      });
      $scope.inputTicker = "";
      $scope.inputDollarAmount = "";
    };
  });
})();
