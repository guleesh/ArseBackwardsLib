/**
 * Created by Alexander "Foo 'The Man' Choo" Syed (a.k.a. Captain Fantastic) 
 */

package org.pixelami.arsebackwards.processes
{
	import flash.events.EventDispatcher;
	
	
	public class AbstractProcess extends EventDispatcher
	{
		static private var PROCESSID:int = 0;
		private var pid:int;
		protected var runIteration:uint = 0;
		
		public function AbstractProcess()
		{
			super(null);
			pid = PROCESSID++;
		}
		
		public function getPid():int
		{
			return pid
		}
		
		public function run():uint
		{
			return 0;
		}
		
		public function isStarted():Boolean
		{
			return false;
		}
		
		private var _cycles:uint = 10000;
		public function set cycles(value:uint):void
		{
			_cycles = value
		}
		
		public function get cycles():uint
		{
			return _cycles
		}
			
	}
}