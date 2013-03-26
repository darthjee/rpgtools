(function($){
	$.fn.findParent = function(query){
		var parent = $(this).parent();
		while (!parent.is(query) && parent.length)
			parent = parent.parent();
		return parent;
	};
	
	$.fn.cycleClasses = function(list)
	{
		var $this = this;
		if (arguments.length > 1){
			$this.cycleClasses(arguments);
		}
		else if (typeof list == "string"){
			$this.cycleClasses([list]);
		}
		else{
			for (var i = 0; i < list.length; i++)
			{
				if ($this.hasClass(list[i])){
					$this.removeClass(list[i]);
					$this.addClass(list[(++i) % list.length]);
					break;
				}
			}
		}
	}
	
	$.fn.changeClass = function(classe, list){
		var $this = this;
		if (arguments.length > 2){
			$this.changeClass(classe, Array.slice.call(arguments));
		}
		else if (typeof list == "string"){
			$this.changeClass(classe,[list]);
		}
		else{
			$this.removeClass(list.join(" "));
			$this.addClass(classe);
		}
		return $this;
	}
	
	$.maskExtend = function()
	{
		var mask = [].shift.apply(arguments);
		$(arguments).each(function(){
			var obj = this;
			for (prop in mask)
			{
				if (typeof obj[prop] != "undefined")
					mask[prop] = obj[prop];
			}
		});
		return mask;
	}
	
	$.fn.showChildrenMatch = function(selector)
	{
		var $this = this;
		$this.children().not(selector).hide();
		$this.children().filter(selector).show();
	}
	
	$.fn.highlight = function(){
		var $this = this;
		$this.addClass('debug-highlight');
	}
	
	$.fn.tip = function(config){
		config = $.extend({
			contentType:'text',
			content:'',
			append:$('body')
		}, config);
		
		if (config.content){
			
			var $this = this;
			var offset = $this.offset();
			
			var $div = $('<div class="tip-box"><div class="anchor-box"><div class="content"></div><span class="v-border-arrow"></span></div></div>');
			var $content = $div.find('.content');
			var $arrow = $div.find('.v-border-arrow');
			
			switch(config.contentType){
				case 'text' : $content.text(config.content);
					break;
				case 'html' : $content.html(config.content);
					break;
			}
			config.append.append($div);
			
			$div.css('left',offset.left-($div.width()-$this.width())/2);
			$div.css('top',offset.top-$this.height());
			var margin = $div.width()/2-5;
			$arrow.css('margin-left', margin);
			$arrow.css('margin-right', margin);
			return $div;
		}
	}
	
	$.fn.bindToolTip = function(config){
		config = $.extend({
			attribute:'alt',
			events:{}
		}, config);
		
		config.events = $.extend({mouseover:{}, mouseout:{}},config.events);
		
		function createEvent(eventName, defConf){
			var conf = $.extend({call:function(){}},config.events[eventName]);
			defConf = $.extend({call:function(){}},defConf);
			var callback = conf.call;
			var call = defConf.call;
			
			conf = $.extend(defConf, conf);
			conf.call = function(){
				call.apply(this, arguments);
				callback.apply(this, arguments); 
			};
			conf.evt = eventName;
			return conf;
		}
		
		var binds = {
			mouseover : {
		    	timeout:300,
		    	call:function(bubble, evt){
		    		if (bubble.tip)
		    		{
		    			var $fade = bubble.tip;
		    			$fade.fadeOut(function(){
		    				$fade.remove();
		    			});
		    		}
		    		var $this = $(this);
		    		var name = $this.attr(config.attribute);
		    		$tip = $this.tip({
		    			content:name
		    		});
		    		if ($tip){
			    		bubble.tip = $tip;
			    		$tip.hide();
			    		$tip.fadeIn();
			    	}
		    	}
		   },
		   mouseout:{
		    	timeout:800,
		    	call:function(bubble, evt){
		    		if (bubble.tip)
		    		{
		    			var $fade = bubble.tip;
		    			$fade.fadeOut(function(){
		    				$fade.remove();
		    			});
		    		}
		    	}
		    }
		};
		
		var events = [];
		
		for (evt in config.events){
			var evente = createEvent(evt, binds[evt]); 
			events.push(evente)
		}
		
		this.eventBubble(events);
	}
	
})(jQuery)