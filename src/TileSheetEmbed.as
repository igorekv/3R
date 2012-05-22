package 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class TileSheetEmbed extends Sprite
	{
		[Embed(source = 'dirtdevil.png')]
		private var TileSheet:Class;
		private var backGroundBitmapData:BitmapData = new BitmapData(48,48,false,0x000000);
		private var canvasBitmapData:BitmapData = new BitmapData(48,48,true,0xffffff);
		private var canvasBitmap:Bitmap = new Bitmap(canvasBitmapData);
		private var tileCounter:int = 0;
		private var tileList:Array = [0,1,2,3,4,5,6,7,8,9,10,11,12,11,10,9,8,7,6,5,4,3,2,1];
		private var tileSheet:Bitmap=new TileSheet();
		private var backBlitPoint:Point = new Point(0,0);
		private var tileBlitPoint:Point = new Point(0,0);
		private var blitRect32:Rectangle = new Rectangle(0,0,48,48);
		private var tileWidth:int = 48;
		private var tileHeight:int = 48;
		private var tilesPerRow:int = tileSheet.width / tileWidth;
		public function TileSheetEmbed()
		{
			// constructor code
			
			addChild(canvasBitmap);
			addEventListener(Event.ENTER_FRAME, runDemo, false, 0, true);
			
		}
		
		private function runDemo(e:Event):void {
	  
			canvasBitmapData.lock();
	 
	    canvasBitmapData.copyPixels(backGroundBitmapData,
	    backGroundBitmapData.rect, backBlitPoint);
	 
	    blitRect32.x=int(tileList[tileCounter]% tilesPerRow)*tileWidth;
	    blitRect32.y=int(tileList[tileCounter] / tilesPerRow)*tileHeight;
	
	    canvasBitmapData.copyPixels(tileSheet.bitmapData,
	    blitRect32, tileBlitPoint);
	 
	    canvasBitmapData.unlock();
	    tileCounter++;
	    if (tileCounter > tileList.length-1) {
	    tileCounter = 0;
	    }
	  }
	
	}

	

}