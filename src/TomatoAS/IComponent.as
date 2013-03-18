package TomatoAS 
{
  import flash.display.Sprite;
  import flash.events.Event;
	/**
   * ...
   * @author David Evans
   */
  public class IComponent extends Sprite
  { 
    public function IComponent() 
    {
      addEventListener(Event.ADDED_TO_STAGE, InitializeSuper, false, 0, true);
      addEventListener(Event.REMOVED_FROM_STAGE, UninitializeSuper, false, 0, true);
    }
    
    private function InitializeSuper(e:Event):void
    {
      Initialize();
      addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
    }
    
    public function Initialize():void { }
    
    private function UninitializeSuper(e:Event):void
    {
      Uninitialize();
      removeEventListener(Event.ADDED_TO_STAGE, InitializeSuper);
      removeEventListener(Event.REMOVED_FROM_STAGE, UninitializeSuper);
      removeEventListener(Event.ENTER_FRAME, Update);
    }
    
    public function Uninitialize():void { }
    
    public function Update(e:Event):void {}
    public function GetName():String { return "IComponent"; }
  }

}