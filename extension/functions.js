var info = {
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

function nextPage() {
	$(".submit").children()[0].click();
}

function fillInFields() {
	$.each(info, function(fieldName, value) {
		fillInField(fieldName, value)
	});
}

function fillInField(fieldName, value) {
	var prefix = "[name='data[LegacyRegistration]["
	var field = $(prefix + fieldName + "]']");
	field.val(value);
}
