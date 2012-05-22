package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import car;
	import global;
	import control;
	/**
	 * ...
	 * @author igorek
	 */
	public class Main extends Sprite 
	{
		internal var player:car;
		internal var ctrl:control;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
	
			player = new car(global.dirtdevil);
			player.scaleX = 0.5;
			player.scaleY = 0.5;
			addChild(player);
			ctrl = new control(this,player);

		}
		
	}
	
}