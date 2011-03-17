package  
{
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class GridImage extends Image 
	{
		public var velocityX:Number = 0;
		public var velocityY : Number = 0;
		public function GridImage(source:BitmapData) 
		{
			super(source);
			active = true;
		}
		
		override public function update():void 
		{
			x += velocityX * FP.elapsed;
			y += velocityY * FP.elapsed;
			super.update();
		}
	}
}