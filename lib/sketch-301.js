function clickRegister() {
	sizeOptions = document.getElementsByName("skuAndSize")[0];
	
	function selectSize() {
		for (index=0; index<sizeOptions.length; index++){
			if(sizeOptions.options[index].text == "9") {
				document.getElementsByName("skuAndSize")[0].selectedIndex = index;
			}
		}
	}
  selectSize();
  document.getElementsByClassName("add-to-cart nsg-button--nike-orange")[0].click();
}

setTimeout("clickRegister()", 250);