$(document).ready(function() {
function position() {
  this.style("left", function(d) { return d.x + "px"; })
      .style("top", function(d) { return d.y + "px"; })
      .style("width", function(d) { return Math.max(0, d.dx - 1) + "px"; })
      .style("height", function(d) { return Math.max(0, d.dy - 1) + "px"; });
}
var margin = {top: 40, right: 10, bottom: 10, left: 10},
    width = 1200 - margin.left - margin.right,
    height = 600 - margin.top - margin.bottom;

var color = d3.scale.category20c();

var treemap = d3.layout.treemap()
    .size([width, height])
    .sticky(true)
    .value(function(d) { return d.size; });

var div = d3.select(".treemap").append("div")
    .style("position", "relative")
    .style("width", (width + margin.left + margin.right) + "px")
    .style("height", (height + margin.top + margin.bottom) + "px")
    .style("left", margin.left + "px")
    .style("top", margin.top + "px");

// Parent topic
// child documents
d3.json("economia_topic.json", function(error, root) {
 
  if (!error) {
		var parents = new Array();
		var tooltip = d3.select("#treemap").append("div")
                       .attr("class", "tooltip")
                       .style("opacity", 0.5);
		var dohtmltooltips = function(d){
			html = 'topic:'+d.parent.name;
			return html;
        }
        var node = div.datum(root).selectAll(".node")
			  .data(treemap.nodes)
			  .enter().append("div")
			  .attr("class", "node")
			  .call(position)
			  .style("background", function(d) { return d.children ? color(d.name) : null; })
			  .text(function(d) { parents.push(!d.children ? null : d.name) ; return d.children ? null : d.name; })
			  .on("mouseover", function(d) {
			    
                var mouse = d3.mouse(this).map( function(d) { return parseInt(d); } );
				tooltip.classed("hidden", false)
                       .attr("style", "left:"+(mouse[0] + d.x)+"px;top:"+(d.y + mouse[1])+"px")
                       .html(dohtmltooltips(d));
			  });
		
		parents = parents.filter(function(val) { return val !== null; });
		$.each(parents, function(ind, val){
			   if (ind>1){
			   $('#colors ul').append('<li class="'+ind+'"><span style="background-color:'+color(val)+'">'+val +':'+color(val) +'</span></li>');
			   }
		}); 
		 
		d3.selectAll("input").on("change", function change() {
			var value = this.value === "count"
				? function() { return 1; }
				: function(d) { return d.size; };

			node
				.data(treemap.value(value).nodes)
			  .transition()
				.duration(1500)
				.call(position);
		  });

		function position() {
		  this.style("left", function(d) { return d.x + "px"; })
			  .style("top", function(d) { return d.y + "px"; })
			  .style("width", function(d) { return Math.max(0, d.dx - 1) + "px"; })
			  .style("height", function(d) { return Math.max(0, d.dy - 1) + "px"; });
		}
  } else {
  console.log(error);
  }
  });
}); //end document onready


