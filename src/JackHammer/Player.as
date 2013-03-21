package JackHammer 
{
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Matrix;
  import TomatoAS.IComponent;
  import TomatoAS.Engine;
  import JackHammer.Resources;
  
	/**
   * ...
   * @author David Evans
   */
  public class Player extends IComponent
  {
    private var m_Angle:Number;
    private var m_DudeAngle:Number;
    private var m_Speed:Number;
    private var m_Moving:Boolean;
    private var m_Score:int;
    private var m_Dude:Sprite;
    private var m_HitTest:Sprite;
    
    public function Player() 
    { 
      m_Angle = 0;
      m_DudeAngle = 0;
      m_Dude = new Sprite();
      m_HitTest = new Sprite();
      m_Speed = 10;
      m_Moving = false;
      Draw();
    }
    
    public override function Initialize():void
    {
      stage.addEventListener(MouseEvent.CLICK, OnMouseDown, false, 0, true);
      addChild(m_Dude);
      addChild(m_HitTest);
      m_HitTest.visible = false;
    }
    
    public override function Uninitialize():void
    {
      stage.removeEventListener(MouseEvent.CLICK, OnMouseDown);
    }
    
    public override function Update(e:Event):void
    {
      // Get angle to mouse
      var mouseY:Number = Engine.Instance.MouseWorld.y;
      if (mouseY < this.parent.y)
        mouseY = this.parent.y;
      var angle:Number = Math.atan2(mouseY - this.parent.y, Engine.Instance.MouseWorld.x - this.parent.x);
      m_Angle += (angle - m_Angle) / 15;
      m_DudeAngle += (angle - m_DudeAngle) / 25;
      
      // Constrain to direction we want to move
      if (m_Angle < -Math.PI / 2)
        m_Angle = Math.PI;
      else if (m_Angle < 0)
        m_Angle = 0;
      
      // Move
      if (m_Moving)
      {
        m_Speed = 10 + Math.log(m_Score / 100 + 1);
        this.parent.x += Math.cos(m_Angle) * m_Speed;
        this.parent.y += Math.sin(m_Angle) * m_Speed;
      }
      
      // Rotate to direction
      rotation = (m_Angle * 180) / Math.PI - 90;
      m_Dude.rotation = ((m_DudeAngle - m_Angle) * 180) / Math.PI;
      
      // Update camera
      Engine.Instance.Camera.x = this.parent.x;
      Engine.Instance.Camera.y = this.parent.y;
      
      // Update score
      m_Score = Math.max(0, this.parent.y);
      
      // Check collision against obstacles
      for (var i:String in Main.Obstacles)
      {
        // if (this.Parent.TestCollision(Main.Obstacles[i]))
        if (Main.Obstacles[i].Parent.TestCollision(m_HitTest))
        {
          Parent.Destroy();
          stage.dispatchEvent(new Event("StartGame"));
          break;
        }
      }
    }
    
    public override function GetName():String
    {
      return "Player";
    }
    
    private function OnMouseDown(e:MouseEvent):void
    {
      m_Moving = true;
      stage.dispatchEvent(new Event("StartMoving"));
    }
    
    private function Draw():void
    {
      var scale:Matrix = new Matrix();
      
      scale.scale(3, 3);
      scale.translate(-Resources.Jackhammer.width * 3 / 2, -Resources.Jackhammer.height * 3 / 2);
      graphics.beginBitmapFill(Resources.Jackhammer.bitmapData, scale, false);
      graphics.drawRect(-Resources.Jackhammer.width * 3 / 2, -Resources.Jackhammer.height * 3 / 2, Resources.Jackhammer.width * 3, Resources.Jackhammer.height * 3);
      graphics.endFill();
      
      var trans:Matrix = new Matrix();
      trans.scale(3, 3);
      trans.translate( - Resources.Jack.width * 3 / 2, -Resources.Jackhammer.height * 3 / 2 - Resources.Jack.height * 3 + 5);
      m_Dude.graphics.beginBitmapFill(Resources.Jack.bitmapData, trans, false);
      m_Dude.graphics.drawRect(- Resources.Jack.width * 3 / 2, -Resources.Jackhammer.height * 3 / 2 - Resources.Jack.height * 3 + 5, Resources.Jack.width * 3, Resources.Jack.height * 3);
      m_Dude.graphics.endFill();
      
      m_HitTest.graphics.beginFill(0x53DBF2, 0.8);
      m_HitTest.graphics.drawCircle(0, Resources.Jackhammer.height * 3 / 2, 5);
      m_HitTest.graphics.endFill();
    }
    
    public function GetScore():int
    {
      return m_Score;
    }
    
  }

}