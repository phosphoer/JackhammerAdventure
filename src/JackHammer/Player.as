package JackHammer 
{
  import flash.display.Graphics;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import TomatoAS.IComponent;
  
	/**
   * ...
   * @author David Evans
   */
  public class Player extends IComponent
  {
    private var m_Speed:Number;
    
    public function Player() 
    { 
      m_Speed = 5;
      Draw();
    }
    
    public override function Initialize():void
    {
      trace("Initialized");
    }
    
    public override function Update(e:Event):void
    {
      // Get angle to mouse
      var angle:Number = Math.atan2(stage.mouseY - y, stage.mouseX - x);
      
      // Move
      x += Math.cos(angle) * m_Speed;
      y += Math.sin(angle) * m_Speed;
      
    }
    
    private function Draw():void
    {
      graphics.lineStyle(1);
      graphics.beginFill(0x3691AB);
      graphics.drawCircle(0, 0, 30);
      graphics.endFill(); 
    }
    
  }

}