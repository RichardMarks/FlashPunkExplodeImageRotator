package  
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class DemoWorld extends World 
	{	
		public function DemoWorld() { }
		
		override public function begin():void 
		{
			// add the effect generation entity
			add(new ExplodeImageRotator);
			
			super.begin();
		}
	}
}