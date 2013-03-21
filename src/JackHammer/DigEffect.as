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
    
    public function DigEffect() 
    {
      m_Time = 0;
    }
    
    public override function Update(e:Event):void
    {
      var particle2:DugParticle = new DugParticle(30 + Math.random() * 100);
      Engine.Instance.AddObjectToLayer(particle2, 1);
      particle2.x = this.parent.x;
      particle2.y = this.parent.y;
    }
    
  }

}