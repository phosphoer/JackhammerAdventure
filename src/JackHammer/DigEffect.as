package JackHammer 
{
  import flash.events.Event;
  import TomatoAS.Engine;
  import TomatoAS.IComponent;
	/**
   * ...
   * @author David Evans
   */
  public class DigEffect extends IComponent
  {
    private var m_Time:Number;
    private var m_Started:Boolean;
    
    public function DigEffect() 
    {
      m_Time = 0;
      m_Started = false;
    }
    
    public override function Initialize():void
    {
      stage.addEventListener("StartMoving", Start, false, 0, true);
    }
    
    public override function Uninitialize():void
    {
      stage.removeEventListener("StartMoving", Start);
    }
    
    private function Start(e:Event):void
    {
      m_Started = true;
    }
    
    public override function Update(e:Event):void
    {
      if (m_Started)
      {
        var particle2:DugParticle = new DugParticle(100);
        Engine.Instance.AddObjectToLayer(particle2, 1);
        particle2.x = this.parent.x;
        particle2.y = this.parent.y;
      }
    }
    
  }

}