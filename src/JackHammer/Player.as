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
    private var m_Angle:Number;
    private var m_Speed:Number;
    private var m_Moving:Boolean;
    
    public function Player() 
    { 
      m_Angle = 0;
      m_Speed = 10;
      m_Moving = false;
      Draw();
    }
    
    public override function Initialize():void
    {
      stage.addEventListener(MouseEvent.CLICK, OnMouseDown, false, 0, true);
    }
    
    public override function Uninitialize():void
    {
      stage.removeEventListener(MouseEvent.CLICK, OnMouseDown);
    }
    
    public override function Update(e:Event):void
    {
      // Get angle to mouse
      var angle:Number = Math.atan2(Engine.Instance.MouseWorld.y - this.parent.y, Engine.Instance.MouseWorld.x - this.parent.x);
      m_Angle += (angle - m_Angle) / 15;
      
      // Constrain to direction we want to move
      if (m_Angle < -Math.PI / 2)
        m_Angle = Math.PI;
      else if (m_Angle < 0)
        m_Angle = 0;
      
      // Move
      if (m_Moving)
      {
        this.parent.x += Math.cos(m_Angle) * m_Speed;
        this.parent.y += Math.sin(m_Angle) * m_Speed;
      }
      
      // Rotate to direction
      rotation = (m_Angle * 180) / Math.PI + 90;
      
      // Update camera
      Engine.Instance.Camera.x = this.parent.x;
      Engine.Instance.Camera.y = this.parent.y;
      
      // Check collision against obstacles
      for (var i:String in Main.Obstacles)
      {
        if (this.Parent.TestCollision(Main.Obstacles[i]))
        {
          Parent.Destroy();
          stage.dispatchEvent(new Event("StartGame"));
          break;
        }
      }
    }
    
    private function OnMouseDown(e:MouseEvent):void
    {
      m_Moving = true;
      stage.dispatchEvent(new Event("StartMoving"));
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