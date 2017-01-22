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

        $scope.changeOrderAttribute = function(inputAttribute) {
          if (inputAttribute === $scope.orderAttribute) {
            $scope.isOrderDescending = !$scope.isOrderDescending;
          } else {
            $scope.isOrderDescending = false;
          }
          $scope.orderAttribute = inputAttribute;
        };

      });
    };
  });
})();
