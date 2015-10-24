'use strict';

/**
 * @ngdoc function
 * @name cloudConfVarnaMicroservicesApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the cloudConfVarnaMicroservicesApp
 */
angular.module('cloudConfVarnaMicroservicesApp')
  .controller('MainCtrl', ['$scope', '$http', function ($scope, $http) {

  	$scope.matches = [];

  	$http.get("http://cloudconfvarnamicroservices.azurewebsites.net/api/matches").success(function (data, status, headers, config) {   
  		console.log(data);
  		$scope.matches = data;
    }).error(function (data, status, headers, config) {
        alert("Please try again later.");
    });
  }]);
