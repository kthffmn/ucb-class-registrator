function isSketch301() {
  var className = $("h2").text().toLowerCase();
  var isSketch301 = className.indexOf("sketch 301") >= 0
  if(isSketch301) nextPage();
}

function testing() {
  var className = $("h2").text().toLowerCase();
  nextPage();
}

setTimeout(testing, 250);
