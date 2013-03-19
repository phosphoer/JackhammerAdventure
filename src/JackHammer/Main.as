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
    private var m_PlayerMoving:Boolean;
    
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
     
      addEventListener(Event.ENTER_FRAME, GameLoop, false, 0, true);
      stage.addEventListener("StartGame", StartGame, false, 0, true);
      stage.addEventListener("StartMoving", StartMoving, false, 0, true);
      
      stage.dispatchEvent(new Event("StartGame"));
		}
    
    public function StartGame(e:Event):void
    {
      if (m_Background && m_Background.parent != null)
        m_Background.Destroy();
        
      m_Background = Engine.Instance.CreateObject();
      m_Background.AddComponent(new Background1());
      
      var player:GameObject = Engine.Instance.CreateObject();
      player.AddComponent(new Player());
      player.x = m_Background.width / 2;
      player.y = -100;
      Engine.Instance.Camera.y = 0;
      
      m_PlayerMoving = false;
    }
    
    public function StartMoving(e:Event):void
    {
      m_PlayerMoving = true;
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
      if (Math.random() < 0.05 && m_PlayerMoving)
      {
        var rock:GameObject = Engine.Instance.CreateObject();
        rock.AddComponent(new Lava());
        rock.x = Math.random() * stage.stageWidth - stage.stageWidth / 2 + Engine.Instance.Camera.x;
        rock.y = stage.stageHeight + 150 + Engine.Instance.Camera.y;
      }
    }
		
	}
	
}