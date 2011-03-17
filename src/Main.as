package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

	/**
	 * ...
	 * @author Richard Marks
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine 
	{
		public function Main():void 
		{
			super(320, 240);
		}
		
		override public function init():void 
		{
			FP.world = new DemoWorld;
			super.init();
		}
	}
}