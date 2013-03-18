package JackHammer 
{
  import flash.events.Event;
  import TomatoAS.Engine;
  import TomatoAS.IComponent;
	/**
   * ...
   * @author David Evans
   */
  public class Lava extends IComponent
  {
    private var m_Size:Number;
    
    public function Lava()
    {
      m_Size = 30 + Math.random() * 30;
      Draw();
    }
    
    public override function Initialize():void
    {
      Main.Obstacles[Parent.GetID()] = this;
    }
    
    public override function Uninitialize():void
    {
      delete Main.Obstacles[Parent.GetID()];
    }
    
    public override function Update(e:Event):void
    {
      if (this.parent.y < Engine.Instance.Camera.y - stage.stageHeight)
        Parent.Destroy();
    }
    
    private function Draw():void
    {
      graphics.lineStyle(1);
      graphics.beginFill(0xD03711);
      graphics.drawCircle(0, 0, m_Size);
      graphics.endFill(); 
    }
  }

}