package JackHammer 
{ 
  import flash.display.Bitmap;
  import flash.events.Event;
  import TomatoAS.IComponent;
  import TomatoAS.Engine;
  
	/**
   * ...
   * @author David Evans
   */
  public class Background1 extends IComponent
  {
    
    public function Background1() 
    {
      cacheAsBitmap = true;
    }
    
    public override function Initialize():void
    {
      Draw();
      Parent.SetZOrder(0);
    }
    
    public override function Update(e:Event):void
    {
      if (this.parent.y < Engine.Instance.Camera.y - this.height * 2)
        Parent.Destroy();
    }
    
    private function Draw():void
    {
      graphics.beginFill(0x543318);
      graphics.drawRect(0, 0, stage.stageWidth * 2, stage.stageHeight * 5);
      graphics.endFill();
      
      for (var i:int = 0; i < 100; ++i)
      {
        var size:Number = Math.random() * 40 + 10;
        var xpos:Number = Math.random() * stage.stageWidth * 2;
        var ypos:Number = size + Math.random() * (stage.stageHeight * 5 - size * 2);
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