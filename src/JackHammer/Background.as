package JackHammer 
{ 
  import flash.display.Bitmap;
  import flash.events.Event;
  import flash.geom.Matrix;
  import flash.utils.Dictionary;
  import TomatoAS.IComponent;
  import TomatoAS.Engine;
  import TomatoAS.GameObject;
  
	/**
   * ...
   * @author David Evans
   */
  public class Background extends IComponent
  {
    public var SpawnedBottom:Boolean;
    public var SpawnedLeft:Boolean;
    public var SpawnedRight:Boolean;
    
    public static var Width:int = Resources.TileRock.width * 70;
    public static var Height:int = Resources.TileRock.height * 70;
    
    private static var Count:int;
    
    public function Background() 
    {
      cacheAsBitmap = true;
      SpawnedBottom = false;
      SpawnedLeft = false;
      SpawnedRight = false;
    }
    
    public override function Initialize():void
    {
      Draw();
      Parent.SetZOrder(0);
    }
    
    public override function Uninitialize():void
    {
    }
    
    public override function Update(e:Event):void
    {
    }
    
    protected function Draw():void
    {
      var scale:Matrix = new Matrix();
      scale.scale(8, 8);
      graphics.beginBitmapFill(Resources.TileRock.bitmapData, scale);
      graphics.drawRect(-1, -1, Width + 1, Height + 1);
      graphics.endFill();
      
      for (var i:int = 0; i < 0; ++i)
      {
        var size:Number = Math.random() * 40 + 10;
        var xpos:Number = size + Math.random() * (Width - size * 2);
        var ypos:Number = size + Math.random() * (Height - size * 2);
        var rnd:Number = Math.random();
        
        if (rnd < 0.2)
          graphics.beginFill(0xA4733E);
        else if (rnd < 0.4)
          graphics.beginFill(0x825337);
        else if (rnd < 0.6)
          graphics.beginFill(0x7E6750);
        else if (rnd < 0.8)
          graphics.beginFill(0x63453D);
        else
          graphics.beginFill(0x854F3F);
          
        graphics.drawCircle(xpos, ypos, size);
        graphics.endFill(); 
      }
    }
  }

}