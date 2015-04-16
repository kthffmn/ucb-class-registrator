var cardData = {
  "creditcardtype_id":"1",
  "cc": "1234567812345678",
  "cvn":"123",
  "firstName": "Katherine",
  "lastName": "Hoffman",
  "email": "ktahoffman@gmail.com",
  "address": "680 Franklin Ave. Apt. 1",
  "city": "Brooklyn",
  "state": "New York",
  "zip": "11238"
};

var expirationData = {
  "month": "12",
  "year": "2018"
}

function fillAndClick(cardData, expirationData) {
  fillInPaymentFields(cardData);
  fillInExpirationDates(expirationData);
}

setTimeout(fillAndClick(cardData, expirationData), 250);