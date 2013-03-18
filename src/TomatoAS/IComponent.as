package TomatoAS 
{
  import flash.display.Sprite;
	/**
   * ...
   * @author David Evans
   */
  public class IComponent extends Sprite
  { 
    public function IComponent() {}
    public function Initialize():void {}
    public function Uninitialize():void {}
    public function Update(dt:Number):void {}
    public function GetName():String { return "IComponent"; }
  }

}