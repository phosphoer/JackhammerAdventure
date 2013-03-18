package JackHammer 
{
  import TomatoAS.IComponent;
	/**
   * ...
   * @author David Evans
   */
  public class Rock extends IComponent
  {
    
    public function Rock()
    {
      Draw();
    }
    
    
    private function Draw():void
    {
      graphics.lineStyle(1);
      graphics.beginFill(0xA4733E);
      graphics.drawCircle(0, 0, 40);
      graphics.endFill(); 
    }
  }

}