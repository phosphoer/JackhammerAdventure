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
  public class BackgroundSpace extends Background
  {
    private var m_Stars:Array;
    
    public function BackgroundSpace() 
    {
      m_Stars = new Array();
      var s:Number = Math.floor(Math.random() * 3 + 1);
      
      for (var i:int = 0; i < 50; ++i)
      {
        var star:Sprite = new Sprite();
        m_Stars.push(star);
        addChild(star);
        
        var scale:Matrix = new Matrix();
        scale.scale(s, s);
        star.graphics.beginFill(0xF0F0F0, 0.8);
        star.graphics.drawCircle(0, 0, s);
        star.graphics.endFill();
        
        star.x = star.width + Math.random() * (Background.Width - star.width);
        star.y = Math.random() * Background.Height;
      }
    }
    
    public override function Update(e:Event):void
    {
      for (var i:String in m_Stars)
      {
        var star:Sprite = m_Stars[i] as Sprite;
        if (star.x < 0)
          star.x = width;
         
        star.x -= star.width / 8;
      }
    }
    
    protected override function Draw():void
    {
      var rotate:Matrix = new Matrix();
      rotate.createGradientBox(Background.Width, Background.Height, 0);
      graphics.beginGradientFill(GradientType.LINEAR, [0x261E33, 0x353146, 0x261E33], [1, 1, 1], [0, 128, 255], rotate);
      graphics.drawRect(-1, -1, Width + 1, Height + 1);
      graphics.endFill();
    }
    
  }

}