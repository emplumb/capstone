/* global angular, gon */
(function() {
  "use strict";
  angular.module("app").controller("stockSearchCtrl", function($scope, $http) {

    $scope.setup = function() {
      // retrieves logo
      $http.get("/api/v1/investments/" + gon.investment.id).then(function(response) {
        $scope.investmentId = response.data.id;
        $scope.investmentTicker = response.data.ticker;
        $scope.logo = response.data.logo;
      });
      $scope.searchTicker = function(inputTicker) {
        $http.get("https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.quotes+where+symbol+in+('" + inputTicker + "')&format=json&env=store://datatables.org/alltableswithkeys&callback=").then(function(response) {
          // console.log(response.config.params.ticker);
          $scope.stockInfo = response.data.query.results.quote;
          console.log($scope.stockInfo);
          $scope.name = $scope.stockInfo.Name;
          $scope.symbol = $scope.stockInfo.Symbol;
          $scope.price = $scope.stockInfo.LastTradePriceOnly;
          $scope.openPrice = $scope.stockInfo.Open;
          $scope.percentChange = $scope.stockInfo.ChangeinPercent;
        });
      };
    };
  });
})();
