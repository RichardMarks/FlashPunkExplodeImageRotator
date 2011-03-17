package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class GridImageAnimator extends Entity 
	{
		private static var IMAGE_WIDTH:Number = 320;    // Image Width
		private static var IMAGE_HEIGHT:Number = 240;   // Image Height
		private static var NUM_COLUMN:int = 5;          // Number of colum to be splitted
		private static var NUM_ROW:int = 5;             // Number of row to be splitted
		
		private static var VELOCITY_X_MIN:Number = -5;  // The minimum x velocity
		private static var VELOCITY_X_MAX:Number = 5;   // The maximum x velocity
		private static var VELOCITY_Y_MIN:Number = -20; // The minimum y velocity
		private static var VELOCITY_Y_MAX:Number = -10; // The maximum y velocity
		
		private static var GRAVITY:Number = 3.5;        // Gravity
		
		private var _gridWidth:Number = IMAGE_WIDTH / NUM_COLUMN;
		private var _gridHeight:Number = IMAGE_HEIGHT / NUM_ROW;
		
		private var animating:Boolean = false;
		private var myGfx:Graphiclist;
		
		public function GridImageAnimator(imageWidth:int, imageHeight:int, numColumns:int = 8, numRows:int = 8, minVelocity:Point = null, maxVelocity:Point = null, gravityFactor:Number = 3.82) 
		{
			type = "GridImageAnimator";
			myGfx = new Graphiclist;
			graphic = myGfx;
			
			IMAGE_WIDTH = imageWidth;
			IMAGE_HEIGHT = imageHeight;
			NUM_COLUMN = numColumns;
			NUM_ROW = numRows;
			GRAVITY = gravityFactor;
			
			_gridWidth = IMAGE_WIDTH / numColumns;
			_gridHeight = IMAGE_HEIGHT / numRows;
			
			if (minVelocity)
			{
				VELOCITY_X_MIN = minVelocity.x;
				VELOCITY_Y_MIN = minVelocity.y;
			}
			
			if (maxVelocity)
			{
				VELOCITY_X_MAX = maxVelocity.x;
				VELOCITY_Y_MAX = maxVelocity.y;
			}
			
			animating = false;
		}
		
		override public function update():void 
		{
			if (!animating)
			{
				super.update();
				return;
			}
			
			for each(var i:GridImage in myGfx.children)
            {
				i.velocityY += GRAVITY;
			}
			
			super.update();
		}
		
 		// start the animation
        public function play():void
        {
            animating = true;
        }

        // reposition the grid images
        public function showImage(imageClass:Class, breakApart:Boolean):void
        {
			myGfx.removeAll();
			
			var image:BitmapData = FP.getBitmap(imageClass);
			
			if (breakApart)
			{
				breakImage(image);
				return;
			}
			
			animating = false;
			
			myGfx.add(new GridImage(image));
        }

        // break and add the images to the Canvas
        private function breakImage(bitmapData:BitmapData):void 
		{
            for (var i:int = 0; i < NUM_COLUMN; i++)
            {
                for (var j:int = 0; j < NUM_ROW; j++)
                {
                    var offsetX:Number = i * _gridWidth;
                    var offsetY:Number = j * _gridHeight;
					
					// create new bitmap by copy pixels
					var bd:BitmapData = new BitmapData(_gridWidth, _gridHeight);
					var rectangle:Rectangle = new Rectangle(offsetX, offsetY, _gridWidth, _gridHeight);
					bd.copyPixels(bitmapData, rectangle, new Point(0, 0));
					
                    var gridImage:GridImage = new GridImage(bd);
                    gridImage.x = offsetX;
                    gridImage.y = offsetY;
                    gridImage.velocityX = VELOCITY_X_MIN + (VELOCITY_X_MAX - VELOCITY_X_MIN) * Math.random();
                    gridImage.velocityY = VELOCITY_Y_MIN + (VELOCITY_Y_MAX - VELOCITY_Y_MIN) * Math.random();
					
					myGfx.add(gridImage);
                }
            }
			graphic = myGfx;
        }
	}
}