package JackHammer
{
	import flash.display.Sprite;
	import flash.events.Event;
  import flash.text.AntiAliasType;
  import flash.text.TextFormat;
  import flash.utils.Dictionary;
  import flash.text.TextField;
  import TomatoAS.Engine;
  import TomatoAS.GameObject;
	
	/**
	 * ...
	 * @author David Evans
	 */
	public class Main extends Sprite 
	{
    private var m_PlayerMoving:Boolean;
    private var m_Player:GameObject;
    private var m_Score:TextField;
    
    public static var Obstacles:Dictionary = new Dictionary();
    private static var Grid:Dictionary = new Dictionary();
    
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
      
      m_Score = new TextField();
      var format:TextFormat = new TextFormat("Arial", 36, 0xeeeeee, true);
      m_Score.defaultTextFormat = format;
      m_Score.antiAliasType = AntiAliasType.ADVANCED;
      Engine.Instance.HUDLayer.addChild(m_Score);
     
      addEventListener(Event.ENTER_FRAME, GameLoop, false, 0, true);
      stage.addEventListener("StartGame", StartGame, false, 0, true);
      stage.addEventListener("StartMoving", StartMoving, false, 0, true);
      
      stage.dispatchEvent(new Event("StartGame"));
		}
    
    public function StartGame(e:Event):void
    {
      var player:GameObject = Engine.Instance.CreateObject();
      player.AddComponent(new Player());
      player.x = 0;
      player.y = -100;
      m_Player = player;
      Engine.Instance.Camera.y = 0;
      
      m_PlayerMoving = false;
    }
    
    public function StartMoving(e:Event):void
    {
      m_PlayerMoving = true;
    }
    
    private function GameLoop(e:Event):void
    {
      // Update score
      m_Score.text = (m_Player.GetComponent("Player") as Player).GetScore().toString();
      
      var arrayX:Array = [Math.floor((Engine.Instance.Camera.x - stage.stageWidth / 2) / Background1.Width), 
                          Math.floor((Engine.Instance.Camera.x + stage.stageWidth / 2) / Background1.Width),
                          Math.floor((Engine.Instance.Camera.x + stage.stageWidth / 2) / Background1.Width),
                          Math.floor((Engine.Instance.Camera.x - stage.stageWidth / 2) / Background1.Width)];
                          
      var arrayY:Array = [Math.floor((Engine.Instance.Camera.y - stage.stageHeight / 2) / Background1.Height), 
                          Math.floor((Engine.Instance.Camera.y + stage.stageHeight / 2) / Background1.Height),
                          Math.floor((Engine.Instance.Camera.y - stage.stageHeight / 2) / Background1.Height),
                          Math.floor((Engine.Instance.Camera.y + stage.stageHeight / 2) / Background1.Height)];
      
      // Respawn background
      var obj:GameObject;
      for (var i:int = 0; i < arrayX.length; ++i)
      {
        var gridX:int = arrayX[i];
        var gridY:int = arrayY[i];
        
        if (!Grid[gridX])
          Grid[gridX] = new Dictionary();
          
        if (!Grid[gridX][gridY] && gridY >= 0)
        {
          obj = Engine.Instance.CreateObject();
          var bg:Background1 = new Background1();
          obj.AddComponent(bg);
          obj.x = gridX * Background1.Width;
          obj.y = gridY * Background1.Height;
          Grid[gridX][gridY] = obj;
        }
      }
      
      for (var x:String in Grid)
      {
        for (var y:String in Grid)
        {
          obj = Grid[x][y];
          if (obj)
          {
            var xpos:int = parseInt(x);
            var ypos:int = parseInt(y);
            
            if (arrayX[0] > xpos && arrayY[0] > ypos)
            {
              obj.Destroy();
              Grid[x][y] = null;
            }
          }
        }
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