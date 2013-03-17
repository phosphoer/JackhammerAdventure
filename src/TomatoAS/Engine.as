package TomatoAS 
{
  import flash.system.System;
  import flash.utils.Dictionary;
	/**
	 * ...
	 * @author David Evans
	 */
	public class Engine 
	{
    private var m_Systems:Dictionary;
    
		public function Engine() 
		{
			m_Systems = new Dictionary();
		}
    
    public function AddSystem(system:System)
    {
      m_Systems[system.GetName()] = system;
    }
    
    public function GetSystem(systemName:String):System
    {
      return m_Systems[systemName];
    }
		
    public function Start()
    {
      
    }
	}

}