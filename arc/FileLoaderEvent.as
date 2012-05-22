package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author igorek
	 */
	public class FileLoaderEvent extends Event 
	{
		public static const FILE_COMPLETE:String = 'FILE_COMPLETE';
		public function FileLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new FileLoaderEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FileLoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}