$(document).ready(function() {
  $("#user_state").change(function() {
    $(this)[0].form["user[city]"].value = "";
  })

  $("#user_birthday").datepicker({
    dateFormat: "dd/mm/yy",
    changeYear: true,
    changeMonth: true,
    onClose: function(dateText, inst) {
      $(inst.input).change().focusout();
    }
  });
})