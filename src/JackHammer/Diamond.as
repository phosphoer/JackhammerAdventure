package JackHammer 
{
  import flash.events.Event;
  import flash.geom.Matrix;
  import TomatoAS.Engine;
  import TomatoAS.IComponent;
	/**
   * ...
   * @author David Evans
   */
  public class Diamond extends IComponent
  {
    public function Diamond()
    {
      Draw();
    }
    
    public override function Initialize():void
    {
      Main.Diamonds[Parent.GetID()] = this;
      stage.addEventListener("StartGame", GameStart, false, 0, true);
    }
    
    private function GameStart(e:Event):void
    {
      Parent.Destroy();
    }
    
    public override function Uninitialize():void
    {
      delete Main.Diamonds[Parent.GetID()];
    }
    
    public override function Update(e:Event):void
    {
      if (this.parent.y < Engine.Instance.Camera.y - stage.stageHeight)
        Parent.Destroy();
    }
    
    private function Draw():void
    {
      var size:Number = 3;
      var sizeX:Number = Resources.Diamond.width * size;
      var sizeY:Number = Resources.Diamond.height * size;
      var scale:Matrix = new Matrix();
      scale.scale(size, size);
      scale.translate( -sizeX / 2, - sizeY / 2);
      graphics.beginBitmapFill(Resources.Diamond.bitmapData, scale, false);
      graphics.drawRect( -sizeX / 2, -sizeY / 2, sizeX, sizeY);
      graphics.endFill(); 
    }
  }

}