$(document).ready(function() {
    var data = gon.senti_array;


	var x = d3.scale.linear()
	    .domain([0, d3.max(data)])
	    .range([0, 800]);



	d3.select(".chart")
	  .selectAll("div")
	  .data(data)
	  .enter().append("div").attr("class", "bar")
	  .style("width", function(d) { return x(d) + "px"; })
	  .text(function(d) { return d; });

	var divs = document.getElementsByClassName('bar') // this needs to change based on how you want to select the generated elements

	for(var i=0; i< divs.length; i++) {
	  var text = divs[i].innerText;

	  divs[i].innerHTML = '<a href=#tweet_'+i+' >'+text+'</a>'
	}
});