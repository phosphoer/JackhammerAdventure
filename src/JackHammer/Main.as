package JackHammer
{
	import flash.display.Sprite;
	import flash.events.Event;
  import flash.utils.Dictionary;
  import TomatoAS.Engine;
  import TomatoAS.GameObject;
	
	/**
	 * ...
	 * @author David Evans
	 */
	public class Main extends Sprite 
	{
		private var m_Background:GameObject;
    
    public static var Obstacles:Dictionary = new Dictionary();
    
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
      
      m_Background = Engine.Instance.CreateObject();
      m_Background.AddComponent(new Background1());
      
      var player:GameObject = Engine.Instance.CreateObject();
      player.AddComponent(new Player());
      player.x = m_Background.width / 2;
      player.y = -100;
      
      addEventListener(Event.ENTER_FRAME, GameLoop, false, 0, true);
		}
    
    private function GameLoop(e:Event):void
    {
      // Respawn background
      if (m_Background.y < Engine.Instance.Camera.y - m_Background.height / 2)
      {
        var newY:Number = m_Background.y + m_Background.height;
        m_Background = Engine.Instance.CreateObject();
        m_Background.AddComponent(new Background1());
        m_Background.y = newY - 2;
      }
      
      // Spawn big rocks
      if (Math.random() < 0.05)
      {
        var rock:GameObject = Engine.Instance.CreateObject();
        rock.AddComponent(new Lava());
        rock.x = Math.random() * stage.stageWidth - stage.stageWidth / 2 + Engine.Instance.Camera.x;
        rock.y = stage.stageHeight + 150 + Engine.Instance.Camera.y;
      }
    }
		
	}
	
}