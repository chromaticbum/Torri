$(document).ready(function() {
  $("#user_state").change(function() {
    $(this)[0].form["user[city]"].value = "";
  })

  $("#birthday_picker").datepicker({
    dateFormat: "mm/dd/yy",
    altField: "#user_birthday",
    altFormat: "dd/mm/yy",
    changeYear: true,
    changeMonth: true,
    onClose: function(dateText, inst) {
      $($(inst.input).datepicker("option", "altField")).change().focusout();
    }
  });
})