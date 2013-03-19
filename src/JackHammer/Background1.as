package JackHammer 
{ 
  import flash.display.Bitmap;
  import flash.events.Event;
  import flash.utils.Dictionary;
  import TomatoAS.IComponent;
  import TomatoAS.Engine;
  import TomatoAS.GameObject;
  
	/**
   * ...
   * @author David Evans
   */
  public class Background1 extends IComponent
  {
    public var SpawnedBottom:Boolean;
    public var SpawnedLeft:Boolean;
    public var SpawnedRight:Boolean;
    
    public static var Width:int = 1000;
    public static var Height:int = 2000;
    
    private static var Count:int;
    
    public function Background1() 
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
    
    private function Draw():void
    {
      graphics.beginFill(0x543318);
      graphics.drawRect(-1, -1, Width + 1, Height + 1);
      graphics.endFill();
      
      for (var i:int = 0; i < 100; ++i)
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