async.js-haxe
=============

Haxe bindings for async.js - Async utilities for node and the browser.

Tested with Haxe 2.10, async.js 0.1.22, node.js 0.8.7, and Chrome.

GitHub -> https://github.com/rjanicek/async.js-haxe<br>
API Docs ->	https://github.com/rjanicek/async.js-haxe/blob/master/src/js/Async.hx<br>
Tests -> http://rjanicek.github.com/async.js-haxe<br>
Richard Janicek -> http://www.janicek.co<br>
async.js by Caolan McMahon - MIT -> https://github.com/caolan/async<br>

###html
```html
<script type="text/javascript" src="async.js"></script>
```

###Haxe
```haxe
import js.Async;

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

	}
}
```

detailed examples -> https://github.com/rjanicek/async.js-haxe/blob/master/test/src/specs/AsyncSpec.hx

