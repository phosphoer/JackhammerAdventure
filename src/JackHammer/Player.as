package JackHammer 
{
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.geom.Matrix;
  import flash.ui.Keyboard;
  import TomatoAS.GameObject;
  import TomatoAS.IComponent;
  import TomatoAS.Engine;
  import JackHammer.Resources;
  
	/**
   * ...
   * @author David Evans
   */
  public class Player extends IComponent
  {
    private var m_DestAngle:Number;
    private var m_Angle:Number;
    private var m_DudeAngle:Number;
    private var m_Speed:Number;
    private var m_Moving:Boolean;
    private var m_Score:int;
    private var m_Dude:Sprite;
    private var m_Hammer:Sprite;
    private var m_HitTest:Sprite;
    private var m_SuperPowerTime:int;
    private var m_MouseEnabled:Boolean;
    private var m_TurnLeft:Boolean;
    private var m_TurnRight:Boolean;
    
    public function Player() 
    { 
      m_DestAngle = Math.PI / 2 + Math.random() - 0.5;
      m_Angle = Math.PI / 2 + Math.random() - 0.5;
      m_DudeAngle = Math.PI / 2 + Math.random() - 0.5;
      m_Dude = new Sprite();
      m_Hammer = new Sprite();
      m_HitTest = new Sprite();
      m_Speed = 5;
      m_Moving = false;
      m_SuperPowerTime = 0;
      m_MouseEnabled = true;
      m_TurnLeft = false;
      m_TurnRight = false;
      Draw();
    }
    
    public override function Initialize():void
    {
      stage.addEventListener(MouseEvent.CLICK, OnMouseDown, false, 0, true);
      stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown, false, 0, true);
      stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp, false, 0, true);
      stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove, false, 0, true);
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
      if (m_MouseEnabled)
      {
        m_DestAngle = Math.atan2(mouseY - this.parent.y, Engine.Instance.MouseWorld.x - this.parent.x);
      }
      else
      {
        if (m_TurnLeft)
          m_DestAngle += 0.3;
        if (m_TurnRight)
          m_DestAngle -= 0.3;
        
        if (m_DestAngle < 0) 
          m_DestAngle = 0;
        if (m_DestAngle > Math.PI)
          m_DestAngle = Math.PI;
      }
      if (!m_Moving)
        m_DestAngle = Math.PI / 2;
        
      m_Angle += (m_DestAngle - m_Angle) / 12;
      m_DudeAngle += (m_DestAngle- m_DudeAngle) / 25;
      
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
          bit.x = parent.x + Math.cos(m_Angle) * 30;
          bit.y = parent.y + Math.sin(m_Angle) * 30;
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
      var endPosY:Number = this.parent.y + 170;
      var percentY:Number = this.parent.y / 10000;
      if (percentY > 1)
        percentY = 1;
      
      Engine.Instance.Camera.x = this.parent.x;
      Engine.Instance.Camera.y = percentY * endPosY + (1 - percentY) * this.parent.y;
      
      // Update score
      m_Score = Math.max(0, this.parent.y);
      
      // Check collision against obstacles
      var i:String;
      for (i in Main.Obstacles)
      {
        // if (this.Parent.TestCollision(Main.Obstacles[i]))
        if (Main.Obstacles[i].Parent.TestCollision(m_HitTest))
        {
          if (m_SuperPowerTime <= 0)
          {
            Parent.Destroy();
            stage.dispatchEvent(new Event("EndGame"));
            break;
          }
          else
          {
            Main.Obstacles[i].Parent.Destroy();
            for (var j:int = 0; j < 35; ++j)
            {
              var lavaPart:LavaParticle = new LavaParticle(20 + Math.random() * 20);
              Engine.Instance.AddObjectToLayer(lavaPart, 3);
              lavaPart.x = Main.Obstacles[i].Parent.x;
              lavaPart.y = Main.Obstacles[i].Parent.y;
            }
          }
        }
      }
      
      // Check collision against diamonds
      for (i in Main.Diamonds)
      {
        // if (this.Parent.TestCollision(Main.Obstacles[i]))
        if (Main.Diamonds[i].Parent.TestCollision(Parent))
        {
          Main.Diamonds[i].Parent.Destroy();
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
    
    private function OnMouseMove(e:MouseEvent):void
    {
      m_MouseEnabled = true;
    }
    
    private function OnKeyDown(e:KeyboardEvent):void  
    {
      m_MouseEnabled = false;
      
      if (e.keyCode == Keyboard.SPACE)
      {
        m_Moving = true;
        graphics.clear();
        m_Hammer.graphics.clear();
        m_Dude.graphics.clear();
        DrawMoving();
        stage.dispatchEvent(new Event("StartMoving"));
        return;
      }
      
      if (e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.D)
        m_TurnRight = true;
      if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.A)
        m_TurnLeft = true;
    }
    
    private function OnKeyUp(e:KeyboardEvent):void  
    {
      if (e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.D)
        m_TurnRight = false;
      if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.A)
        m_TurnLeft = false;
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