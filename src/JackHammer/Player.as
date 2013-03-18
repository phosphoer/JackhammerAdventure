package JackHammer 
{
  import flash.display.Graphics;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import TomatoAS.IComponent;
  import TomatoAS.Engine;
  
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
    }
    
    public override function Update(e:Event):void
    {
      // Get angle to mouse
      var angle:Number = Math.atan2(Engine.Instance.MouseWorld.y - this.parent.y, Engine.Instance.MouseWorld.x - this.parent.x);
      
      // Constrain to direction we want to move
      if (angle < -Math.PI / 2)
        angle = Math.PI;
      else if (angle < 0)
        angle = 0;
      
      // Move
      this.parent.x += Math.cos(angle) * m_Speed;
      this.parent.y += Math.sin(angle) * m_Speed;
      
      // Rotate to direction
      rotation = (angle * 180) / Math.PI + 90;
      
      // Update "camera"
      Engine.Instance.Camera.x = this.parent.x;
      Engine.Instance.Camera.y = this.parent.y;
    }
    
    private function Draw():void
    {
      graphics.lineStyle(1);
      graphics.beginFill(0x3691AB);
      graphics.drawRect(-10, -25, 20, 50);
      graphics.endFill(); 
    }
    
  }

}