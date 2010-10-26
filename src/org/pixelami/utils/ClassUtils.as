/**
 * Created by Alexander "Foo 'The Man' Choo" Syed (a.k.a. Captain Fantastic) 
 */

package org.pixelami.utils
{
	
	
	public class ClassUtils
	{
		public function ClassUtils()
		{
		}
		
		static public function construct(clss:Class, ...rest):*
		{
			return _construct(clss,rest);
		}
		
		static public function constructWithArguments(clss:Class,args:Array):*
		{
			return _construct(clss,args);
		}
		
		/**
		 * passing Class constructors dynamically in AS3 - "Bandito Style"
		 */
		static private function _construct(clss:Class, args:Array):*
		{
			var instance:*;
			
			if(!args) args = [];
			
			switch(args.length)
			{
				case 0:
					instance = new clss();
					break;
				case 1:
					instance = new clss(args[0]);
					break;
				case 2:
					instance = new clss(args[0],args[1]);
					break;
				case 3:
					instance = new clss(args[0],args[1],args[2]);
					break;
				case 4:
					instance = new clss(args[0],args[1],args[2],args[3]);
					break;
				case 5:
					instance = new clss(args[0],args[1],args[2],args[3],args[4]);
					break;
				case 6:
					instance = new clss(args[0],args[1],args[2],args[3],args[4],args[5]);
					break;
				case 7:
					instance = new clss(args[0],args[1],args[2],args[3],args[4],args[5],args[6]);
					break;
				case 8:
					instance = new clss(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
					break;
				case 9:
					instance = new clss(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8]);
					break;
				case 10:
					instance = new clss(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9]);
					break;
				default:
					throw new ArgumentError("Exceeded maximun (10) supported constuctor arguments");
					
			}
			
			return instance;
		}
	}
}