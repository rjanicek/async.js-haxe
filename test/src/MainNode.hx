package;

import js.mocha.Mocha;
import specs.AsyncSpec;

using js.mocha.Mocha;

/**
 * async.js-haxe node tests
 * @author Richard Janicek
 */
class MainNode {
	static function main() {
		new AsyncSpec();
	}	
}