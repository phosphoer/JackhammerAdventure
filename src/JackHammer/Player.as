package JackHammer 
{
  import flash.display.Graphics;
  import TomatoAS.IComponent;
  
	/**
   * ...
   * @author David Evans
   */
  public class Player extends IComponent
  {
    
    public function Player() 
    {
      graphics.lineStyle(1);
      graphics.beginFill(0x3691AB);
      graphics.drawCircle(0, 0, 30);
      graphics.endFill();
    }
    
  }

}