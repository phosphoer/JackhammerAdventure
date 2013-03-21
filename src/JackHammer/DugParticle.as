package JackHammer 
{
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Matrix;
	/**
   * ...
   * @author David Evans
   */
  public class DugParticle extends Sprite
  {
    private var m_Life:Number;
    private var m_Size:Number;
    
    public function DugParticle(life:Number) 
    {
      m_Life = life;
      m_Size = Math.random() * 20 + 40;
      
      graphics.beginFill(0x38221B);
      //var scale:Matrix = new Matrix();
      //scale.scale(6, 6);
      //graphics.beginBitmapFill(Resources.TileRockDug.bitmapData, scale);
      graphics.drawCircle(0, 0, m_Size);
      graphics.endFill();
      
      scaleX = 0.3;
      scaleY = 0.3;
      
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
        
      if (scaleX < 1)
        scaleX += 0.1;
      if (scaleY < 1)
        scaleY += 0.1;
    }
    
  }

}