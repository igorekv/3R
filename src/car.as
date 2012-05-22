package
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	public class car extends Sprite
	{
		private const degree:Number = Math.PI / 180;
		private const radian:Number = 180 / Math.PI;
		private var loader:Loader; //загрузщик
		private var tileSheet:BitmapData; //данные со спрайтами
		//private var rotFrames:Vector.<int> = new <int>[12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
		private var rotFrames:Vector.<int> = new <int>[6, 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 11, 10, 9, 8, 7, 6];
		private var tileWidth:int = 96; //ширина спрайта
		private var tileHeight:int = 96; //высота спрайта
		private var displayBitmapData:BitmapData = new BitmapData(tileWidth, tileHeight, true, 0xffffff); //данные спрайта на экране
		private var displayBitmap:Bitmap = new Bitmap(displayBitmapData); //картинка спрайта на экране
		private var BlitPoint:Point = new Point(0, 0); //точка начала копирования пикселей
		private var blitRect32:Rectangle = new Rectangle(0, 0, tileWidth, tileHeight); //прямоугольник область копирования пикселей
		private var rotAngle:int = 0; //угол поворота
		private var friAngle:int = 0;
		private var friction:Number = 0.2
		private var accelX:Number = 0;
		private var accelY:Number = 0;
		private var speedX:Number = 0;
		private var speedY:Number = 0;
		
		private var acc = 1;
		private var tilesPerRow:int = 9;
		private var speed:Number = 0;
		private var wheel:int = 0;
		private var curSpeed:Number;
		private var MAXSPEED:int = 10; //максимальная скорость влияет: персонаж, машина
		private var ACCEL:int = 1; //ускорение влияет: персонаж, машина, апгрейд двигателя 
		private var CORNER:int = 1; //возможность поворачивать, влияет: персонаж, машина, апгрейд колес.
		
		public var turnleft:Boolean = false;
		public var turnright:Boolean = false;
		public var accel:Boolean = false;
		
		public function car(skin:String)
		{
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, carLoaded); //событие об окончании загрузки
			loader.load(new URLRequest(skin)); //загрузка спрайтлиста
		
		}
		
		private function carLoaded(e:Event):void
		{ //обработчик окончания загрузки
			tileSheet = e.target.loader.content.bitmapData; //получаем данные о спрайтах
			addEventListener(Event.ENTER_FRAME, onEnterFrame); //событие на каждый кадр
			updateSprite();
			addChild(displayBitmap); //выводим обьект на экран
			trace(tileSheet.width);
			
			updateSprite();
		
		}
		
		private function changeColor(obj:BitmapData, from:uint, to:uint)
		{
			var pt:Point = new Point(0, 0);
			var rect:Rectangle = new Rectangle(0, 0, obj.width, obj.height);
			var maskColor:uint = 0x00FFFFFF;
			obj.threshold(obj, rect, pt, "==", from, to, maskColor, true);
		}
		
		private function rotateWheels()
		{
			//var bmd2:BitmapData = new BitmapData(200, 200, true, 0xFF00CCCC);
			if (wheel == 0)
			{
				changeColor(tileSheet, 0xFF494949, 0xFF505050);
				changeColor(tileSheet, 0xFF242424, 0xFF494949);
				changeColor(tileSheet, 0xFF505050, 0xFF242424);
				
			}
			wheel++;
			if (wheel >= (MAXSPEED / 2) - curSpeed)
			{
				wheel = 0;
			}
		
			//var bitmap2:Bitmap = new Bitmap(tileSheet);
			//bitmap2.x = 100; addChild(bitmap2);
		
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (turnright)
			{
				if (speed != 1)
				{
					rotAngle += 15; 
				}
				if (rotAngle >= 360)
				{
					rotAngle = 0;
				}
			}
			if (turnleft)
			{
				if (speed != 1)
				{
					rotAngle -= 15; 
				}
				if (rotAngle <= 0)
				{
					rotAngle = 360;
				}
			}
			if (accel) { 
				speed += acc;
				if (rotAngle != friAngle) { friAngle = getAngle(Math.cos(friAngle * degree) + Math.cos(rotAngle * degree), Math.sin(friAngle * degree) + Math.sin(rotAngle * degree)); }
				
				
				}else { }
				trace('git');
			
			
			
			if(curSpeed>0){rotateWheels();}
			updateSprite();
		
			//trace(rotAngle);
		}
		
		private function brake(amount:Number):void {
			//if (Math.abs(accelX) < 0.5 && Math.abs(accelX) >= 0) { accelX = 0;}
			//if (Math.abs(accelY) < 0.5 && Math.abs(accelY) >= 0) { accelY = 0;}
			var tmp = getAngle(accelX, accelY);
			
			var tmpx:Number=Math.cos((tmp + 180) * degree) * amount;
			var tmpy:Number=Math.sin((tmp + 180) * degree) * amount;
			if (accelX+tmpx) { accelX += tmpx; }
			//if (Math.abs(tmpy) > 1) { accelY += tmpy;}
			//accelX += 
			//accelY += 
			trace(accelX,accelY,tmp,tmpx,tmpy);
			
			}
		
		private function getAngle(x:Number, y:Number):int
		{
			
			if (x != 0) { x = x / (x + y); }
			if (y != 0) { y = y / (x + y); }
			if (x > 1) { x = 1; }
			if (y > 1) { y = 1; }
			
			
			var frAngle:int;
			if (x > 0 && y > 0)
			{
				var frAngle = Math.asin(y / (Math.sqrt(x * x + y * y))) * radian;
			}
			if (x <= 0 && y > 0)
			{
				var frAngle = 0 - Math.asin(x / (Math.sqrt(x * x + y * y))) * radian + 90;
			}
			if (x <= 0 && y <= 0)
			{
				var frAngle = 0 - Math.asin(y / (Math.sqrt(x * x + y * y))) * radian + 180;
			}
			if (x > 0 && y <= 0)
			{
				var frAngle = Math.asin(x / (Math.sqrt(x * x + y * y))) * radian + 270;
			}
			//trace("Угол трения:", int(frAngle),"X:",x,y);
			return frAngle;
		}
		
		private function updateSprite():void
		{
			
			displayBitmapData.lock();
			if (rotAngle / 15 > 6 && rotAngle / 15<18)
			{
				
				displayBitmap.scaleX = 1;
				displayBitmap.x = 0;
			}
			else
			{
				
				displayBitmap.scaleX = -1;
				displayBitmap.x = tileWidth;
				
			}
			//trace(rotAngle / 15);
			blitRect32.x = (rotFrames[int(rotAngle / 15)] % tilesPerRow) * tileWidth;
			blitRect32.y = int((rotFrames[int(rotAngle / 15)] / tilesPerRow)) * tileHeight;
			
			displayBitmapData.copyPixels(tileSheet, blitRect32, BlitPoint);
			displayBitmapData.unlock();
		}
	
	}

}