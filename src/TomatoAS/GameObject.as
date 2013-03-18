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
    private var m_Layer:int = 0;
    
    private static var CurrentID:int = 0;
    
    public function GameObject() 
    {
      m_ID = CurrentID++;
      m_Layer = 0;
      
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
      component.Parent = this;
      addChild(component);
    }
    
    public function GetComponent(componentName:String):IComponent
    {
      return m_Components[componentName];
    }
    
    public function Destroy():void
    {
      Engine.Instance.DestroyObject(this);
    }
    
    public function GetID():int
    {
      return m_ID;
    }
    
    public function GetLayer():int
    {
      return m_Layer;
    }
    
    public function SetZOrder(index:int):void
    {
      parent.setChildIndex(this, index);
    }
  }

}