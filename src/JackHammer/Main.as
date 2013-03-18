package JackHammer
{
	import flash.display.Sprite;
	import flash.events.Event;
  import TomatoAS.Engine;
  import TomatoAS.GameObject;
	
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
      
      new Engine(stage);
      Engine.Instance.Start();
      
      var player:GameObject = Engine.Instance.CreateObject();
      player.AddComponent(new Player());
      
      var rock:GameObject = Engine.Instance.CreateObject();
      rock.AddComponent(new Rock());
      
      rock.x = 0;
      rock.y = 300;
		}
		
	}
	
}