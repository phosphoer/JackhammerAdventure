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
    private var m_Hammer:Sprite;
    private var m_HitTest:Sprite;
    private var m_SuperPowerTime:int;
    
    public function Player() 
    { 
      m_Angle = Math.PI / 2 + Math.random() - 0.5;
      m_DudeAngle = Math.PI / 2 + Math.random() - 0.5;
      m_Dude = new Sprite();
      m_Hammer = new Sprite();
      m_HitTest = new Sprite();
      m_Speed = 5;
      m_Moving = false;
      m_SuperPowerTime = 0;
      Draw();
    }
    
    public override function Initialize():void
    {
      stage.addEventListener(MouseEvent.CLICK, OnMouseDown, false, 0, true);
      addChild(m_Dude);
      addChild(m_Hammer);
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
      if (!m_Moving)
        angle = Math.PI / 2;
      m_Angle += (angle - m_Angle) / 12;
      m_DudeAngle += (angle - m_DudeAngle) / 25;
      
      // Constrain to direction we want to move
      if (m_Angle < -Math.PI / 2)
        m_Angle = Math.PI;
      else if (m_Angle < 0)
        m_Angle = 0;
        
      if (m_SuperPowerTime > 0)
      {
        --m_SuperPowerTime;
        
        if (m_SuperPowerTime > 30)
        {
          var bit:DiamondParticle = new DiamondParticle(50 + Math.random() * 50);
          bit.x = parent.x;
          bit.y = parent.y;
          Engine.Instance.AddObjectToLayer(bit, 3);
        }
      }
      
      // Move
      if (m_Moving)
      {
        m_Speed = 5 + Math.log(m_Score / 50 + 1);
        var speed:Number = m_Speed;
        if (m_SuperPowerTime > 0)
          speed *= 2;
        this.parent.x += Math.cos(m_Angle) * speed;
        this.parent.y += Math.sin(m_Angle) * speed;
        
        m_Hammer.x = Math.cos(Math.random() * Math.PI * 2) * 2 - 1;
        m_Hammer.y = Math.sin(Math.random() * Math.PI * 2) * 2 - 1;
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
      var i:String;
      if (m_SuperPowerTime <= 0)
      {
        for (i in Main.Obstacles)
        {
          // if (this.Parent.TestCollision(Main.Obstacles[i]))
          if (Main.Obstacles[i].Parent.TestCollision(m_HitTest))
          {
            Parent.Destroy();
            stage.dispatchEvent(new Event("EndGame"));
            break;
          }
        }
      }
      
      // Check collision against diamonds
      for (i in Main.Diamonds)
      {
        // if (this.Parent.TestCollision(Main.Obstacles[i]))
        if (Main.Diamonds[i].Parent.TestCollision(m_HitTest))
        {
          m_SuperPowerTime = 150;
          break;
        }
      }
    }
    
    public override function GetName():String
    {
      return "Player";
    }
    
    public function GetDiamondTime():Number
    {
      return m_SuperPowerTime / 150;
    }
    
    public function GetSpeed():Number
    {
      return m_Speed;
    }
    
    public function GetAngle():Number
    {
      return m_Angle;
    }
    
    private function OnMouseDown(e:MouseEvent):void
    {
      m_Moving = true;
      graphics.clear();
      m_Hammer.graphics.clear();
      m_Dude.graphics.clear();
      DrawMoving();
      stage.dispatchEvent(new Event("StartMoving"));
    }
    
    private function Draw():void
    {
      var scale:Matrix = new Matrix();
      
      scale.scale(3, 3);
      scale.translate(-Resources.Jackhammer.width * 3 / 2, -Resources.Jackhammer.height * 3 / 2);
      m_Hammer.graphics.beginBitmapFill(Resources.Jackhammer.bitmapData, scale, false);
      m_Hammer.graphics.drawRect(-Resources.Jackhammer.width * 3 / 2, -Resources.Jackhammer.height * 3 / 2, Resources.Jackhammer.width * 3, Resources.Jackhammer.height * 3);
      m_Hammer.graphics.endFill();
      
      var trans:Matrix = new Matrix();
      trans.scale(3, 3);
      var ypos:Number = -Resources.JackStand.height * 3 + 25;
      trans.translate( - Resources.Jack.width * 3 / 2, ypos);
      m_Dude.graphics.beginBitmapFill(Resources.JackStand.bitmapData, trans, false);
      m_Dude.graphics.drawRect(- Resources.Jack.width * 3 / 2, ypos, Resources.Jack.width * 3, Resources.Jack.height * 3);
      m_Dude.graphics.endFill();
      
      m_HitTest.graphics.beginFill(0x53DBF2, 0.8);
      m_HitTest.graphics.drawCircle(0, Resources.Jackhammer.height * 3 / 2, 5);
      m_HitTest.graphics.endFill();
    }
    
    private function DrawMoving():void
    {
      var scale:Matrix = new Matrix(); 
      
      scale.scale(3, 3);
      scale.translate(-Resources.Jackhammer.width * 3 / 2, -Resources.Jackhammer.height * 3 / 2);
      m_Hammer.graphics.beginBitmapFill(Resources.Jackhammer.bitmapData, scale, false);
      m_Hammer.graphics.drawRect(-Resources.Jackhammer.width * 3 / 2, -Resources.Jackhammer.height * 3 / 2, Resources.Jackhammer.width * 3, Resources.Jackhammer.height * 3);
      m_Hammer.graphics.endFill();
      
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