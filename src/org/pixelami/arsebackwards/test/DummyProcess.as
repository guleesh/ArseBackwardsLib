/**
 * Created by Alexander "Foo 'The Man' Choo" Syed (a.k.a. Captain Fantastic) 
 */

package org.pixelami.arsebackwards.test
{
	
	
	import flash.utils.getTimer;
	
	import org.pixelami.arsebackwards.processes.AbstractProcess;
	import org.pixelami.arsebackwards.processes.ProcessStatus;
	
	public class DummyProcess extends AbstractProcess
	{
		private var durationMS:uint;
		private var endTime:uint;
		
		
		private var started:Boolean;
		
		public function DummyProcess(durationMS:uint=2051)
		{
			super();
			this.durationMS = durationMS;
		}
		
		
		override public function run():uint
		{
			if(!isStarted())
			{
				started = true;
				// set the endTime on first run
				endTime = getTimer() + durationMS;
			}
			trace("DummyProcess PID:"+getPid()+" iteration: "+(runIteration++))
			var now:int = getTimer();
			if(now >= endTime)
			{
				return ProcessStatus.COMPLETE;
			}
			
			var r:Number = 1000;
			// do something to use some cycles
			for(var i:uint = 0; i < cycles; i++)
			{
				r = Math.sqrt(r) * Math.sqrt(r);
			}
			
			return ProcessStatus.CONTINUE;
		}
		
		override public function isStarted():Boolean
		{
			return started;
		}
	}
}