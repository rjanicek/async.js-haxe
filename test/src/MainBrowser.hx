package;

import haxe.Firebug;
import js.mocha.Mocha;
import specs.AsyncSpec;

using js.mocha.Mocha;

/**
 * async.js-haxe browser tests
 * @author Richard Janicek
 */

class MainBrowser {
	
	static function main() {
		if (Firebug.detect())
			Firebug.redirectTraces();
			
		Mocha.setup( { ui: Ui.BDD } );
		new AsyncSpec();
		Mocha.run();
	}
	
}