package TomatoAS 
{
  import flash.display.Sprite;
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
    
    public function Initialize():void
    {
      for (var i:String in m_Components)
      {
        m_Components[i].Initialize();
        addChild(m_Components[i]);
      }
    }
    
    public function Uninitialize():void
    {
      for (var i:String in m_Components)
      {
        m_Components[i].Uninitialize();
        removeChild(m_Components[i]);
      }
    }
    
    public function Update(dt:Number):void
    {
      for (var i:String in m_Components)
        m_Components[i].Update(dt);
    }
    
    public function AddComponent(component:IComponent):void
    {
      m_Components[component.GetName()] = component;
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