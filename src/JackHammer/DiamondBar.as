package JackHammer 
{
  import flash.display.Sprite;
	/**
   * ...
   * @author David Evans
   */
  public class DiamondBar extends Sprite
  {
    private var m_Percent:Number;
    
    public function DiamondBar()
    {
      m_Percent = 0;
      Draw();
    }
    
    public function Update(percent:Number):void
    {
      m_Percent = percent;
      graphics.clear();
      Draw();
    }
    
    private function Draw():void
    {
      graphics.beginFill(0x03211D);
      graphics.drawRect(0, 0, 300, 30);
      graphics.endFill();
      
      graphics.beginFill(0x6DF3DF);
      graphics.drawRect(2, 2, 298 * m_Percent, 28);
      graphics.endFill();
    }
  }

}