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
  public class Lava extends IComponent
  {
    private var m_Size:Number;
    
    public function Lava()
    {
      m_Size = 2 + Math.random() * 5;
      Draw();
    }
    
    public override function Initialize():void
    {
      Main.Obstacles[Parent.GetID()] = this;
      stage.addEventListener("StartGame", GameStart, false, 0, true);
    }
    
    private function GameStart(e:Event):void
    {
      Parent.Destroy();
    }
    
    public override function Uninitialize():void
    {
      delete Main.Obstacles[Parent.GetID()];
    }
    
    public override function Update(e:Event):void
    {
      if (this.parent.y < Engine.Instance.Camera.y - stage.stageHeight)
        Parent.Destroy();
    }
    
    private function Draw():void
    {
      var sizeX:Number = Resources.Lava.width * m_Size;
      var sizeY:Number = Resources.Lava.height * m_Size;
      var scale:Matrix = new Matrix();
      scale.scale(m_Size, m_Size);
      scale.translate( -sizeX / 2, - sizeY / 2);
      graphics.beginBitmapFill(Resources.Lava.bitmapData, scale, false);
      graphics.drawRect( -sizeX / 2, -sizeY / 2, sizeX, sizeY);
      graphics.endFill(); 
    }
  }

}