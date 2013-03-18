package TomatoAS 
{
  import flash.display.Stage;
  import flash.events.Event;
  import flash.system.System;
  import flash.utils.Dictionary;
  
	/**
	 * ...
	 * @author David Evans
	 */
	public class Engine
	{
    private var m_Systems:Dictionary;
    private var m_Objects:Dictionary;
    private var m_Trash:Array;
    
    public static var Instance:Engine;
    
		public function Engine() 
		{
      Instance = this;
      
			m_Systems = new Dictionary();
      m_Objects = new Dictionary();
      m_Trash = new Array();
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
      return gameObject;
    }
    
    public function DestroyObject(gameObject:GameObject):void
    {
      m_Trash.push(gameObject);
    }
		
    public function Start(stage:Stage):void
    {
      stage.addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
    }
    
    public function Update(e:Event):void
    {
      for (var systemName:String in m_Systems)
      {
        m_Systems[systemName].Update();
      }
      
      for (var objectID:String in m_Objects)
      {
        m_Objects[objectID].Update();
      }
      
      for (objectID in m_Trash)
      {
        delete m_Objects[m_Trash[objectID].GetID()];
      }
      m_Trash = [];
    }
	}

}