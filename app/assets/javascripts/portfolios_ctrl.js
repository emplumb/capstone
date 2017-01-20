/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("portfoliosCtrl", function($scope, $http, $location) {

    $scope.setup = function() {
      $scope.id = (/portfolios\/(\d+)/.exec($location.absUrl())[1]);
      // var params = {id: 42};
      // $http.get("/api/v1/investment_portfolios").then(function(response) {

      $http.get("/api/v1/portfolios/" + $scope.id).then(function(response) {

        $scope.investmentPortfolios = response.data;
        console.log($scope.investmentPortfolios);

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
          // // retrieves current stock prices
          // $http.get("http://marketdata.websol.barchart.com/getQuote.json?key=a6ff075b20922ed334cf367cab045322&symbols=" + investmentPortfolio.ticker).then(function(response) {
          //   // console.log(response);
          //   var stockData = response.data.results[0];
          //   $scope.currentPrice = stockData.lastPrice;

          //   investmentPortfolio.currentValue = stockData.lastPrice * investmentPortfolio.shares;
          //   $scope.totalCurrentValue += investmentPortfolio.currentValue;

          //   investmentPortfolio.gainLoss = investmentPortfolio.currentValue - investmentPortfolio.cost_basis;
          //   $scope.totalGainLoss += investmentPortfolio.gainLoss;


          //   // ensures totalCurrentValue isn't calculated until all currentValues are looped through
          //   numberinvestmentPortfoliosLoaded++;
          //   if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
          //     $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
          //       investmentPortfolio.weighting = investmentPortfolio.currentValue / $scope.totalCurrentValue;
          //     $scope.totalWeighting += investmentPortfolio.weighting;
          //     // console.log($scope.totalWeighting);
          //     $scope.totalPortfolioRisk += ($scope.totalWeighting * investmentPortfolio.standard_deviation);
          //     console.log($scope.totalPortfolioRisk);
          //     // $scope.totalPortfolioSharpe += ($scope.totalWeighting * investmentPortfolio.sharpe);
          //     $scope.totalPortfolioCorrelation += ($scope.totalWeighting * investmentPortfolio.correlation);
          //     });
          //   }
          // });
          // retrieves beginning of year stock prices and calculates return
          // $http.get("http://marketdata.websol.barchart.com/getHistory.json?&key=a6ff075b20922ed334cf367cab045322&startDate=20170103&type=daily&order=desc&symbol=" + investmentPortfolio.ticker).then(function(response) {
          //   var stockData = response.data.results;

          //   var beginningYearPrice = stockData[stockData.length - 1].open;
          //   var yesterdayPrice = stockData[0].close;

          //   investmentPortfolio.ytdReturn = (yesterdayPrice - beginningYearPrice) / beginningYearPrice;

          //   if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
          //     $scope.weightedYtdReturn = 0;
          //     $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
          //       $scope.weightedYtdReturn += (investmentPortfolio.weighting * investmentPortfolio.ytdReturn);
          //     });
          //   }
          // });
          // // retrieves prices 6 months ago and calculates return
          // $http.get("http://marketdata.websol.barchart.com/getHistory.json?&key=a6ff075b20922ed334cf367cab045322&startDate=20160727&type=daily&order=desc&symbol=" + investmentPortfolio.ticker).then(function(response) {
          //   var stockData = response.data.results;

          //   var sixMonthAgoPrice = stockData[stockData.length - 1].open;
          //   var yesterdayPrice = stockData[0].close;

          //   investmentPortfolio.sixMonthReturn = (yesterdayPrice - sixMonthAgoPrice) / sixMonthAgoPrice;

          //   if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
          //     $scope.weightedSixMonthReturn = 0;
          //     $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
          //       $scope.weightedSixMonthReturn += (investmentPortfolio.weighting * investmentPortfolio.sixMonthReturn);
          //     });
          //   }
          // });
          // // retrieves prices since inception and calculates return
          // $http.get("http://marketdata.websol.barchart.com/getHistory.json?&key=a6ff075b20922ed334cf367cab045322&startDate=" + investmentPortfolio.purchase_date + "&type=daily&order=desc&symbol=" + investmentPortfolio.ticker).then(function(response) {
          //   var stockData = response.data.results;
          //   var purchasePrice = stockData[stockData.length - 1].open;
          //   var yesterdayPrice = stockData[0].close;
          //   // console.log(purchasePrice);

          //   investmentPortfolio.sinceInceptionReturn = (yesterdayPrice - purchasePrice) / purchasePrice;

          //   if (numberinvestmentPortfoliosLoaded === $scope.investmentPortfolios.length) {
          //     $scope.weightedSinceInceptionReturn = 0;
          //     $scope.investmentPortfolios.forEach(function(investmentPortfolio) {
          //       $scope.weightedSinceInceptionReturn += (investmentPortfolio.weighting * investmentPortfolio.sinceInceptionReturn);
          //     });
          //   }
          // });
        });
      });
    };



      // $http.get("https://www.quandl.com/api/v3/datasets/YAHOO/tsla/data.json?start_date=2017-01-03&end_date=2017-01-03&column_index=6&order=asc&api_key=AVB8P1K72xSZsU2SyFZN").then(function(stockData) {
      //   // $scope.investments = console.log(stockData.data);

      //   // var pricesArray = stockData.dataset_data.data.map(function(d) {
      //   //   return [new Date(d[0]).getTime(), d[1]];
      //   // });

      //   // var chartData = [];
      //   // $scope.each(stockData, function(index, value) {
      //   //     var dailyPrices = (value);
      //   //     console.log(dailyPrices);
      //   //     chartData.push(dailyPrices);
      //   // });

      //   console.log(stockData.dataset_data.data[0][1]);
      // });


    // };



  });
})();
