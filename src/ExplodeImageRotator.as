package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class ExplodeImageRotator extends Entity 
	{
		private static const SECONDS_TO_DISPLAY:int = 3;
        private static var imageList:Vector.<Class>;
		
        private var  frontAnimator:GridImageAnimator;
        private var backAnimator:GridImageAnimator;
        private var currentImageIndex:int = 0;
		private var imageSwapAlarm:Alarm;
		
		public function ExplodeImageRotator() 
		{
			if (imageList == null)
			{
				imageList = new Vector.<Class>();
				imageList.push(Assets.IMAGE1_PNG, Assets.IMAGE2_PNG, Assets.IMAGE3_PNG);
			}
			
			imageSwapAlarm = new Alarm(SECONDS_TO_DISPLAY, SwapImageCallback, Tween.LOOPING);
			
			const factor:Number = 300;
			frontAnimator = new GridImageAnimator(320, 240, 8, 8, new Point(-factor,-factor), new Point(factor,factor));
			backAnimator = new GridImageAnimator(320, 240, 8, 8, new Point(-factor,-factor), new Point(factor,factor));
			
			backAnimator.showImage(imageList[currentImageIndex], false);
		}
		
		override public function added():void 
		{
			try
			{
				addTween(imageSwapAlarm, true);
				FP.world.add(backAnimator);
				FP.world.add(frontAnimator);
			}
			catch (e:Error) {}
			super.added();
		}
		
		override public function removed():void 
		{
			try
			{
				FP.world.remove(backAnimator);
				FP.world.remove(frontAnimator);
				removeTween(imageSwapAlarm);
			}
			catch(e:Error){}
			super.removed();
		}
		
        private function SwapImageCallback():void
        {
            frontAnimator.showImage(imageList[currentImageIndex], true);
			
            currentImageIndex = (currentImageIndex + 1) % imageList.length;
            
			backAnimator.showImage(imageList[currentImageIndex], false);
            
			frontAnimator.play();
        }
	}
}