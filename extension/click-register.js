function isSketch301() {
  var className = $("h2").text().toLowerCase();
  var isSketch301 = className.indexOf("sketch 301") >= 0
  if(isSketch301) nextPage();
}

setTimeout(isSketch301, 250);
