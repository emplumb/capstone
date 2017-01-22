/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("portfoliosCtrl", function($scope, $http, $location) {

    $scope.setup = function() {
      $scope.orderAttribute = 'ticker';
      $scope.isOrderDescending = false;
      $scope.id = (/portfolios\/(\d+)/.exec($location.absUrl())[1]);

      $http.get("/api/v1/portfolios/" + $scope.id).then(function(response) {
        $scope.investmentPortfolios = response.data;
        // console.log($scope.investmentPortfolios);

        $scope.changeOrderAttribute = function(inputAttribute) {
          if (inputAttribute === $scope.orderAttribute) {
            $scope.isOrderDescending = !$scope.isOrderDescending;
          } else {
            $scope.isOrderDescending = false;
          }
          $scope.orderAttribute = inputAttribute;
        };

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
            var dailyPrices = response;
            // investmentPortfolio.costBasis = parseFloat(investmentPortfolio.cost_basis);

            $scope.currentPrice = dailyPrices.data.daily_prices.slice(-1)[0][1];
            console.log('current price', $scope.currentPrice);

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
                console.log('total port risk', $scope.totalPortfolioRisk);

                $scope.totalPortfolioSharpe += parseFloat($scope.totalWeighting * investmentPortfolio.sharpe);
                $scope.totalPortfolioCorrelation += parseFloat($scope.totalWeighting * investmentPortfolio.correlation);
              });
            }
          });
          // retrieves beginning of year stock prices and calculates return
          $http.get("http://marketdata.websol.barchart.com/getHistory.json?&key=a6ff075b20922ed334cf367cab045322&startDate=20170103&type=daily&order=desc&symbol=" + investmentPortfolio.ticker).then(function(response) {
            var stockData = response.data.results;
            console.log('stockData', stockData);

            var beginningYearPrice = stockData[stockData.length - 1].open;
            var yesterdayPrice = stockData[0].close;
            console.log('yesterday price', yesterdayPrice);
            investmentPortfolio.ytdReturn = parseFloat((yesterdayPrice - beginningYearPrice) / beginningYearPrice);

            if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
              $scope.weightedYtdReturn = 0;
                console.log('wtf',  $scope.weightedYtdReturn);
              $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
                $scope.weightedYtdReturn += parseFloat(investmentPortfolio.weighting * investmentPortfolio.ytdReturn);
              });
            }
          });

          // retrieves prices 6 months ago and calculates return
          $http.get("http://marketdata.websol.barchart.com/getHistory.json?&key=a6ff075b20922ed334cf367cab045322&startDate=20160727&type=daily&order=desc&symbol=" + investmentPortfolio.ticker).then(function(response) {
            var stockData = response.data.results;

            var sixMonthAgoPrice = stockData[stockData.length - 1].open;
            var yesterdayPrice = stockData[0].close;

            investmentPortfolio.sixMonthReturn = parseFloat((yesterdayPrice - sixMonthAgoPrice) / sixMonthAgoPrice);

            if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
              $scope.weightedSixMonthReturn = 0;
              $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
                $scope.weightedSixMonthReturn += parseFloat(investmentPortfolio.weighting * investmentPortfolio.sixMonthReturn);
              });
            }
          });

          // retrieves prices since inception and calculates return
          $http.get("http://marketdata.websol.barchart.com/getHistory.json?&key=a6ff075b20922ed334cf367cab045322&startDate=" + investmentPortfolio.purchase_date + "&type=daily&order=desc&symbol=" + investmentPortfolio.ticker).then(function(response) {
            var stockData = response.data.results;
            var purchasePrice = stockData[stockData.length - 1].open;
            var yesterdayPrice = stockData[0].close;
            // console.log(purchasePrice);

            investmentPortfolio.sinceInceptionReturn = parseFloat((yesterdayPrice - purchasePrice) / purchasePrice);

            if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
              $scope.weightedSinceInceptionReturn = 0;
              $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
                $scope.weightedSinceInceptionReturn += parseFloat(investmentPortfolio.weighting * investmentPortfolio.sinceInceptionReturn);
              });
            }
          });
        });
      });
    };
  });
})();
