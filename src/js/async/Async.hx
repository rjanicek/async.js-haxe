package js.async;

/**
 * async.js bindings
 * @author Richard Janicek
 */
class Async {

	public static var instance : AsyncExtern;

	static function __init__() untyped {
		if (__js__("typeof async !== 'undefined'"))
			instance = __js__("async");
		else if (__js__("typeof require !== 'undefined'"))
			instance = __js__("require('async')");
		else
			throw "make sure to include async.js";
	}
	
}

extern class AsyncExtern {
	
	// ------------------------------------------------------------------------
	// Collections

	/**
	 * Applies an iterator function to each item in an array, in parallel. The
	 * iterator is called with an item from the list and a callback for when it
	 * has finished. If the iterator passes an error to this callback, the main
	 * callback for the forEach function is immediately called with the error.
	 * Note, that since this function applies the iterator to each item in
	 * parallel there is no guarantee that the iterator functions will complete
	 * in order.
	 *
	 * @param arr An array to iterate over.
	 *
	 * @param iterator(item,callback())
	 *		A function to apply to each item in the array. The iterator is
	 *		passed a callback which must be called once it has completed.
	 *
	 * @param cb(err)
	 *		A callback which is called after all the iterator functions have
	 *		finished, or an error has occurred.
	 */
	public function forEach<T>( arr : Array<T>, iterator : T->(Void->Void)->Void, cb : Null<Dynamic>->Void ) : Void;

	/**
	 * The same as forEach only the iterator is applied to each item in the
	 * array in series. The next iterator is only called once the current one
	 * has completed processing. This means the iterator functions will
	 * complete in order.
	 *
 	 * arr 	An array to iterate over.
 	 *
	 * @param iterator(item,callback())
	 * 		A function to apply to each item in the array. The iterator is
	 * 		passed a callback which must be called once it has completed.
	 *
	 * @param cb(err)
	 * 		A callback which is called after all the iterator functions
	 * 		have finished, or an error has occurred.
	 */
	public function forEachSeries<T>( arr : Array<T>, iterator : T->(Void->Void)->Void, cb : Null<Dynamic>->Void ) : Void;

	/**
	 * The same as forEach only the iterator is applied to batches of items in
	 * the array, in series. The next batch of iterators is only called once
	 * the current one has completed processing.
	 *
	 * arr 		An array to iterate over.
	 *
	 * limit 	How many items should be in each batch.
	 *
	 * iterator(item, callback())
	 *			A function to apply to each item in the array. The iterator
	 *			is passed a callback which must be called once it has
	 *			completed.
	 *
	 * cb(err)
	 *			A callback which is called after all the iterator functions
	 *			have finished, or an error has occurred.
	 */
	public function forEachLimit<T>( arr : Array<T>, limit : Int, iterator : T->(Void->Void)->Void, cb : Null<Dynamic>->Void ) : Void;
	
	/**
	 * Produces a new array of values by mapping each value in the given array
	 * through the iterator function. The iterator is called with an item from
	 * the array and a callback for when it has finished processing. The
	 * callback takes 2 arguments, an error and the transformed item from the
	 * array. If the iterator passes an error to this callback, the main
	 * callback for the map function is immediately called with the error.
	 *
	 * arr 	An array to iterate over.
	 *
	 * iterator(item, callback(error, transformed item))
	 * 		A function to apply to each item in the array. The iterator is
	 * 		passed a callback which must be called once it has completed
	 * 		with an error (which can be null) and a transformed item.
	 *
	 * cb(err, results)
	 * 		A callback which is called after all the iterator functions
	 * 		have finished, or an error has occurred. Results is an array of
	 * 		the transformed items from the original array.
	 */
	public function map<T>( arr : Array<T>, iterator : T->(Null<Dynamic>->T->Void)->Void, cb : Null<Dynamic>->Array<T>->Void ) : Void;
	
	/**
	 * The same as map only the iterator is applied to each item in the array
	 * in series. The next iterator is only called once the current one has
	 * completed processing. The results array will be in the same order as
	 * the original.
	 *
	 * arr 	An array to iterate over.
	 *
	 * iterator(item, callback(error, transformed item))
	 * 		A function to apply to each item in the array. The iterator is
	 * 		passed a callback which must be called once it has completed
	 * 		with an error (which can be null) and a transformed item.
	 *
	 * cb(err, results)
	 * 		A callback which is called after all the iterator functions
	 * 		have finished, or an error has occurred. Results is an array of
	 * 		the transformed items from the original array.
	 */
	public function mapSeries<T>( arr : Array<T>, iterator : T->(Null<Dynamic>->T->Void)->Void, cb : Null<Dynamic>->Array<T>->Void ) : Void;

	/**
	 * Returns a new array of all the values which pass an async truth test.
	 * The callback for each iterator call only accepts a single argument of
	 * true or false, it does not accept an error argument first! This is in-
	 * line with the way node libraries work with truth tests like
	 * path.exists. This operation is performed in parallel, but the results
	 * array will be in the same order as the original.
	 *
	 * arr	An array to iterate over.
	 *
	 * iterator(item, callback(truth))
	 * 		A truth test to apply to each item in the array. The iterator
	 * 		is passed a callback which must be called with a boolean
	 * 		argument once it has completed.
	 *
	 * cb(results)
	 *		A callback which is called after all the iterator functions
	 * 		have finished.
	 */
	public function filter<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Array<T>->Void ) : Void;
	public function select<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Array<T>->Void ) : Void;

	/**
	 * The same as filter only the iterator is applied to each item in the
	 * array in series. The next iterator is only called once the current one
	 * has completed processing. The results array will be in the same order
	 * as the original.
	 *
	 * arr 	An array to iterate over.
	 *
	 * iterator(item, callback(truth))
	 *		A truth test to apply to each item in the array. The iterator is
	 *		passed a callback which must be called with a boolean argument
	 *		once it has completed.
	 *
	 * cb(results)
	 *		A callback which is called after all the iterator functions have
	 *		finished.
	 */
	public function filterSeries<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Array<T>->Void ) : Void;
	public function selectSeries<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Array<T>->Void ) : Void;

	/**
	 * Returns a new array of all the values which pass an async truth test
	 * removed. The callback for each iterator call only accepts a single
	 * argument of true or false, it does not accept an error argument first!
	 * This is in-line with the way node libraries work with truth tests like
	 * path.exists. This operation is performed in parallel, but the results
	 * array will be in the same order as the original.
	 *
	 * arr 	An array to iterate over.
	 *
	 * iterator(item, callback(item, callback(truth)))
	 * 		A truth test to apply to each item in the array. The iterator
	 * 		is passed a callback which must be called with a boolean
	 * 		argument once it has completed.
	 *
	 * cb(results)
	 * 		A callback which is called after all the iterator functions
	 * 		have finished.
	 */
	public function reject<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Array<T>->Void ) : Void;

	/**
	 * Returns a new array of all the values which pass an async truth test
	 * removed in series. The callback for each iterator call only accepts a
	 * single argument of true or false, it does not accept an error argument
	 * first! This is in-line with the way node libraries work with truth
	 * tests like path.exists. This operation is performed in parallel, but
	 * the results array will be in the same order as the original.
	 *
	 * arr 	An array to iterate over.
	 *
	 * iterator(item, callback(item, callback(truth)))
	 * 		A truth test to apply to each item in the array. The iterator
	 * 		is passed a callback which must be called with a boolean
	 * 		argument once it has completed.
	 *
	 * cb(results)
	 * 		A callback which is called after all the iterator functions
	 * 		have finished.
	 */
	public function rejectSeries<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Array<T>->Void ) : Void;

	/**
	 * Reduces a list of values into a single value using an async iterator to
	 * return each successive step. Memo is the initial state of the
	 * reduction. This function only operates in series. For performance
	 * reasons, it may make sense to split a call to this function into a
	 * parallel map, then use the normal Array.prototype.reduce on the
	 * results. This function is for situations where each step in the
	 * reduction needs to be async, if you can get the data before reducing it
	 * then its probably a good idea to do so.
	 *
	 * arr 	An array to iterate over.
	 *
	 * memo The initial state of the reduction.
	 *
	 * iterator(memo, item, callback(?error, state))
	 * 		A function applied to each item in the array to produce the
	 * 		next step in the reduction. The iterator is passed a callback
	 * 		which accepts an optional error as its first argument, and the
	 * 		state of the reduction as the second. If an error is passed to
	 * 		the callback, the reduction is stopped and the main callback is
	 * 		immediately called with the error.
	 *
	 * callback(err, result)
	 *		A callback which is called after all the iterator functions have
	 *		finished. Result is the reduced value.
	 */
	public function reduce<T>( arr : Array<T>, memo : T, iterator : T->T->(Null<Dynamic>->T->Void)->Void, cb : Null<Dynamic>->T->Void ) : Void;
	public function inject<T>( arr : Array<T>, memo : T, iterator : T->T->(Null<Dynamic>->T->Void)->Void, cb : Null<Dynamic>->T->Void ) : Void;
	public function foldl<T>( arr : Array<T>, memo : T, iterator : T->T->(Null<Dynamic>->T->Void)->Void, cb : Null<Dynamic>->T->Void ) : Void;

	/**
	 * Same as reduce(), only operates on the items in the array in reverse
	 * order.
	 */
	public function reduceRight<T>( arr : Array<T>, memo : T, iterator : T->T->(Null<Dynamic>->T->Void)->Void, cb : Null<Dynamic>->T->Void ) : Void;
	public function foldr<T>( arr : Array<T>, memo : T, iterator : T->T->(Null<Dynamic>->T->Void)->Void, cb : Null<Dynamic>->T->Void ) : Void;

	/**
	 * Returns the first value in a list that passes an async truth test. The
	 * iterator is applied in parallel, meaning the first iterator to return
	 * true will fire the detect callback with that result. That means the
	 * result might not be the first item in the original array (in terms of
	 * order) that passes the test.
	 *
	 * If order within the original array is important then look at detectSeries.
	 *
	 * arr 	An array to iterate over.
	 *
	 * iterator(item, callback(truth))
	 * 		A truth test to apply to each item in the array. The iterator
	 * 		is passed a callback which must be called once it has
	 * 		completed.
	 *
	 * cb(result)
	 * 		A callback which is called as soon as any iterator returns
	 * 		true, or after all the iterator functions have finished. Result
	 * 		will be the first item in the array that passes the truth test
	 * 		(iterator) or the value undefined if none passed.
	 */
	public function detect<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Null<T>->Void ) : Void;

	/**
	 * The same as detect, only the iterator is applied to each item in the
	 * array in series. This means the result is always the first in the
	 * original array (in terms of array order) that passes the truth test.
	 */
	public function detectSeries<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Null<T>->Void ) : Void;

	/**
	 * Sorts a list by the results of running each value through an async
	 * iterator.
	 *
	 * arr 	An array to iterate over.
	 *
	 * iterator(item, callback(error, value))
	 * 		A function to apply to each item in the array. The iterator is
	 * 		passed a callback which must be called once it has completed
	 * 		with an error (which can be null) and a value to use as the
	 * 		sort criteria.
	 *
	 * cb(err, results)
	 * 		A callback which is called after all the iterator functions
	 * 		have finished, or an error has occurred. Results is the items
	 * 		from the original array sorted by the values returned by the
	 * 		iterator calls.
	 */
	public function sortBy<T>( arr : Array<T>, iterator : T->(Null<Dynamic>->Dynamic->Void)->Void, cb : Null<Dynamic>->Array<T>->Void ) : Void;

	/**
	 * Returns true if at least one element in the array satisfies an async
	 * test. The callback for each iterator call only accepts a single
	 * argument of true or false, it does not accept an error argument first!
	 * This is in-line with the way node libraries work with truth tests like
	 * path.exists. Once any iterator call returns true, the main callback is
	 * immediately called.
	 *
	 * arr 	An array to iterate over.
	 *
	 * iterator(item, callback(truth))
	 * 		A truth test to apply to each item in the array. The iterator
	 * 		is passed a callback which must be called once it has
	 * 		completed.
	 *
	 * callback(result)
	 * 		A callback which is called as soon as any iterator returns
	 * 		true, or after all the iterator functions have finished. Result
	 * 		will be either true or false depending on the values of the
	 * 		async tests.
	 */
	public function some<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Bool->Void ) : Void;
	public function any<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Bool->Void ) : Void;

	/**
	 * Returns true if every element in the array satisfies an async test. The
	 * callback for each iterator call only accepts a single argument of true
	 * or false, it does not accept an error argument first! This is in-line
	 * with the way node libraries work with truth tests like path.exists.
	 *
	 * arr 	An array to iterate over.
	 *
	 * iterator(item, callback(truth))
	 * 		A truth test to apply to each item in the array. The iterator
	 * 		is passed a callback which must be called once it has
	 * 		completed.
	 *
	 * cb(result)
	 * 		A callback which is called after all the iterator functions
	 * 		have finished. Result will be either true or false depending on
	 * 		the values of the async tests.
	 */
	public function every<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Bool->Void) : Void;
	public function all<T>( arr : Array<T>, iterator : T->(Bool->Void)->Void, cb : Bool->Void) : Void;

	/**
	 * Applies an iterator to each item in a list, concatenating the results.
	 * Returns the concatenated list. The iterators are called in parallel,
	 * and the results are concatenated as they return. There is no guarantee
	 * that the results array will be returned in the original order of the
	 * arguments passed to the iterator function.
	 *
	 * arr 	An array to iterate over.
	 *
	 * iterator(item, callback(error, results))
	 * 		A function to apply to each item in the array. The iterator is
	 * 		passed a callback which must be called once it has completed
	 * 		with an error (which can be null) and an array of results.
	 *
	 * callback(err, results)
	 * 		A callback which is called after all the iterator functions
	 * 		have finished, or an error has occurred. Results is an array
	 * 		containing the concatenated results of the iterator function.
	 */
	public function concat<T>( arr : Array<T>, iterator : T->(Null<Dynamic>->Array<Dynamic>->Void)->Void, cb : Null<Dynamic>->Array<T>->Void ) : Void;

	/**
	 * Same as concat(), but executes in series instead of parallel.
	 */
	public function concatSeries<T>( arr : Array<T>, iterator : T->(Null<Dynamic>->Array<Dynamic>->Void)->Void, cb : Null<Dynamic>->Array<T>->Void ) : Void;

	// ------------------------------------------------------------------------
	// Control Flow
	
	/**
	 * Run an array of functions in series, each one running once the previous
	 * function has completed. If any functions in the series pass an error to
	 * its callback, no more functions are run and the callback for the series
	 * is immediately called with the value of the error. Once the tasks have
	 * completed, the results are passed to the final callback as an array.
	 *
	 * It is also possible to use an object instead of an array. Each property
	 * will be run as a function and the results will be passed to the final
	 * callback as an object instead of an array. This can be a more readable
	 * way of handling results from async.series.
	 *
	 * tasks[ function(callback(error, result)){},... ]
	 * tasks{ funk: function(callback(error, result)){},...}
	 *		An array or object containing functions to run, each function is
	 *		passed a callback it must call on completion.
	 *
	 * callback(err, results)
	 * 		An optional callback to run once all the functions have
	 * 		completed. This function gets an array of all the arguments
	 * 		passed to the callbacks used in the array.
	 */
	@:overload(function( tasks : {}, ?cb : Null<Dynamic>->Array<Dynamic>->Void ) : Void {})
	public function series( tasks : Array<(Null<Dynamic>->Null<Dynamic>->Void)->Void>, ?cb : Null<Dynamic>->Array<Dynamic>->Void ) : Void;
	
	/**
	 * Run an array of functions in parallel, without waiting until the
	 * previous function has completed. If any of the functions pass an error
	 * to its callback, the main callback is immediately called with the value
	 * of the error. Once the tasks have completed, the results are passed to
	 * the final callback as an array.
	 *
	 * It is also possible to use an object instead of an array. Each property
	 * will be run as a function and the results will be passed to the final
	 * callback as an object instead of an array. This can be a more readable
	 * way of handling results from async.parallel.
	 *
	 * tasks[ function(callback(error, result)){},... ]
	 * tasks{ funk: function(callback(error, result)){},...}
	 *		An array or object containing functions to run, each function is
	 *		passed a callback it must call on completion.
	 *
	 * cb(err, results)
	 *		An optional callback to run once all the functions have
	 *		completed. This function gets an array of all the arguments
	 *		passed to the callbacks used in the array.
	 */
	@:overload(function(tasks : {}, ?cb : Null<Dynamic>->Array<Dynamic>->Void) : Void {})
	public function parallel( tasks : Array<(Null<Dynamic>->Dynamic->Void)->Void>, ?cb : Null<Dynamic>->Array<Dynamic>->Void ) : Void;
	
	/**
	 * Repeatedly call fn, while test returns true. Calls the callback when
	 * stopped, or an error occurs.
	 *
	 * test() 	synchronous truth test to perform before each execution of fn.
	 *
	 * fn(callback(err))
	 *			A function to call each time the test passes. The function
	 *			is passed a callback which must be called once it has
	 *			completed with an optional error as the first argument.
	 *
	 * cb(err)
	 *			A callback which is called after the test fails and repeated
	 *			execution of fn has stopped.
	 */
	public function whilst( test : Void->Bool, fn : (Null<Dynamic>->Void)->Void, cb : Null<Dynamic>->Void ) : Void;
	
	/**
	 * Repeatedly call fn, until test returns true. Calls the callback when
	 * stopped, or an error occurs.
	 *
	 * The inverse of async.whilst().
	 */
	public function until( test : Void->Bool, fn : (Null<Dynamic>->Void)->Void, cb : Null<Dynamic>->Void ) : Void;
	
	/**
	 * Runs an array of functions in series, each passing their results to the
	 * next in the array. However, if any of the functions pass an error to
	 * the callback, the next function is not executed and the main callback
	 * is immediately called with the error.
	 *
	 * tasks
	 *		An array of functions to run, each function is passed a callback
	 *		it must call on completion.
	 *
	 * callback(err, [results])
	 *		An optional callback to run once all the functions have
	 *		completed. This will be passed the results of the last task's
	 *		callback.
	 */
	public function waterfall( tasks : Array<Dynamic>, ?cb : Null<Dynamic>->Dynamic->Void ) : Void;
	
	/**
	 * Creates a queue object with the specified concurrency. Tasks added to
	 * the queue will be processed in parallel (up to the concurrency limit).
	 * If all workers are in progress, the task is queued until one is
	 * available. Once a worker has completed a task, the task's callback is
	 * called.
	 *
	 * worker(task, callback())
	 *		An asynchronous function for processing a queued task.
	 *
	 * concurrency
	 *		An integer for determining how many worker functions should be
	 *		run in parallel.
	 */
	public function queue<T>( worker : T->(Dynamic->Dynamic->Void)->Void, concurrency : Int ) : Queue<T>;
	
	/**
	 * Determines the best order for running functions based on their
	 * requirements. Each function can optionally depend on other functions
	 * being completed first, and each function is run as soon as its
	 * requirements are satisfied. If any of the functions pass an error to
	 * their callback, that function will not complete (so any other functions
	 * depending on it will not run) and the main callback will be called
	 * immediately with the error. Functions also receive an object containing
	 * the results of functions which have completed so far.
	 *
	 * tasks
	 *		An object literal containing named functions or an array of
	 *		requirements, with the function itself the last item in the
	 *		array. The key used for each function or array is used when
	 *		specifying requirements. The syntax is easier to understand by
	 *		looking at the example.
	 *
	 * callback(err, results)
	 *		An optional callback which is called when all the tasks have
	 *		been completed. The callback will receive an error as an
	 *		argument if any tasks pass an error to their callback. If all
	 *		tasks complete successfully, it will receive an object
	 *		containing their results.
	 */
	public function auto( tasks : {}, ?cb : Null<Dynamic>->Dynamic->Void ) : Void;
	
	/**
	 * Creates an iterator function which calls the next function in the
	 * array, returning a continuation to call the next one after that. Its
	 * also possible to 'peek' the next iterator by doing iterator.next().
	 *
	 * This function is used internally by the async module but can be useful
	 * when you want to manually control the flow of functions in series.
	 *
	 * tasks
	 *		An array of functions to run, each function is passed a callback
	 *		it must call on completion.
	 */
	public function iterator( tasks : Array <Void->Void> ) : Dynamic;

	/**
	 * Creates a continuation function with some arguments already applied, a
	 * useful shorthand when combined with other control flow functions. Any
	 * arguments passed to the returned function are added to the arguments
	 * originally passed to apply.
	 *
	 * fn 	The function you want to eventually apply all arguments to.
	 *
	 * arg
	 *		Any number of arguments to automatically apply when the
	 *		continuation is called.
	 */
	public function apply(fn : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic ) : Dynamic;
	
	/**
	 * Calls the callback on a later loop around the event loop. In node.js
	 * this just calls process.nextTick, in the browser it falls back to
	 * setTimeout(callback, 0), which means other higher priority events may
	 * precede the execution of the callback.
	 *
	 * This is used internally for browser-compatibility purposes.
	 *
	 * cb() 	The function to call on a later loop around the event loop.
	 */
	public function nextTick( cb : Void->Void ) : Void;
	
	// ------------------------------------------------------------------------
	// Utils
	
	/**
	 * Caches the results of an async function. When creating a hash to store
	 * function results against, the callback is omitted from the hash and an
	 * optional hash function can be used.
	 *
	 * fn 	The function you to proxy and cache results from.
	 *
	 * hasher
	 *		An optional function for generating a custom hash for storing
	 *		results, it has all the arguments applied to it apart from the
	 *		callback, and must be synchronous.
	 */
	public function memoize(fn : Dynamic, ?hasher : Dynamic) : Dynamic;
	
	/**
	 * Undoes a memoized function, reverting it to the original, unmemoized
	 * form. Comes handy in tests.
	 *
	 * fn 	The memoized function.
	 */
	public function unmemoize( fn : Dynamic ) : Void;
	
	/**
	 * Logs the result of an async function to the console. Only works in
	 * node.js or in browsers that support console.log and console.error (such
	 * as FF and Chrome). If multiple arguments are returned from the async
	 * function, console.log is called on each argument in order.
	 *
	 * fn 	The function you want to eventually apply all arguments to.
	 *
	 * arg 	Any number of arguments to apply to the function.
	 */
	public function log( fn : Dynamic, arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic ) : Void;
	
	/**
	 * Logs the result of an async function to the console using console.dir
	 * to display the properties of the resulting object. Only works in
	 * node.js or in browsers that support console.dir and console.error (such
	 * as FF and Chrome). If multiple arguments are returned from the async
	 * function, console.dir is called on each argument in order.
	 *
	 * fn 	The function you want to eventually apply all arguments to.
	 *
	 * arg 	Any number of arguments to apply to the function.
	 */
	public function dir( fn : Dynamic, arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic, ?arg : Dynamic ) : Void;
	
	/**
	 * Changes the value of async back to its original value, returning a
	 * reference to the async object.
	 */
	public function noConflict() : Void;
}

/**
 * The queue object returned Async.queue().
 */
typedef Queue<T> = {
	
	/**
	 * A function returning the number of items waiting to be processed.
	 */
	function length() : Int;
	
	/**
	 * An integer for determining how many worker functions should be run in
	 * parallel. This property can be changed after a queue is created to
	 * alter the concurrency on-the-fly.
	 */
	var concurrency(default, default) : Int;
	
	/**
	 * Add a new task to the queue, the callback is called once the worker has
	 * finished processing the task. instead of a single task, an array of
	 * tasks can be submitted. the respective callback is used for every task
	 * in the list.
	 */
	@:overload(function( tasks : Array<Dynamic>, ?cb : Dynamic->Void ) : Void{})
	function push( task : T, ?cb : Dynamic->Void ) : Void;
	
	/**
	 * A callback that is called when the queue length hits the concurrency
	 * and further tasks will be queued.
	 */
	var saturated(default, default) : Void->Void;
	
	/**
	 * A callback that is called when the last item from the queue is given to
	 * a worker.
	 */
	var empty(default, default) : Void->Void;
	
	/**
	 * A callback that is called when the last item from the queue has
	 * returned from the worker.
	 */
	var drain(default, default) : Void->Void;
	
}