package JackHammer 
{
  import flash.geom.Matrix;
	/**
   * ...
   * @author David Evans
   */
  public class BackgroundDeep extends Background
  {
    
    public function BackgroundDeep() 
    {
      
    }
    
    protected override function Draw():void
    {
      var scale:Matrix = new Matrix();
      scale.scale(8, 8);
      graphics.beginBitmapFill(Resources.TileRockDeep.bitmapData, scale);
      graphics.drawRect(-1, -1, Width + 1, Height + 1);
      graphics.endFill();
      
      for (var i:int = 0; i < 0; ++i)
      {
        var size:Number = Math.random() * 40 + 10;
        var xpos:Number = size + Math.random() * (Width - size * 2);
        var ypos:Number = size + Math.random() * (Height - size * 2);
        var rnd:Number = Math.random();
        
        if (rnd < 0.2)
          graphics.beginFill(0x806240);
        else if (rnd < 0.4)
          graphics.beginFill(0x705849);
        else if (rnd < 0.6)
          graphics.beginFill(0x7E6750);
        else if (rnd < 0.8)
          graphics.beginFill(0x543A34);
        else
          graphics.beginFill(0x5A3F36);
          
        graphics.drawCircle(xpos, ypos, size);
        graphics.endFill(); 
      }
    }
    
  }

}