clientSideValidations.validators.remote['state'] = function(element, options) {
  if ($.ajax({
    url: '/validators/state.json',
    data: { name: element.val() },
    // async *must* be false
    async: false
  }).status == 404) {
    return options.message;
  }
}

clientSideValidations.validators.remote['city'] = function(element, options) {
  var state_name = element[0].name.replace('city', 'state');
  if ($.ajax({
    url: '/validators/city.json',
    data: { name: element.val(), state_name: element[0].form[state_name].value },
    // async *must* be false
    async: false
  }).status == 404) {
    return options.message;
  }
}

clientSideValidations.validators.local['monday'] = function(element, options) {
  var dateParts = element.val().split("/");

  if(dateParts.length != 3) {
    return options.message;
  }

  var date = new Date(dateParts[2], dateParts[1] - 1, dateParts[0]);

  if(date.getDay() != 1) {
    return options.message;
  }
}

clientSideValidations.validators.local['date'] = function(element, options) {
  var dateParts = element.val().split("/");

  if(dateParts.length != 3) {
    return options.message;
  }

  dateParts[1] = dateParts[1] - 1;
  var date = new Date(dateParts[2], dateParts[1], dateParts[0]);

  if(date.getFullYear() != dateParts[2] || date.getMonth() != dateParts[1] || date.getDate() != dateParts[0]) {
    return options.message;
  }
}

$(document).ready(function() {
  $("#user_state").change(function() {
    $(this)[0].form["user[city]"].value = "";
  })
})
