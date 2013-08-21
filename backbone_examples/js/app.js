
var directory = {


	views: {},
	models: {},
	loadTemplates: function(view, callback) {
		var deferreds = [];
		$.each(view, function(index, view){
	            if (directory[view]) {
			    deferreds.push($.get('tpl/'+ view +'.html'), function(data) {
				    directory[view].prototype.template  = _.template(data)
			    
			    })
		    } else {
		    }	
		});
	}
};
