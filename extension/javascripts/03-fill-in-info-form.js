var data = {
  "firstName":"Katie",
  "lastName":"Hoffman",
  "email":"ktahoffman@gmail.com",
  "phone":"7202327274",
  "phone2":"7202327274",
  "address":"680 Franklin Ave. Apt 1",
  "city":"Brooklyn",
  "state":"NY",
  "zip":"11238"
};

function fillAndClick(data) {
  if ($(".submit").children()[0].value === "Continue Registration") {
    fillInRegistrationFields(data);
    $(".submit").children()[1].click();
  } else {
    nextPage();
  }
}

setTimeout(fillAndClick(data), 250);
