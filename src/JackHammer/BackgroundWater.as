package JackHammer 
{
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Matrix;
  import flash.display.GradientType;
	/**
   * ...
   * @author David Evans
   */
  public class BackgroundWater extends Background
  {
    private var m_Bubbles:Array;
    
    public function BackgroundWater() 
    {
      m_Bubbles = new Array();
      var s:Number = Math.floor(Math.random() * 3 + 0.5);
      
      for (var i:int = 0; i < 30; ++i)
      {
        var bubble:Sprite = new Sprite();
        m_Bubbles.push(bubble);
        addChild(bubble);
        
        var scale:Matrix = new Matrix();
        scale.scale(s, s);
        bubble.graphics.beginBitmapFill(Resources.Bubble.bitmapData, scale);
        bubble.graphics.drawRect(0, 0, Resources.Bubble.width * s, Resources.Bubble.height * s);
        bubble.graphics.endFill();
        
        bubble.x = bubble.width + Math.random() * (Background.Width - bubble.width);
        bubble.y = Math.random() * Background.Height;
      }
    }
    
    public override function Update(e:Event):void
    {
      for (var i:String in m_Bubbles)
      {
        var bubble:Sprite = m_Bubbles[i] as Sprite;
        if (bubble.y < 0)
          bubble.y = height;
         
        bubble.y -= bubble.width / 8;
      }
    }
    
    protected override function Draw():void
    {
      var rotate:Matrix = new Matrix();
      rotate.createGradientBox(Background.Width, Background.Height, Math.PI / 2);
      graphics.beginGradientFill(GradientType.LINEAR, [0x1B464B, 0x56BAC5, 0x1B464B], [1, 1, 1], [0, 128, 255], rotate);
      graphics.drawRect(-1, -1, Width + 1, Height + 1);
      graphics.endFill();
    }
    
  }

}