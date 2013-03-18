package TomatoAS 
{
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Point;
  import flash.utils.Dictionary;
	/**
   * ...
   * @author David Evans
   */
  public class GameObject extends Sprite
  {
    private var m_Components:Dictionary;
    private var m_ID:int;
    
    private static var CurrentID:int = 0;
    
    public function GameObject() 
    {
      m_ID = CurrentID++;
      
      m_Components = new Dictionary();
    }
    
    public function Uninitialize():void
    {
      for (var i:String in m_Components)
      {
        removeChild(m_Components[i]);
      }
    }
    
    public function AddComponent(component:IComponent):void
    {
      m_Components[component.GetName()] = component;
      addChild(component);
    }
    
    public function GetComponent(componentName:String):IComponent
    {
      return m_Components[componentName];
    }
    
    public function GetID():int
    {
      return m_ID;
    }
  }

}