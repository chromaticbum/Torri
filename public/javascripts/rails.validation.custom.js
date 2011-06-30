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
  var date_parts = element.val().split("/");
  var date = new Date(date_parts[2], date_parts[1] - 1, date_parts[0]);

  if(date.getDay() != 1) {
    return options.message;
  }
}

$(document).ready(function() {
  $("#user_state").change(function() {
    $(this)[0].form["user[city]"].value = "";
  })
})
