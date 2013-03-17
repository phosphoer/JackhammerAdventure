package TomatoAS 
{
	/**
   * ...
   * @author David Evans
   */
  public interface ISystem 
  { 
    public function System();
    public function Initialize();
    public function Uninitialize();
    public function Update(dt:Number);
    public function GetName():String;
  }

}