function fillAndClick() {
  if ($(".submit").children()[0].value === "Continue Registration") {
    fillInFields();
    nextPage();
  } else {
    nextPage();
  }
}

setTimeout(fillAndClick, 250);
