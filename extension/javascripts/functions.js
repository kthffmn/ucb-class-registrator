var REGISTER = "[name='data[RegistrationTransaction][";

function nextPage() {
	$(".submit").children()[0].click();
}

function fillInFields(data, selector) {
	$.each(data, function(fieldName, value) {
		var jquery_selector = selector + fieldName + "]']";
		$(jquery_selector).val(value);
	});
}

function fillInRegistrationFields(data) {
	var selector = "[name='data[LegacyRegistration][";
	fillInFields(data, selector);
}

function fillInPaymentFields(data) {
  fillInFields(data, REGISTER);
}

function fillInExpirationDates(data) {
  var selector = REGISTER + "expiration][";
  fillInFields(data, selector);
}
