package JackHammer 
{
  import flash.events.Event;
  import TomatoAS.Engine;
  import TomatoAS.IComponent;
	/**
   * ...
   * @author David Evans
   */
  public class RockBG extends IComponent
  {
    private var m_Size:Number;
    
    public function RockBG()
    {
      m_Size = 5 + Math.random() * 40;
      Draw();
    }
    
    public override function Update(e:Event):void
    {
      if (this.parent.y < Engine.Instance.Camera.y - stage.stageHeight)
        Parent.Destroy();
    }
    
    private function Draw():void
    {
      var rnd:Number = Math.random();
      
      if (rnd < 0.2)
        graphics.beginFill(0xA4733E);
      else if (rnd < 0.4)
        graphics.beginFill(0x825337);
      else if (rnd < 0.6)
        graphics.beginFill(0x7E6750);
      else if (rnd < 0.8)
        graphics.beginFill(0x63453D);
      else
        graphics.beginFill(0x854F3F);
        
      graphics.drawCircle(0, 0, m_Size);
      graphics.endFill(); 
    }
  }

}