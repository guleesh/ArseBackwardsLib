/**
 * Created by Alexander "Foo 'The Man' Choo" Syed (a.k.a. Captain Fantastic) 
 */

package org.pixelami.arsebackwards.processes
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.pixelami.hercularity.Action;
	
	
	public class ProcessDescriptor extends Action
	{
		public var status:uint;
		public var lastExecutionDuration:uint;
		public var priority:uint;
		public var cyclesPerRun:uint;
		
		public function ProcessDescriptor(target:IEventDispatcher,priority:uint=0,cyclesPerRun:uint = 1000,breakOnFailure:Boolean=false,
								successEventType:String=Event.COMPLETE,failureEventType:String=ErrorEvent.ERROR,
								startMethodName:String="run")
		{
			super(target,breakOnFailure,successEventType,failureEventType,startMethodName);
			this.priority = priority;
			this.cyclesPerRun = cyclesPerRun;
		}
		
		public function get process():AbstractProcess
		{
			return target as AbstractProcess;
		}
	}
}