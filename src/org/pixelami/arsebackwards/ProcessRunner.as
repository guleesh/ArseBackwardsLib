/**
 * Created by Alexander "Foo 'The Man' Choo" Syed (a.k.a. Captain Fantastic) 
 */

package org.pixelami.arsebackwards
{
	import flash.display.DisplayObject;
	import flash.display.FrameLabel;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.sampler.getSize;
	import flash.utils.getTimer;
	import org.pixelami.arsebackwards.processes.ProcessDescriptor;
	import org.pixelami.arsebackwards.processes.ProcessStatus;
	
	
	public class ProcessRunner extends EventDispatcher
	{
		private static var _target:DisplayObject;
		
		private var activeProcess:ProcessDescriptor;
		
		private var _running:Boolean;
		private var _empty:Boolean;
		private var _suspended:Boolean;
		
		private var _startTime:Number;
		private var _fps:Number;
		private var _frameCount:uint;
		
		private var lastFrameTime:uint;
		private var frameExecutionTime:int;
		
		
		// TODO calculate this on-the-fly based on FPS;
		private var maxFrameExecutionTime:int = 12;
		
		public var model:Object;
		
		public static function Initialise(target:DisplayObject):void
		{
			_target = target;
			
			
		}
		
		private var _processes:Vector.<ProcessDescriptor>;
		
		
		public static function get target():DisplayObject
		{
			return _target;
		}

		public static function set target(value:DisplayObject):void
		{
			_target = value;
		}

		public function get fps():Number
		{
			return _fps;
		}

		public function set fps(value:Number):void
		{
			_fps = value;
		}

		public function get processes():Vector.<ProcessDescriptor>
		{
			return _processes;
		}

		public function set processes(value:Vector.<ProcessDescriptor>):void
		{
			_processes = value;
		}
		
		
		
		public function get startTime():Number
		{
			return _startTime;
		}

		public function get frameCount():uint
		{
			return _frameCount;
		}


		
		public function isRunning():Boolean
		{
			return _running;
		}
		
		public function isSuspended():Boolean
		{
			return _suspended;
		}
		
		public function isEmpty():Boolean
		{
			return processes.length == 0 ;
		}
		
		public function ProcessRunner()
		{
			super(null);
			_startTime = getTimer();
			lastFrameTime = _startTime;
			processes = new Vector.<ProcessDescriptor>();
			run();
		}
		
		protected function processSorter(p1:ProcessDescriptor,p2:ProcessDescriptor):int
		{
			if(p1.priority > p2.priority) return -1;
			else if(p1.priority < p2.priority) return 1;
			return 0;
		}
		
		public function addProcess(process:ProcessDescriptor):void
		{
			processes.push(process);
			processes.sort(processSorter);
			
			if(!isRunning())
			{
				run();
			}
			
		}
		
		public function removeProcess(process:ProcessDescriptor):void
		{
			processes.splice(processes.indexOf(process),1);
		}
		
		//var frames
		protected function OnEnterFrame(event:Event):void
		{
			var now:uint = getTimer();
			_frameCount ++;
			//trace("now:"+now);
			var frameElapsedTime:Number = now - lastFrameTime;
			
			if(frameElapsedTime >=  1000)
			{
				fps = _frameCount / frameElapsedTime * 1000;
				_frameCount = 0;
				lastFrameTime = now;
				updateInfo();
			}
			
			
			
			
			processFrame();
		}
		
		protected function processFrame():void
		{
			if(isEmpty())
			{
				stop();
				return;
			}
			
			frameExecutionTime = 0;
			var process:ProcessDescriptor;
			
			for each(process in processes)
			{
				// skip item if we are over the maxExecutionTime
				if(process.priority < 20 && frameExecutionTime > maxFrameExecutionTime) continue;
				
				var processStart:int = getTimer();
				process.process.cycles = process.cyclesPerRun;
				process.status = process.target[process.runMethodName]();
				var processDuration:int = getTimer() - processStart;
				process.lastExecutionDuration = processDuration
				trace("executed in: "+process.lastExecutionDuration);
				frameExecutionTime += processDuration;
				
				
				
				switch(process.status)
				{
					case ProcessStatus.COMPLETE: handleProcessComplete(process); break;
					
					case ProcessStatus.CONTINUE: handleProcessContinue(process); break;
					
					case ProcessStatus.PENDING: handleProcessPending(process); break;
					
					case ProcessStatus.ERROR: handleProcessError(process); break;
				}
			}
			
			
		}
		
		protected function stop():void
		{
			_target.removeEventListener(Event.ENTER_FRAME,OnEnterFrame);
			_running = false;
		}
		
		protected function run():void
		{
			if(!isSuspended())
			{
				_target.addEventListener(Event.ENTER_FRAME,OnEnterFrame);
				_running = true;
			}
		}
		
		public function suspend():void
		{
			_suspended = true;
		}
		
		
		protected function updateInfo():void
		{
			model.text = "FPS: "+fps+" , Processes: "+processes.length;
		}
		
		
		protected function handleProcessComplete(process:ProcessDescriptor):void
		{
			// remove and dispatch completeEvent.
			removeProcess(process)
			
		}
		protected function handleProcessContinue(process:ProcessDescriptor):void
		{
			var slice:Number = maxFrameExecutionTime / processes.length;
			if(process.lastExecutionDuration > slice)
			{
				var currentMsPerCycle:Number = process.lastExecutionDuration / process.cyclesPerRun;
				trace("currentMsPerCycle: "+currentMsPerCycle);
				process.cyclesPerRun = slice / currentMsPerCycle;
				trace("*** adjusted cycles: "+process.cyclesPerRun);
			}
			else
			{
				process.cyclesPerRun += 16;
			}
		}
		protected function handleProcessPending(process:ProcessDescriptor):void
		{
			// move to process pending queue
		}
		protected function handleProcessError(process:ProcessDescriptor):void
		{
			//clear from processes and dispatch Error.
		}
	}
}