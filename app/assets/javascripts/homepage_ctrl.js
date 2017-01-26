/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("homepageCtrl", function($scope, $http) {

    $scope.setup = function() {
      $scope.orderAttribute = 'name';
      $scope.isOrderDescending = false;

      $http.get("/api/v1/portfolios/").then(function(response) {
        console.log(response.data);
        $scope.portfolios = response.data;

        $scope.portfolios.forEach(function(portfolio) {
          portfolio.ytdReturn = parseFloat(portfolio.ytd_return);
          portfolio.sixMonthReturn = parseFloat(portfolio.six_month_return);
          portfolio.inceptionReturn = parseFloat(portfolio.inception_return);
          portfolio.standardDeviation = parseFloat(portfolio.standard_deviation);
          portfolio.sharpe = parseFloat(portfolio.sharpe);
          portfolio.correlation = parseFloat(portfolio.correlation);
        });
      });
    };

    $scope.changeOrderAttribute = function(inputAttribute) {
      if (inputAttribute === $scope.orderAttribute) {
        $scope.isOrderDescending = !$scope.isOrderDescending;
      } else {
        $scope.isOrderDescending = false;
      }
      $scope.orderAttribute = inputAttribute;
    };
  });
})();
