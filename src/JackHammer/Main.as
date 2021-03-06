package JackHammer
{
  import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
  import flash.geom.Point;
  import flash.text.AntiAliasType;
  import flash.text.TextFormat;
  import flash.utils.Dictionary;
  import flash.text.TextField;
  import flash.geom.Matrix;
  import TomatoAS.Engine;
  import TomatoAS.GameObject;
  import mochi.as3.*;
	
	/**
	 * ...
	 * @author David Evans
	 */
	public class Main extends MovieClip 
	{
    private var m_PlayerMoving:Boolean;
    private var m_Player:GameObject;
    private var m_Score:TextField;
    private var m_ScoreValue:int;
    private var m_Backgrounds:Array;
    private var m_Level:int;
    private var m_LevelMod:int;
    private var m_DiamondBar:DiamondBar;
    private var m_DugTransform:Matrix;
    private var m_Dug:Sprite;
    
    public static var Obstacles:Dictionary = new Dictionary();
    public static var Diamonds:Dictionary = new Dictionary();
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
      
      m_ScoreValue = 0;
      m_DugTransform = new Matrix();
      
      new Engine(stage);
      Engine.Instance.Start();
      
      m_Backgrounds = [Background, BackgroundDeep, BackgroundWater, BackgroundSpace];
      
      m_Score = new TextField();
      var format:TextFormat = new TextFormat("Arial", 36, 0xeeeeee, true);
      m_Score.defaultTextFormat = format;
      m_Score.antiAliasType = AntiAliasType.ADVANCED;
      m_Score.width = 400;
      Engine.Instance.HUDLayer.addChild(m_Score);
     
      addEventListener(Event.ENTER_FRAME, GameLoop, false, 0, true);
      stage.addEventListener("StartGame", StartGame, false, 0, true);
      stage.addEventListener("EndGame", EndGame, false, 0, true);
      stage.addEventListener("StartMoving", StartMoving, false, 0, true);
      
      m_Dug = new Sprite();
      Engine.Instance.AddObjectToLayer(m_Dug, 2);
      
      m_DugTransform.scale(4, 4);
      m_Dug.graphics.beginBitmapFill(Resources.TileRockDug.bitmapData, m_DugTransform);
      m_Dug.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
      m_Dug.graphics.endFill();
      m_Dug.mask = Engine.Instance.GetLayer(1);
      
      var sky:Sprite = new Sprite();
      Engine.Instance.AddObjectToLayer(sky, 3);
      sky.x = -stage.stageWidth;
      sky.y = -stage.stageHeight;
      
      sky.graphics.beginFill(0x54C4D8);
      sky.graphics.drawRect(0, 0, stage.stageWidth * 3, stage.stageHeight);
      sky.graphics.endFill();
     
      m_DiamondBar = new DiamondBar();
      m_DiamondBar.x = stage.stageWidth / 2 - m_DiamondBar.width / 2;
      m_DiamondBar.y = stage.stageHeight / 2 - 120;
      m_DiamondBar.alpha = 0.5;
      Engine.Instance.HUDLayer.addChild(m_DiamondBar);
      
      MochiServices.connect("fcba24a922a3a65a", Engine.Instance.HUDLayer);
      stage.dispatchEvent(new Event("StartGame"));
		}
    
    public function EndGame(e:Event):void
    {
      var o:Object = { n: [15, 7, 4, 4, 13, 5, 10, 9, 14, 3, 15, 4, 0, 8, 11, 13], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
      var boardID:String = o.f(0,"");
      MochiScores.showLeaderboard( { boardID: boardID, score: m_ScoreValue } );
      stage.dispatchEvent(new Event("StartGame"));
    }
    
    public function StartGame(e:Event):void
    {
      m_Level = 0;
      
      for (var x:String in Grid)
      {
        for (var y:String in Grid)
        {
          var obj:GameObject = Grid[x][y];
          if (obj)
          {
            obj.Destroy();
            Grid[x][y] = null;
          }
        }
      }
      Grid = new Dictionary();
      
      var player:GameObject = Engine.Instance.CreateObject(3);
      player.AddComponent(new Player());
      player.AddComponent(new DigEffect());
      player.x = 0;
      player.y = -20;
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
      var score:int = (m_Player.GetComponent("Player") as Player).GetScore();
      m_ScoreValue = score;
      m_Score.text = score.toString();
      
      m_DugTransform.tx = -m_Player.x;
      m_DugTransform.ty = -m_Player.y;
      m_Dug.graphics.clear();
      m_Dug.graphics.beginBitmapFill(Resources.TileRockDug.bitmapData, m_DugTransform);
      m_Dug.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
      m_Dug.graphics.endFill();
      
      // Update diamonds
      var diamondPercent:Number = (m_Player.GetComponent("Player") as Player).GetDiamondTime();
      if (diamondPercent <= 0)
        m_DiamondBar.alpha = 0;
      else
        m_DiamondBar.alpha = 0.5;
      m_DiamondBar.Update(diamondPercent);
      
      // Update level
      m_Level = m_Player.y / 8000;
      m_LevelMod = m_Level % m_Backgrounds.length;
      
      var arrayX:Array = [Math.floor((Engine.Instance.Camera.x - stage.stageWidth / 2) / Background.Width), 
                          Math.floor((Engine.Instance.Camera.x + stage.stageWidth / 2) / Background.Width),
                          Math.floor((Engine.Instance.Camera.x + stage.stageWidth / 2) / Background.Width),
                          Math.floor((Engine.Instance.Camera.x - stage.stageWidth / 2) / Background.Width)];
                          
      var arrayY:Array = [Math.floor((Engine.Instance.Camera.y - stage.stageHeight / 2) / Background.Height), 
                          Math.floor((Engine.Instance.Camera.y + stage.stageHeight / 2) / Background.Height),
                          Math.floor((Engine.Instance.Camera.y - stage.stageHeight / 2) / Background.Height),
                          Math.floor((Engine.Instance.Camera.y + stage.stageHeight / 2) / Background.Height)];
      
      // Respawn background
      var obj:GameObject;
      var backgroundClass:Class = m_Backgrounds[m_LevelMod];
      for (var i:int = 0; i < arrayX.length; ++i)
      {
        var gridX:int = arrayX[i];
        var gridY:int = arrayY[i];
        
        if (!Grid[gridX])
          Grid[gridX] = new Dictionary();
          
        if (!Grid[gridX][gridY] && gridY >= 0)
        {
          obj = Engine.Instance.CreateObject();
          var bg:Background = new backgroundClass();
          obj.AddComponent(bg);
          obj.x = gridX * Background.Width;
          obj.y = gridY * Background.Height;
          Grid[gridX][gridY] = obj;
          SpawnLava(obj);
          SpawnDiamonds(obj);
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
    }
    
    public function SpawnLava(bg:GameObject):void
    {
      var num:int = 5 + m_Level * 3;
      for (var i:int = 0; i < num; ++i)
      {
        var obj:GameObject = Engine.Instance.CreateObject();
        if (m_Backgrounds[m_LevelMod] == BackgroundSpace)
          obj.AddComponent(new Spaceship());
        else if (m_Backgrounds[m_LevelMod] == BackgroundWater)
          obj.AddComponent(new Mine());
        else
          obj.AddComponent(new Lava());
        obj.x = bg.x + Math.random() * Background.Width;
        obj.y = bg.y + Math.random() * Background.Height;
      }
    }
    
    public function SpawnDiamonds(bg:GameObject):void
    {
      var num:int = 2;
      for (var i:int = 0; i < num; ++i)
      {
        var obj:GameObject = Engine.Instance.CreateObject();
        obj.AddComponent(new Diamond());
        obj.x = bg.x + Math.random() * Background.Width;
        obj.y = bg.y + Math.random() * Background.Height;
      }
    }
		
	}
	
}