(function () { "use strict";
var $estr = function() { return js.Boot.__string_rec(this,''); };
var MainBrowser = function() { }
MainBrowser.__name__ = true;
MainBrowser.main = function() {
	if(haxe.Firebug.detect()) haxe.Firebug.redirectTraces();
	js.mocha.Mocha.setup({ ui : js.mocha.Ui.BDD});
	new specs.AsyncSpec();
	js.mocha.Mocha.run();
}
var Reflect = function() { }
Reflect.__name__ = true;
Reflect.hasField = function(o,field) {
	return Object.prototype.hasOwnProperty.call(o,field);
}
var Std = function() { }
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
var haxe = {}
haxe.Firebug = function() { }
haxe.Firebug.__name__ = true;
haxe.Firebug.detect = function() {
	try {
		return console != null && console.error != null;
	} catch( e ) {
		return false;
	}
}
haxe.Firebug.redirectTraces = function() {
	haxe.Log.trace = haxe.Firebug.trace;
	js.Lib.onerror = haxe.Firebug.onError;
}
haxe.Firebug.onError = function(err,stack) {
	var buf = err + "\n";
	var _g = 0;
	while(_g < stack.length) {
		var s = stack[_g];
		++_g;
		buf += "Called from " + s + "\n";
	}
	haxe.Firebug.trace(buf,null);
	return true;
}
haxe.Firebug.trace = function(v,inf) {
	var type = inf != null && inf.customParams != null?inf.customParams[0]:null;
	if(type != "warn" && type != "info" && type != "debug" && type != "error") type = inf == null?"error":"log";
	console[type]((inf == null?"":inf.fileName + ":" + inf.lineNumber + " : ") + Std.string(v));
}
haxe.Log = function() { }
haxe.Log.__name__ = true;
haxe.Log.trace = function(v,infos) {
	js.Boot.__trace(v,infos);
}
haxe.Timer = function(time_ms) {
	var me = this;
	this.id = window.setInterval(function() {
		me.run();
	},time_ms);
};
haxe.Timer.__name__ = true;
haxe.Timer.stamp = function() {
	return new Date().getTime() / 1000;
}
haxe.Timer.prototype = {
	run: function() {
	}
}
var js = {}
js.Boot = function() { }
js.Boot.__name__ = true;
js.Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
}
js.Boot.__trace = function(v,i) {
	var msg = i != null?i.fileName + ":" + i.lineNumber + ": ":"";
	msg += js.Boot.__string_rec(v,"");
	var d;
	if(typeof(document) != "undefined" && (d = document.getElementById("haxe:trace")) != null) d.innerHTML += js.Boot.__unhtml(msg) + "<br/>"; else if(typeof(console) != "undefined" && console.log != null) console.log(msg);
}
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2, _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i;
			var str = "[";
			s += "\t";
			var _g = 0;
			while(_g < l) {
				var i1 = _g++;
				str += (i1 > 0?",":"") + js.Boot.__string_rec(o[i1],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) { ;
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
}
js.Lib = function() { }
js.Lib.__name__ = true;
js.async = {}
js.async.Async = function() { }
js.async.Async.__name__ = true;
js.expect = {}
js.expect.E = function() { }
js.expect.E.__name__ = true;
js.expect.E.expect = function(actual) {
	return js.expect.E._expect(actual);
}
js.expect.E.should = function(actual) {
	return js.expect.E._expect(actual);
}
js.expect.E.getVersion = function() {
	return js.expect.E._expect.version;
}
js.mocha = {}
js.mocha.Ui = { __ename__ : true, __constructs__ : ["BDD","EXPORTS","QUNIT","TDD"] }
js.mocha.Ui.BDD = ["BDD",0];
js.mocha.Ui.BDD.toString = $estr;
js.mocha.Ui.BDD.__enum__ = js.mocha.Ui;
js.mocha.Ui.EXPORTS = ["EXPORTS",1];
js.mocha.Ui.EXPORTS.toString = $estr;
js.mocha.Ui.EXPORTS.__enum__ = js.mocha.Ui;
js.mocha.Ui.QUNIT = ["QUNIT",2];
js.mocha.Ui.QUNIT.toString = $estr;
js.mocha.Ui.QUNIT.__enum__ = js.mocha.Ui;
js.mocha.Ui.TDD = ["TDD",3];
js.mocha.Ui.TDD.toString = $estr;
js.mocha.Ui.TDD.__enum__ = js.mocha.Ui;
js.mocha.Mocha = function() { }
js.mocha.Mocha.__name__ = true;
js.mocha.Mocha.setup = function(opts) {
	opts.ui = Std.string(opts.ui).toLowerCase();
	if(Reflect.hasField(opts,"reporter")) opts.reporter = Std.string(opts.reporter).toLowerCase();
	mocha.setup(opts);
}
js.mocha.Mocha.run = function() {
	mocha.run();
}
js.mocha.M = function() { }
js.mocha.M.__name__ = true;
js.mocha.M.describe = function(description,spec) {
	describe(description, spec);
}
js.mocha.M.it = function(description,func) {
	it(description, func);
}
var specs = {}
specs.AsyncSpec = function() {
	var async = js.async.Async.instance;
	js.mocha.M.describe("Async",function() {
		js.mocha.M.describe("Collections",function() {
			js.mocha.M.describe("#forEach()",function() {
				js.mocha.M.it("sould iterate an array in parallel",function(done) {
					var count = 0;
					async.forEach(["one","two"],function(element,ret) {
						js.expect.E.should(element).be.a("string");
						count++;
						ret();
					},function(error) {
						js.expect.E.should(count).equal(2);
						done();
					});
				});
			});
			js.mocha.M.describe("#forEachSeries()",function() {
				js.mocha.M.it("sould iterate an array in series",function(done) {
					var one = false;
					var two = false;
					async.forEachSeries(["one","two"],function(element,ret) {
						switch(element) {
						case "one":
							js.expect.E.should(two).not.be.ok();
							one = true;
							break;
						case "two":
							js.expect.E.should(one).be.ok();
							two = true;
							break;
						}
						ret();
					},function(error) {
						js.expect.E.should(one).be.ok();
						js.expect.E.should(two).be.ok();
						done();
					});
				});
			});
			js.mocha.M.describe("#forEachLimit()",function() {
				js.mocha.M.it("sould iterate an array in batches in series",function(done) {
					var batch1 = false;
					var batch2 = false;
					async.forEachLimit([1,2,3,4],2,function(element,ret) {
						switch(element) {
						case 1:case 2:
							js.expect.E.should(batch2).not.be.ok();
							batch1 = true;
							break;
						case 3:case 4:
							js.expect.E.should(batch1).be.ok();
							batch2 = true;
							break;
						}
						ret();
					},function(error) {
						js.expect.E.should(batch1).be.ok();
						js.expect.E.should(batch2).be.ok();
						done();
					});
				});
			});
			js.mocha.M.describe("#map()",function() {
				js.mocha.M.it("should map a function to an array and produce a result array in parallel",function(done) {
					async.map([1,2,3],function(element,ret) {
						ret(null,-element);
					},function(error,results) {
						js.expect.E.should(results).eql([-1,-2,-3]);
						done();
					});
				});
			});
			js.mocha.M.describe("#mapSeries()",function() {
				js.mocha.M.it("should map a function to an array and produce a result array in series",function(done) {
					var called = [false,false,false];
					async.mapSeries([0,1,2],function(element,ret) {
						called[element] = true;
						switch(element) {
						case 0:
							js.expect.E.should(called).eql([true,false,false]);
							break;
						case 1:
							js.expect.E.should(called).eql([true,true,false]);
							break;
						case 2:
							js.expect.E.should(called).eql([true,true,true]);
							break;
						}
						ret(null,element * element);
					},function(error,results) {
						js.expect.E.should(results).eql([0,1,4]);
						done();
					});
				});
			});
			js.mocha.M.describe("#filter()",function() {
				js.mocha.M.it("should filter array items in parallel",function(done) {
					var startSeconds = specs.Timer.stamp();
					async.filter([1,2,3,4,5],function(item,ret) {
						specs.Timer.delay(function() {
							ret(item % 2 == 0);
						},item * 100);
					},function(results) {
						js.expect.E.should(specs.Timer.stamp() - startSeconds).be.lessThan(0.6);
						js.expect.E.should(results).not.contain(1).and.contain(2).and.not.contain(3).and.contain(4).and.not.contain(5);
						done();
					});
				});
			});
			js.mocha.M.describe("#filterSeries()",function() {
				js.mocha.M.it("should filter array items in series",function(done) {
					var startSeconds = specs.Timer.stamp();
					async.filterSeries([1,2,3],function(item,ret) {
						specs.Timer.delay(function() {
							ret(item % 2 == 0);
						},item * 100);
					},function(results) {
						js.expect.E.should(specs.Timer.stamp() - startSeconds).be.lessThan(0.7);
						js.expect.E.should(results).not.contain(1).and.contain(2).and.not.contain(3);
						done();
					});
				});
			});
			js.mocha.M.describe("#reject()",function() {
				js.mocha.M.it("should reject array items in parallel",function(done) {
					var startSeconds = specs.Timer.stamp();
					async.reject([1,2,3,4,5],function(item,ret) {
						specs.Timer.delay(function() {
							ret(item % 2 == 0);
						},item * 100);
					},function(results) {
						js.expect.E.should(specs.Timer.stamp() - startSeconds).be.lessThan(0.6);
						js.expect.E.should(results).contain(1).and.not.contain(2).and.contain(3).and.not.contain(4).and.contain(5);
						done();
					});
				});
			});
			js.mocha.M.describe("#rejectSeries()",function() {
				js.mocha.M.it("should filter array items in series",function(done) {
					var startSeconds = specs.Timer.stamp();
					async.rejectSeries([1,2,3],function(item,ret) {
						specs.Timer.delay(function() {
							ret(item % 2 == 0);
						},item * 100);
					},function(results) {
						js.expect.E.should(specs.Timer.stamp() - startSeconds).be.lessThan(0.7);
						js.expect.E.should(results).contain(1).and.not.contain(2).and.contain(3);
						done();
					});
				});
			});
			js.mocha.M.describe("#reduce()",function() {
				js.mocha.M.it("should reduce array values into a single value",function(done) {
					async.reduce(["1","2","3"],"0",function(memo,item,cb) {
						async.nextTick(function() {
							cb(null,memo + item);
						});
					},function(error,result) {
						js.expect.E.should(result).equal("0123");
						done();
					});
				});
			});
			js.mocha.M.describe("#reduceRight()",function() {
				js.mocha.M.it("should reduce array values in reverse order into a single value",function(done) {
					async.reduceRight(["1","2","3"],"0",function(memo,item,cb) {
						async.nextTick(function() {
							cb(null,memo + item);
						});
					},function(error,result) {
						js.expect.E.should(result).equal("0321");
						done();
					});
				});
			});
			js.mocha.M.describe("#detect()",function() {
				js.mocha.M.it("should return the first value in a list that passes an async truth test",function(done) {
					async.detect(["truth","lie","truth"],function(item,ret) {
						async.nextTick(function() {
							ret(item == "lie");
						});
					},function(result) {
						js.expect.E.should(result).equal("lie");
						done();
					});
				});
			});
			js.mocha.M.describe("#detectSeries()",function() {
				js.mocha.M.it("should return the first value in a list that passes an async truth test in series",function(done) {
					async.detectSeries(["truth","lie","truth"],function(item,ret) {
						async.nextTick(function() {
							ret(item == "lie");
						});
					},function(result) {
						js.expect.E.should(result).equal("lie");
						done();
					});
				});
			});
			js.mocha.M.describe("#sortBy()",function() {
				js.mocha.M.it("should sorts a list by the results of running each value through an async iterator",function(done) {
					async.sortBy([3,2,1],function(item,ret) {
						async.nextTick(function() {
							ret(null,item);
						});
					},function(err,results) {
						js.expect.E.should(results).eql([1,2,3]);
						done();
					});
				});
			});
			js.mocha.M.describe("#some()",function() {
				js.mocha.M.it("should returns true if at least one element in the array satisfies an async test",function(done) {
					async.some([false,true,false],function(item,ret) {
						async.nextTick(function() {
							ret(item);
						});
					},function(result) {
						js.expect.E.should(result).be.ok();
						done();
					});
				});
			});
			js.mocha.M.describe("#every()",function() {
				js.mocha.M.it("should eturn true if every element in the array satisfies an async test",function(done) {
					async.every([true,true,true],function(item,ret) {
						async.nextTick(function() {
							ret(item);
						});
					},function(result) {
						js.expect.E.should(result).be.ok();
						done();
					});
				});
			});
			js.mocha.M.describe("#concat()",function() {
				js.mocha.M.it("should apply an iterator to each item in a list, concatenating the results.",function(done) {
					async.concat([1,2,3],function(item,ret) {
						async.nextTick(function() {
							ret(null,[Std.string(item)]);
						});
					},function(err,results) {
						js.expect.E.should(results).contain("1").and.contain("2").and.contain("3");
						done();
					});
				});
			});
			js.mocha.M.describe("#concatSeries()",function() {
				js.mocha.M.it("should apply an iterator to each item in a list in series, concatenating the results.",function(done) {
					async.concatSeries([1,2,3],function(item,ret) {
						async.nextTick(function() {
							ret(null,[Std.string(item)]);
						});
					},function(err,results) {
						js.expect.E.should(results).eql(["1","2","3"]);
						done();
					});
				});
			});
		});
		js.mocha.M.describe("Control Flow",function() {
			js.mocha.M.describe("#series()",function() {
				js.mocha.M.it("should run an array of functions in series",function(done) {
					var one = false;
					var two = false;
					async.series([function(ret) {
						specs.Timer.delay(function() {
							js.expect.E.should(one).not.be.ok();
							js.expect.E.should(two).not.be.ok();
							one = true;
							ret(null,1);
						},100);
					},function(ret) {
						specs.Timer.delay(function() {
							js.expect.E.should(one).be.ok();
							js.expect.E.should(two).not.be.ok();
							two = true;
							ret(null,2);
						},50);
					}],function(error,results) {
						js.expect.E.should(results).eql([1,2]);
						done();
					});
				});
				js.mocha.M.it("should run an object of functions in series",function(done) {
					var one = false;
					var two = false;
					async.series({ one : function(ret) {
						specs.Timer.delay(function() {
							js.expect.E.should(one).not.be.ok();
							js.expect.E.should(two).not.be.ok();
							one = true;
							ret(null,1);
						},100);
					}, two : function(ret) {
						specs.Timer.delay(function() {
							js.expect.E.should(one).be.ok();
							js.expect.E.should(two).not.be.ok();
							two = true;
							ret(null,2);
						},50);
					}},function(error,results) {
						js.expect.E.should(results).eql({ one : 1, two : 2});
						done();
					});
				});
			});
			js.mocha.M.describe("#parallel()",function() {
				js.mocha.M.it("should run an array of functions in parallel",function(done) {
					var one = false;
					var two = false;
					async.parallel([function(ret) {
						specs.Timer.delay(function() {
							js.expect.E.should(two).be.ok();
							one = true;
							ret(null,1);
						},100);
					},function(ret) {
						specs.Timer.delay(function() {
							js.expect.E.should(one).not.be.ok();
							two = true;
							ret(null,2);
						},50);
					}],function(error,results) {
						js.expect.E.should(results).eql([1,2]);
						done();
					});
				});
				js.mocha.M.it("should run an object of functions in parallel",function(done) {
					var one = false;
					var two = false;
					async.parallel({ one : function(ret) {
						specs.Timer.delay(function() {
							js.expect.E.should(two).be.ok();
							one = true;
							ret(null,1);
						},100);
					}, two : function(ret) {
						specs.Timer.delay(function() {
							js.expect.E.should(one).not.be.ok();
							two = true;
							ret(null,2);
						},50);
					}},function(error,results) {
						js.expect.E.should(results).have.property("one",1).and.property("two",2);
						done();
					});
				});
			});
			js.mocha.M.describe("#whilst()",function() {
				js.mocha.M.it("should repeatedly call fn, while test returns true",function() {
					var count = 0;
					async.whilst(function() {
						return count < 5;
					},function(cb) {
						async.nextTick(function() {
							count++;
							cb(null);
						});
					},function(err) {
						js.expect.E.should(count).equal(5);
					});
				});
			});
			js.mocha.M.describe("#until()",function() {
				js.mocha.M.it("should repeatedly call fn, until test returns true",function() {
					var count = 0;
					async.until(function() {
						return count == 5;
					},function(cb) {
						async.nextTick(function() {
							count++;
							cb(null);
						});
					},function(err) {
						js.expect.E.should(count).equal(5);
					});
				});
			});
			js.mocha.M.describe("#waterfall()",function() {
				js.mocha.M.it("should run an array of functions in series, each passing their results to the next in the array",function() {
					async.waterfall([function(ret) {
						ret(null,1,2);
					},function(arg1,arg2,ret) {
						js.expect.E.expect(arg1).to.equal(1);
						js.expect.E.expect(arg2).to.equal(2);
						ret(null,3);
					},function(arg,ret) {
						js.expect.E.expect(arg).to.equal(3);
						ret(null,"done");
					}],function(err,result) {
						js.expect.E.expect(result).to.equal("done");
					});
				});
			});
			js.mocha.M.describe("#queue()",function() {
				js.mocha.M.it("should create a queue object",function() {
					var q = async.queue(function(task,ret) {
					},2);
					js.expect.E.should(q).be.ok();
				});
				js.mocha.M.it("should process queued task",function(done) {
					var accumulator = 0;
					var q = async.queue(function(task,ret) {
						accumulator += task;
						ret(null,task);
					},2);
					var taskDone = false;
					q.drain = function() {
						js.expect.E.should(taskDone).be.ok();
						js.expect.E.should(accumulator).equal(1);
						done();
					};
					q.push(1,function(err) {
						taskDone = true;
					});
				});
				js.mocha.M.it("should process queued array of tasks signaling drain and empty events",function(done) {
					var accumulator = 0;
					var q = async.queue(function(task,ret) {
						accumulator += task;
						ret(null,task);
					},2);
					var empty = false;
					q.empty = function() {
						empty = true;
					};
					var drain = false;
					q.drain = function() {
						drain = true;
					};
					q.push([1,1,1]);
					specs.Timer.delay(function() {
						js.expect.E.should(accumulator).equal(3);
						js.expect.E.should(empty).be.ok();
						js.expect.E.should(drain).be.ok();
						done();
					},250);
				});
			});
			js.mocha.M.describe("#auto()",function() {
				js.mocha.M.it("should determine the best order for running functions based on their requirements",function(done) {
					var f1 = false;
					var f2 = false;
					var f3 = false;
					async.auto({ func1 : function(ret) {
						specs.Timer.delay(function() {
							f1 = true;
							ret(null,"done");
						},50);
					}, func2 : function(ret) {
						f2 = true;
						ret(null,"done");
					}, func3 : ["func1","func2",function(ret) {
						f3 = true;
						js.expect.E.should(f1).be.ok();
						js.expect.E.should(f2).be.ok();
						ret(null,"done");
					}]},function(err,results) {
						js.expect.E.should(f1).be.ok();
						js.expect.E.should(f2).be.ok();
						js.expect.E.should(f3).be.ok();
						js.expect.E.expect(results).to.have.keys("func1","func2","func3");
						done();
					});
				});
			});
			js.mocha.M.describe("#iterator()",function() {
				js.mocha.M.it("should iterate",function(done) {
					var f1 = false;
					var f2 = false;
					var iterator = async.iterator([function() {
						f1 = true;
					},function() {
						f2 = true;
					}]);
					while((iterator = iterator()) != null) {
					}
					js.expect.E.should(f1).be.ok();
					js.expect.E.should(f2).be.ok();
					done();
				});
			});
			js.mocha.M.describe("#apply()",function() {
				js.mocha.M.it("should create a continuation function with some arguments already applied",function(done) {
					async.parallel([async.apply(function(arg,ret) {
						js.expect.E.expect(arg).to.equal(1);
						ret();
					},1)],function(err,results) {
						done();
					});
				});
			});
			js.mocha.M.describe("#nextTick()",function() {
				js.mocha.M.it("should call the callback on a later loop around the event loop",function(done) {
					var called = false;
					async.nextTick(function() {
						called = true;
						done();
					});
					js.expect.E.should(called).not.be.ok();
				});
			});
		});
		js.mocha.M.describe("Utils",function() {
			js.mocha.M.describe("#memoize()",function() {
				js.mocha.M.it("should cache the results of an async function",function(done) {
					var slowCount = 0;
					var slow = function(ret) {
						async.nextTick(function() {
							slowCount++;
							ret("result");
						});
					};
					var cachedSlow = async.memoize(slow);
					async.series([function(ret) {
						cachedSlow(function(result) {
							js.expect.E.expect(result).to.equal("result");
							ret(null,null);
						});
					},function(ret) {
						cachedSlow(function(result) {
							js.expect.E.expect(result).to.equal("result");
							ret(null,null);
						});
					}],function(err,results) {
						js.expect.E.should(slowCount).equal(1);
						done();
					});
				});
			});
			js.mocha.M.describe("#log()",function() {
				js.mocha.M.it("should log the result of an async function to the console",function() {
					var hello = function(name,ret) {
						async.nextTick(function() {
							ret(null,"hello " + name);
						});
					};
					async.log(hello,"world");
				});
			});
			js.mocha.M.describe("#dir()",function() {
				js.mocha.M.it("should log the result of an async function to the console using console.dir to display the properties of the resulting object",function() {
					var hello = function(name,ret) {
						async.nextTick(function() {
							ret(null,{ hello : name});
						});
					};
					async.dir(hello,"world");
				});
			});
		});
	});
};
specs.AsyncSpec.__name__ = true;
specs.Timer = function() { }
specs.Timer.__name__ = true;
specs.Timer.delay = function(f,delayMs) {
	if(typeof setTimeout === 'undefined') window.setTimeout(f,delayMs); else setTimeout(f,delayMs);
}
specs.Timer.stamp = function() {
	return haxe.Timer.stamp();
}
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = ["Date"];
if(typeof document != "undefined") js.Lib.document = document;
if(typeof window != "undefined") {
	js.Lib.window = window;
	js.Lib.window.onerror = function(msg,url,line) {
		var f = js.Lib.onerror;
		if(f == null) return false;
		return f(msg,[url + ":" + line]);
	};
}
if(typeof async !== 'undefined') js.async.Async.instance = async; else if(typeof require !== 'undefined') js.async.Async.instance = require('async'); else throw "make sure to include async.js";
if(!(typeof expect === 'undefined')) js.expect.E._expect = expect; else if(!(typeof require === 'undefined')) js.expect.E._expect = require('expect.js'); else throw "make sure to include expect.js";
MainBrowser.main();
})();

//@ sourceMappingURL=async-test-browser.js.map