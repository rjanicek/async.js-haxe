package specs;

import js.Async;
import js.expect.Expect;
import js.mocha.Mocha;

using js.expect.Expect;
using Std;

/**
 * ...
 * @author Richard Janicek
 */
class AsyncSpec {

	public function new() {
		var async = Async.instance;
		M.describe("Async", function() {
			
			M.describe("Collections", function() {
				
				M.describe("#forEach()", function() {
					M.it("sould iterate an array in parallel", function(done) {
						var count = 0;
						async.forEach(["one", "two"], function(element, ret) {
							element.should().be.a("string");
							count++;
							ret();
						}, function(error) { 
							count.should().equal(2);
							done();
						});
					});
				});
				
				M.describe("#forEachSeries()", function() {
					M.it("sould iterate an array in series", function(done) {
						var one = false;
						var two = false;
						async.forEachSeries(["one", "two"], function(element, ret) {
							switch (element) {
								case "one":
									two.should().not.be.ok();
									one = true;
								case "two":
									one.should().be.ok();
									two = true;
							}
							ret();
						}, function(error) { 
							one.should().be.ok();
							two.should().be.ok();
							done();
						});
					});
				});
				
				M.describe("#forEachLimit()", function() {
					M.it("sould iterate an array in batches in series", function(done) {
						var batch1 = false;
						var batch2 = false;
						async.forEachLimit([1, 2, 3, 4], 2, function(element, ret) {
							switch (element) {
								case 1, 2:
									batch2.should().not.be.ok();
									batch1 = true;
								case 3, 4:
									batch1.should().be.ok();
									batch2 = true;
							}
							ret();
						}, function(error) { 
							batch1.should().be.ok();
							batch2.should().be.ok();
							done();
						});
					});
				});
				
				M.describe("#map()", function() {
					M.it("should map a function to an array and produce a result array in parallel", function(done) {
						async.map([1, 2, 3], function(element, ret) {
							ret(null, -element);
						}, function(error, results) {
							results.should().eql([ -1, -2, -3]);
							done();
						});
					});
				});
				
				M.describe("#mapSeries()", function() {
					M.it("should map a function to an array and produce a result array in series", function(done) {
						var called = [false, false, false];
						async.mapSeries([0, 1, 2], function(element, ret) {
							called[element] = true;
							switch (element) {
								case 0: called.should().eql([true, false, false]);
								case 1: called.should().eql([true, true, false]);
								case 2: called.should().eql([true, true, true]);
							}
							ret(null, element * element);
						}, function(error, results) {
							results.should().eql([ 0, 1, 4]);
							done();
						});
					});
				});
				
				M.describe("#filter()", function() {
					M.it("should filter array items in parallel", function(done) {
						var startSeconds = Timer.stamp();
						async.filter([1, 2, 3, 4, 5], function(item, ret) {
							Timer.delay(function() {
								ret(item %2 == 0);
							}, item * 100);
						}, function(results) {
							(Timer.stamp() - startSeconds).should().be.lessThan(0.6);
							results.should()
								.not.contain(1)	
								.and.contain(2)
								.and.not.contain(3)
								.and.contain(4)
								.and.not.contain(5);
							done();
						});
					});
				});
				
				M.describe("#filterSeries()", function() {
					M.it("should filter array items in series", function(done) {
						var startSeconds = Timer.stamp();
						async.filterSeries([1, 2, 3], function(item, ret) {
							Timer.delay(function() {
								ret(item %2 == 0);
							}, item * 100);
						}, function(results) {
							(Timer.stamp() - startSeconds).should().be.lessThan((1 + 2 + 3 + 1) / 10);
							results.should()
								.not.contain(1)
								.and.contain(2)							
								.and.not.contain(3);
							done();
						});
					});
				});
				
				M.describe("#reject()", function() {
					M.it("should reject array items in parallel", function(done) {
						var startSeconds = Timer.stamp();
						async.reject([1, 2, 3, 4, 5], function(item, ret) {
							Timer.delay(function() {
								ret(item %2 == 0);
							}, item * 100);
						}, function(results) {
							(Timer.stamp() - startSeconds).should().be.lessThan(0.6);
							results.should()
								.contain(1)
								.and.not.contain(2)
								.and.contain(3)
								.and.not.contain(4)
								.and.contain(5);
							done();
						});
					});
				});
				
				M.describe("#rejectSeries()", function() {
					M.it("should filter array items in series", function(done) {
						var startSeconds = Timer.stamp();
						async.rejectSeries([1, 2, 3], function(item, ret) {
							Timer.delay(function() {
								ret(item %2 == 0);
							}, item * 100);
						}, function(results) {
							(Timer.stamp() - startSeconds).should().be.lessThan((1 + 2 + 3 + 1) / 10);
							results.should()
								.contain(1)
								.and.not.contain(2)							
								.and.contain(3);
							done();
						});
					});
				});
				
				M.describe("#reduce()", function() {
					M.it("should reduce array values into a single value", function(done) {
						async.reduce(["1","2","3"], "0", function(memo, item, cb) {
							async.nextTick(function () {
								cb(null, memo + item);
							});
						}, function(error, result) {
							result.should().equal("0123");
							done();
						});
					});
				});
				
				M.describe("#reduceRight()", function() {
					M.it("should reduce array values in reverse order into a single value", function(done) {
						async.reduceRight(["1","2","3"], "0", function(memo, item, cb) {
							async.nextTick(function () {
								cb(null, memo + item);
							});
						}, function(error, result) {
							result.should().equal("0321");
							done();
						});
					});
				});
				
				M.describe("#detect()", function() {
					M.it("should return the first value in a list that passes an async truth test", function(done) {
						async.detect(["truth","lie","truth"], function(item, ret) {
							async.nextTick(function () {
								ret(item == "lie");
							});
						}, function(result) {
							result.should().equal("lie");
							done();
						});
					});
				});
				
				M.describe("#detectSeries()", function() {
					M.it("should return the first value in a list that passes an async truth test in series", function(done) {
						async.detectSeries(["truth","lie","truth"], function(item, ret) {
							async.nextTick(function () {
								ret(item == "lie");
							});
						}, function(result) {
							result.should().equal("lie");
							done();
						});
					});
				});
				
				M.describe("#sortBy()", function() {
					M.it("should sorts a list by the results of running each value through an async iterator", function(done) {
						async.sortBy([3,2,1], function(item, ret) {
							async.nextTick(function () {
								ret(null, item);
							});
						}, function(err, results) {
							results.should().eql([1,2,3]);
							done();
						});
					});
				});
				
				M.describe("#some()", function() {
					M.it("should returns true if at least one element in the array satisfies an async test", function(done) {
						async.some([false,true,false], function(item, ret) {
							async.nextTick(function () {
								ret(item);
							});
						}, function(result) {
							result.should().be.ok();
							done();
						});
					});
				});
				
				M.describe("#every()", function() {
					M.it("should eturn true if every element in the array satisfies an async test", function(done) {
						async.every([true,true,true], function(item, ret) {
							async.nextTick(function () {
								ret(item);
							});
						}, function(result) {
							result.should().be.ok();
							done();
						});
					});
				});
				
				M.describe("#concat()", function() {
					M.it("should apply an iterator to each item in a list, concatenating the results.", function(done) {
						async.concat([1,2,3], function(item, ret) {
							async.nextTick(function () {
								ret(null, [item.string()]);
							});
						}, function(err, results) {
							results.should()
								.contain("1")
								.and.contain("2")
								.and.contain("3");
							done();
						});
					});
				});
				
				M.describe("#concatSeries()", function() {
					M.it("should apply an iterator to each item in a list in series, concatenating the results.", function(done) {
						async.concatSeries([1,2,3], function(item, ret) {
							async.nextTick(function () {
								ret(null, [item.string()]);
							});
						}, function(err, results) {
							results.should().eql(["1", "2", "3"]);
							done();
						});
					});
				});
				
			});
			
			M.describe("Control Flow", function() {
				
				M.describe("#series()", function() {
					M.it("should run an array of functions in series", function(done) {
						var one = false;
						var two = false;
						async.series([
							function(ret) {
								Timer.delay(function() {
									one.should().not.be.ok();
									two.should().not.be.ok();
									one = true;
									ret(null, 1);
								}, 100);
							},
							function(ret) {
								Timer.delay(function() {
									one.should().be.ok();
									two.should().not.be.ok();
									two = true;
									ret(null, 2);
								}, 50);
							}
						], function(error, results) {
							results.should().eql([1, 2]);
							done();
						});
					});
					M.it("should run an object of functions in series", function(done) {
						var one = false;
						var two = false;
						async.series({
							one: function(ret) {
								Timer.delay(function() {
									one.should().not.be.ok();
									two.should().not.be.ok();
									one = true;
									ret(null, 1);
								}, 100);
							},
							two: function(ret) {
								Timer.delay(function() {
									one.should().be.ok();
									two.should().not.be.ok();
									two = true;
									ret(null, 2);
								}, 50);
							},
						}, function(error, results) {
							results.should().eql( { one:1, two:2 } );
							done();
						});
					});
				});
				
				M.describe("#parallel()", function() {
					M.it("should run an array of functions in parallel", function(done) {
						var one = false;
						var two = false;
						async.parallel([
							function(ret) {
								Timer.delay(function() {
									two.should().be.ok();
									one = true;
									ret(null, 1);
								}, 100);
							},
							function(ret) {
								Timer.delay(function() {
									one.should().not.be.ok();
									two = true;
									ret(null, 2);
								}, 50);
							}
						], function(error, results) {
							results.should().eql([1, 2]);
							done();
						});
					});
					M.it("should run an object of functions in parallel", function(done) {
						var one = false;
						var two = false;
						async.parallel({
							one: function(ret) {
								Timer.delay(function() {
									two.should().be.ok();
									one = true;
									ret(null, 1);
								}, 100);
							},
							two: function(ret) {
								Timer.delay(function() {
									one.should().not.be.ok();
									two = true;
									ret(null, 2);
								}, 50);
							},
						}, function(error, results) {
							results.should().have.property("one", 1).and.property("two", 2);
							done();
						});
					});
				});
				
				M.describe("#whilst()", function() {
					M.it("should repeatedly call fn, while test returns true", function() {
						var count = 0;
						async.whilst(
							function () { return count < 5; },
							function (cb) {
								async.nextTick(function() {
									count++;
									cb(null); 
								});
							},
							function (err) {
								count.should().equal(5);
							}
						);
					});
				});
				
				M.describe("#until()", function() {
					M.it("should repeatedly call fn, until test returns true", function() {
						var count = 0;
						async.until(
							function () { return count == 5; },
							function (cb) {
								async.nextTick(function() {
									count++;
									cb(null); 
								});
							},
							function (err) {
								count.should().equal(5);
							}
						);
					});
				});
				
				M.describe("#waterfall()", function() {
					M.it("should run an array of functions in series, each passing their results to the next in the array", function() {
						async.waterfall([
							function(ret) {
								ret(null, 1, 2);
							},
							function(arg1, arg2, ret) {
								E.expect(arg1).to.equal(1);
								E.expect(arg2).to.equal(2);
								ret(null, 3);
							},
							function(arg, ret) {
								E.expect(arg).to.equal(3);
								ret(null, "done");
							}
						],
						function(err, result) {
							E.expect(result).to.equal("done");
						});
					});
				});
				
				M.describe("#queue()", function() {
					M.it("should create a queue object", function() {
						var q = async.queue(function(task, ret) { 
						}, 2);
						q.should().be.ok();
					});
					M.it("should process queued task", function(done) {
						
						var accumulator = 0;
						
						var q = async.queue(function(task, ret) { 
							accumulator += task;
							ret();
						}, 2);
						
						var taskDone = false;
						
						q.drain = function () {
							taskDone.should().be.ok();
							accumulator.should().equal(1);
							done();
						};						
						
						q.push(1, function(err) { taskDone = true; } );
					});
					M.it("should process queued array of tasks signaling saturated and empty events", function(done) {
						
						var accumulator = 0;
						
						var q = async.queue(function(task, ret) { 
							trace(task);
							accumulator += task;
							ret();
						}, 2);
						
						var saturated = false;
						q.saturated = function () {
							saturated = true;
						}
						
						var empty = false;
						q.empty = function ():Void {
							empty = true;
						}
						
						q.drain = function () {
							accumulator.should().equal(3);
							saturated.should().be.ok();
							empty.should().be.ok();
							done();
						};						
						
						q.push([1, 1, 1]);
					});
				});
				
				M.describe("#auto()", function() {
					M.it("should determine the best order for running functions based on their requirements", function(done) {
						var f1 = false;
						var f2 = false;
						var f3 = false;
						async.auto( {
							func1: function(ret) {
								Timer.delay(function() {
									f1 = true;
									ret(null, "done");	
								}, 50);
								
							},
							func2: function(ret) {
								f2 = true;
								ret(null, "done");
							},
							func3: ["func1", "func2", function(ret) {
								f3 = true;
								f1.should().be.ok();
								f2.should().be.ok();
								ret(null, "done");
							}]							
						}, function(err, results) {
							f1.should().be.ok();
							f2.should().be.ok();
							f3.should().be.ok();
							E.expect(results).to.have.keys("func1", "func2", "func3");
							done();
						});
					});
				});	
				
				M.describe("#iterator()", function() {
					M.it("should iterate", function(done) {
						var f1 = false;
						var f2 = false;
						var iterator : Dynamic = async.iterator([
							function() { f1 = true;  },
							function() { f2 = true;  }
						]);
						
						while ((iterator = iterator()) != null) { }
						
						f1.should().be.ok();
						f2.should().be.ok();
						done();
					});
				});
				
				M.describe("#apply()", function() {
					M.it("should create a continuation function with some arguments already applied", function(done) {
						async.parallel([
							async.apply(function(arg, ret) { E.expect(arg).to.equal(1); ret(); }, 1)
						], function(err, results) {
							done();
						});
					});
				});
				
				M.describe("#nextTick()", function() {
					M.it("should call the callback on a later loop around the event loop", function(done) {
						var called = false;
						async.nextTick(function() {
							called = true;
							done();
						});
						called.should().not.be.ok();
					});
				});
				
			});
			
			M.describe("Utils", function() {
				
				M.describe("#memoize()", function() {
					M.it("should cache the results of an async function", function(done) {
						var slowCount = 0;
						var slow = function(ret) {
							async.nextTick(function() { 
								slowCount++;
								ret("result");
							} );
						};
						
						var cachedSlow = async.memoize(slow);
						
						async.series([
							function (ret):Void {
								cachedSlow(function(result) {
									E.expect(result).to.equal("result");
									ret(null, null);
								});
							},
							function (ret):Void {
								cachedSlow(function(result) {
									E.expect(result).to.equal("result");
									ret(null, null);
								});
							}
						], function(err, results) {
							slowCount.should().equal(1);
							done();
						});
					});
				});
				
				M.describe("#log()", function() {
					M.it("should log the result of an async function to the console", function() {
						var hello = function(name, ret){
							async.nextTick(function(){
								ret(null, "hello " + name);
							});
						};
						async.log(hello, "world");
					});
				});
				
				M.describe("#dir()", function() {
					M.it("should log the result of an async function to the console using console.dir to display the properties of the resulting object", function() {
						var hello = function(name, ret){
							async.nextTick(function(){
								ret(null, { hello: name } );
							});
						};
						async.dir(hello, "world");
					});
				});
				
			});
		});
	}
	
}