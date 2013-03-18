package TomatoAS 
{
	/**
   * ...
   * @author David Evans
   */
  public interface IComponent 
  { 
    public function IComponent();
    function Initialize():void;
    function Uninitialize():void;
    function Update(dt:Number):void;
    function GetName():String;
  }

}