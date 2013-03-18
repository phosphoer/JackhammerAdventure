package TomatoAS 
{
  import flash.geom.Point;
  import flash.utils.Dictionary;
	/**
   * ...
   * @author David Evans
   */
  public class GameObject implements IComponent
  {
    private var m_Components:Dictionary;
    private var m_ID:int;
    public var Position:Point;
    
    private static var CurrentID:int = 0;
    
    public function GameObject() 
    {
      m_ID = CurrentID++;
      
      m_Components = new Dictionary();
      Position = new Point();
    }
    
    public function Initialize():void
    {
    }
    
    public function Uninitialize():void
    {
    }
    
    public function Update(dt:Number):void
    {
    }
    
    public function GetName():String
    {
      return "GameObject";
    }
    
    public function AddComponent(component:IComponent):void
    {
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