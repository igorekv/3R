package  
{
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	
	
	public class control
	
	{
		private var LEFT:int = 65;
		private var RIGHT:int = 68;
		private var UP:int = 87;
		private var DOWN:int = 83;	
		private var controlObj:car;
		
		public function control(root:Main,ctrlObj:car) 
		{
			controlObj = ctrlObj;
			root.stage.addEventListener(KeyboardEvent.KEY_DOWN, on_keyPress);
			root.stage.addEventListener(KeyboardEvent.KEY_UP ,on_keyRelease);
		}
		
		
		
		function on_keyPress(event:KeyboardEvent) {
			//trace("keyDownHandler: " + event.keyCode);

			switch (event.keyCode)
			{
				case LEFT :
					controlObj.turnleft=true;
					break;
				case RIGHT :
					controlObj.turnright=true;
					break;
				case UP :
					controlObj.accel = true;
					break;
				case DOWN :

					break;
				case 32 ://space

					break;
			}
			
			
		}
	
		function on_keyRelease(event:KeyboardEvent) {
			switch (event.keyCode)
			{
				case LEFT :
					controlObj.turnleft=false;
					break;
				case RIGHT :
					controlObj.turnright=false;
					break;
				case UP :
					controlObj.accel = false;
					break;
				case DOWN :

					break;
				case 32 ://space

					break;
			}
			
			
		}
		
	}

}