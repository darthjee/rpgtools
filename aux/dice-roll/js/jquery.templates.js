// Simple JavaScript Templating
// John Resig - http://ejohn.org/ - MIT Licensed
(function(){
	var cache = {};
	var tmpl = function tmpl(str, data){
		// Figure out if we're getting a template, or if we need to
		// load the template - and be sure to cache the result.
		str = str != null ? str : "";
		var fn = (str != "" && str != null && !/[^\w_. #-]/.test(str)) ?
			cache[str] = cache[str] ||
			tmpl($(str).html()) :
			(function(){
				// Convert the template into pure JavaScript
				var finalStr = str
					.replace(/[\r\t\n]+/g, " ")
					.split("<%").join("\t")
					.replace(/((^|%>)[^\t]*)'/g, "$1\r")
					.replace(/\t=(.*?)%>/g, "',$1,'")
					.split("\t").join("');")
					.split("%>").join("p.push('")
					.split("\r").join("\\'");
				
				// Generate a reusable function that will serve as a template
				// generator (and which will be cached).
				var func = new Function("obj",
					"var p=[],print=function(){p.push.apply(p,arguments);};" +
					// Introduce the data as local variables using with(){}
					"with(obj){p.push('" +
					finalStr
					+ "');}return p.join('');");
				return func;
			})();
		// Provide some basic currying to the user
		return data ? fn( data ) : fn;
	};
	/**
	 * Applying jQuery to the template
	 */
	 $.fn.tmpl = function(config){
	 	var $this = this;
	 	config = $.extend({
	 		string:null,
	 		data:{},
	 		template:null,
	 		method:'html'
	 	},config);
	 	
	 	var template = config.string ?
	 		tmpl(config.string) : (typeof config.template == "function") ?
	 		config.template : (typeof config.template == "string")?
	 		tmpl(config.template) : $this.data('template');
	 	
	 	var html = template(config.data);
	 	
	 	switch(config.method){
	 		case 'html' :
	 			$this.html(html);
	 			break;
	 		case 'append' :
	 			$this.append($(html));
	 			break;
	 	}
	 };
	 
	 $.tmpl = tmpl;
 })();