package JackHammer 
{
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Matrix;
	/**
   * ...
   * @author David Evans
   */
  public class LavaParticle extends Sprite
  {
    private var m_Life:Number;
    private var m_Speed:Number;
    
    public function LavaParticle(life:Number) 
    {
      m_Life = life;
      m_Speed = 0.3 + Math.random() * 15;
      
      var size:Number = 2 + Math.random() * 4;
      var sizeX:Number = Resources.DiamondBit.width * size;
      var sizeY:Number = Resources.DiamondBit.height * size;
      var scale:Matrix = new Matrix();
      scale.scale(size, size);
      scale.translate( -sizeX / 2, - sizeY / 2);
      graphics.beginBitmapFill(Resources.LavaBit.bitmapData, scale, false);
      graphics.drawRect( -sizeX / 2, -sizeY / 2, sizeX, sizeY);
      graphics.endFill(); 
      
      rotation = Math.random() * 360;
      
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