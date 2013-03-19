package TomatoAS 
{
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.geom.Point;
  import flash.system.System;
  import flash.utils.Dictionary;
  import flash.utils.Timer;
  
	/**
	 * ...
	 * @author David Evans
	 */
	public class Engine extends Sprite
	{
    private var m_Systems:Dictionary;
    private var m_Objects:Dictionary;
    private var m_Trash:Array;
    private var m_Layers:Array;
    private var m_Stage:Stage;
    
    public var Camera:Point;
    public var MouseWorld:Point;
    public var HUDLayer:Sprite;
    
    public static var Instance:Engine;
    
		public function Engine(stage:Stage) 
		{
      Instance = this;
      
			m_Systems = new Dictionary();
      m_Objects = new Dictionary();
      m_Trash = new Array();
      m_Layers = new Array();
      m_Stage = stage;
      
      for (var i:int = 0; i < 3; ++i)
      {
        m_Layers.push(new Sprite())
        addChild(m_Layers[i]);
      }
      HUDLayer = new Sprite();
      addChild(HUDLayer);
      
      Camera = new Point();
      MouseWorld = new Point();
		}
    
    public function AddSystem(system:IComponent):void
    {
      m_Systems[system.GetName()] = system;
    }
    
    public function GetSystem(systemName:String):System
    {
      return m_Systems[systemName];
    }
    
    public function CreateObject():GameObject
    {
      var gameObject:GameObject = new GameObject();
      m_Objects[gameObject.GetID()] = gameObject;
      m_Layers[gameObject.GetLayer()].addChild(gameObject);
      return gameObject;
    }
    
    public function DestroyObject(gameObject:GameObject):void
    {
      m_Trash.push(gameObject);
    }
		
    public function Start():void
    {
      this.addEventListener(Event.ADDED_TO_STAGE, Added, false, 0, true);  
      m_Stage.addChild(this);
    }
    
    public function Added(e:Event):void
    {
      m_Stage.addEventListener(Event.ENTER_FRAME, Update, false, 0, true);  
    }
    
    public function Update(e:Event):void
    {
      MouseWorld.x = stage.mouseX - stage.stageWidth / 2 + Camera.x;
      MouseWorld.y = stage.mouseY - stage.stageHeight / 2 + Camera.y;
      
      for (var systemName:String in m_Systems)
      {
        m_Systems[systemName].Update(0.017);
      }
      
      for (var layerID:String in m_Layers)
      {
        m_Layers[layerID].x = -Camera.x / (1 + parseFloat(layerID) * 5) + stage.stageWidth / 2;
        m_Layers[layerID].y = -Camera.y / (1 + parseFloat(layerID) * 5) + stage.stageHeight / 2;
      }
      
      for (var objectID:String in m_Trash)
      {
        var object:GameObject = m_Trash[objectID];
        m_Layers[object.GetLayer()].removeChild(object);
        delete m_Objects[object.GetID()];
      }
      m_Trash = [];
    }
	}

}