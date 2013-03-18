package TomatoAS 
{
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.Event;
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
    private var m_Stage:Stage;
    
    public static var Instance:Engine;
    
		public function Engine(stage:Stage) 
		{
      Instance = this;
      
			m_Systems = new Dictionary();
      m_Objects = new Dictionary();
      m_Trash = new Array();
      m_Stage = stage;
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
      addChild(gameObject);
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
      for (var systemName:String in m_Systems)
      {
        m_Systems[systemName].Update(0.017);
      }
      
      for (var objectID:String in m_Trash)
      {
        removeChild(m_Trash[objectID]);
        delete m_Objects[m_Trash[objectID].GetID()];
      }
      m_Trash = [];
    }
	}

}