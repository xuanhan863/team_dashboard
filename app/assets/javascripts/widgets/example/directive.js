app.directive("example", ["$http", "ExampleModel", function($http, ExampleModel) {

  function link(scope, element, attrs) {

    function onSuccess(data) {
      scope.counter = data.value;
    }

    function update() {
      return ExampleModel.success(onSuccess);
      //return ExampleModel.getData(scope.widget).success(onSuccess);
    }

    scope.counter = 0;
    scope.init(update);
  }

  return {
    template: $("#templates-widgets-example-show").html(),
    link: link
  };
}]);
