/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("portfoliosCtrl", function($scope, $http) {

    $scope.setup = function() {

      var params = {id: 42};
      $http.get("/api/v1/portfolios/" + params.id).then(function(response) {
        $scope.investmentPortfolios = response.data;
        console.log($scope.investmentPortfolios);
      });
    };

    $scope.getCostTotal = function() {
      var sum = 0;
      for (var i = 0; i < $scope.investmentPortfolios.length; i++) {
        sum += parseInt($scope.investmentPortfolios[i].cost_basis);
      }
      return sum;
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
