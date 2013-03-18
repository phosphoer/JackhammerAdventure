package JackHammer
{
	import flash.display.Sprite;
	import flash.events.Event;
  import TomatoAS.Engine;
	
	/**
	 * ...
	 * @author David Evans
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
      
      new Engine();
      Engine.Instance.Start(stage);
		}
		
	}
	
}