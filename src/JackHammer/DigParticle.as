package JackHammer 
{
  import flash.display.Sprite;
  import flash.events.Event;
	/**
   * ...
   * @author David Evans
   */
  public class DigParticle extends Sprite
  {
    private var m_Life:Number;
    private var m_Speed:Number;
    
    public function DigParticle(life:Number) 
    {
      m_Life = life;
      m_Speed = 0.1 + Math.random() * 10;
      var size:Number = Math.random() * 10 + 5;
      
      graphics.beginFill(0xA4733E);
      graphics.drawCircle(0, 0, size);
      graphics.endFill();
      
      var cone:Number = 45;
      rotation = (270 - cone) + Math.random() * cone * 2;
      
      addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
      addEventListener(Event.REMOVED_FROM_STAGE, Uninitialize, false, 0, true);
    }
    
    private function Uninitialize(e:Event):void
    {
      removeEventListener(Event.ENTER_FRAME, Update);
      removeEventListener(Event.REMOVED_FROM_STAGE, Uninitialize);
    }
    
    private function Update(e:Event):void
    {
      m_Life -= 1;
      if (m_Life <= 0)
        parent.removeChild(this);
        
      x += Math.cos((rotation / 180) * Math.PI) * m_Speed;
      y += Math.sin((rotation / 180) * Math.PI) * m_Speed;
      m_Speed *= 0.99;
    }
    
  }

}