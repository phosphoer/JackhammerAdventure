package JackHammer 
{
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.text.TextField;
  import flash.text.TextFormat;
	/**
   * ...
   * @author David Evans
   */
  public class MultiplierText extends Sprite
  {
    private var m_Life:int;
    
    public function MultiplierText(multiplier:Number) 
    {
      var label:TextField = new TextField();
      
      var format:TextFormat = new TextFormat("Arial", 48, 0xffeeee, true);
      label.defaultTextFormat = format;
      label.width = 200;
      
      label.text = "x" + multiplier.toString();
      
      addChild(label);
      
      m_Life = 40;
      
      addEventListener(Event.ENTER_FRAME, Update, false);
    }
    
    private function Update(e:Event):void
    {
      --m_Life;
      x += 1;
      y -= 1;
      
      alpha = (m_Life as Number) / 40;
      if (m_Life <= 0)
      {
        removeEventListener(Event.ENTER_FRAME, Update, false);
        parent.removeChild(this);
      }
    }
    
  }

}