/**
 * Created by Alexander "Foo 'The Man' Choo" Syed (a.k.a. Captain Fantastic) 
 */

package org.pixelami.arsebackwards.processes
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	
	public class ProcessDescriptor
	{
		private var _target:IEventDispatcher;
		
		
		
		public function get target():IEventDispatcher
		{
			return _target;
		}
		
		public function set target(value:IEventDispatcher):void
		{
			_target = value;
		}
		
		
		/**
		 * The Event type that signifies the task completed successfully
		 */
		public var successEventType:String;
		
		/**
		 * The Event type that signifies the task failed
		 */
		public var failureEventType:String;
		
		/**
		 * A flag to specify whether the Step should fail completely is this Action fails
		 */
		public var breakOnFailure:Boolean;
		
		/**
		 * The metthod name that starts the task
		 */
		public var runMethodName:String;
		
		
		
		
		
		public var status:uint;
		public var lastExecutionDuration:uint;
		public var priority:uint;
		public var cyclesPerRun:uint;
		
		public function ProcessDescriptor(target:IEventDispatcher,priority:uint=0,cyclesPerRun:uint = 1000,breakOnFailure:Boolean=false,
								successEventType:String=Event.COMPLETE,failureEventType:String=ErrorEvent.ERROR,
								runMethodName:String="run")
		{
			
			this.target = target;
			this.breakOnFailure = breakOnFailure;
			this.successEventType = successEventType;
			this.failureEventType = failureEventType;
			this.runMethodName = runMethodName;
			
			this.priority = priority;
			this.cyclesPerRun = cyclesPerRun;
			
			
		}
		
		public function get process():AbstractProcess
		{
			return target as AbstractProcess;
		}
	}
}