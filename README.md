async.js-haxe
=============

Haxe bindings for async.js - Async utilities for node and the browser.

Tested with Haxe 2.10, async.js 0.1.22, node.js 0.8.7, and Chrome.

GitHub -> https://github.com/rjanicek/async.js-haxe<br>
API Docs ->	https://github.com/rjanicek/async.js-haxe/blob/master/src/js/async/Async.hx<br>
Tests -> http://rjanicek.github.com/async.js-haxe<br>
Richard Janicek -> http://www.janicek.co<br>
async.js by Caolan McMahon - MIT -> https://github.com/caolan/async<br>

###html
```html
<script type="text/javascript" src="async.js"></script>
```

###Haxe
```haxe
import js.async.Async;

class Main {
	public function new() {
		
		var async = Async.instance;
		
		async.parallel([
			function (ret) { /* get data from server */	},
			function (ret) { /* get data from server */	}
		], function(error, results) {
			// all functions returned in parallel or error happened
		});
		
		async.series([
			function (ret) { /* get data from server */	},
			function (ret) { /* get data from server */	}
		], function(error, results) {
			// all functions returned in series or error happened
		});

		async.auto( {
			swing_sword: function(ret) {
				// async code that swings sword
				ret(null, "schwing");
			},
			block_shield: function(ret) {
				// async code that blocks with shield
				ret(null, "thud");
			},
			battle_done: ["swing_sword", "block_shield", function(ret) {
				// this function waits for swing_sword and block_shield to complete
				ret(null, "victory");
			}]							
		}, function(err, results) {
			// handle errors and results for above functions here 
			// results == { swing_sword: "schwing", block_shield: "thud", battle_done: "victory" }
		});


	}
}
```

detailed examples -> https://github.com/rjanicek/async.js-haxe/blob/master/test/src/specs/AsyncSpec.hx

