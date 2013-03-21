package TomatoAS 
{
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.utils.Dictionary;
  import flash.display.BitmapData;
  import flash.geom.Matrix;
  import flash.geom.ColorTransform;
	/**
   * ...
   * @author David Evans
   */
  public class GameObject extends Sprite
  {
    private var m_Components:Dictionary;
    private var m_ID:int;
    private var m_Layer:int = 0;
    private var m_Destroyed:Boolean;
    
    private static var CurrentID:int = 0;
    
    public function GameObject(layer:int) 
    {
      m_ID = CurrentID++;
      m_Layer = layer;
      m_Destroyed = false;
      
      m_Components = new Dictionary();
    }
    
    public function Uninitialize():void
    {
      for (var i:String in m_Components)
      {
        removeChild(m_Components[i]);
      }
    }
    
    public function AddComponent(component:IComponent):void
    {
      m_Components[component.GetName()] = component;
      component.Parent = this;
      addChild(component);
    }
    
    public function GetComponent(componentName:String):IComponent
    {
      return m_Components[componentName];
    }
    
    public function Destroy():void
    {
      if (m_Destroyed)
        return;
      m_Destroyed = true;
      Engine.Instance.DestroyObject(this);
    }
    
    public function GetID():int
    {
      return m_ID;
    }
    
    public function GetLayer():int
    {
      return m_Layer;
    }
    
    public function SetZOrder(index:int):void
    {
      parent.setChildIndex(this, index);
    }
    
    // * Borrowed from 
    // * GTween by Grant Skinner. Aug 1, 2005
    // * Visit www.gskinner.com/blog
    public function TestCollision(obj:DisplayObjectContainer):Boolean
    {
      // set up default params:
      var p_alphaTolerance:int = 255;
      
      // get bounds:
      var bounds1:Rectangle = this.getBounds(root);
      var bounds2:Rectangle = obj.getBounds(root);
      
      // rule out anything that we know can't collide:
      if (((bounds1.right < bounds2.left) || (bounds2.right < bounds1.left)) || ((bounds1.bottom < bounds2.top) || (bounds2.bottom < bounds1.top)) ) 
      {
        return false;
      }
      
      // determine test area boundaries:
      var bounds:Rectangle = new Rectangle();
      bounds.left = Math.max(bounds1.left,bounds2.left);
      bounds.right = Math.min(bounds1.right,bounds2.right);
      bounds.top = Math.max(bounds1.top,bounds2.top);
      bounds.bottom = Math.min(bounds1.bottom,bounds2.bottom);
      
      // set up the image to use:
      if (bounds.width < 1 || bounds.height < 1)
        return false;
        
      var img:BitmapData = new BitmapData(bounds.right - bounds.left, bounds.bottom - bounds.top, false);
      
      // draw in the first image:
      var mat:Matrix = this.transform.concatenatedMatrix;
      mat.tx -= bounds.left;
      mat.ty -= bounds.top;
      img.draw(this,mat, new ColorTransform(1,1,1,1,255,-255,-255,p_alphaTolerance));
      
      // overlay the second image:
      mat = obj.transform.concatenatedMatrix;
      mat.tx -= bounds.left;
      mat.ty -= bounds.top;
      img.draw(obj,mat, new ColorTransform(1,1,1,1,255,255,255,p_alphaTolerance),"difference");
      
      // find the intersection:
      var intersection:Rectangle = img.getColorBoundsRect(0xFFFFFFFF,0xFF00FFFF);
      
      // if there is no intersection, return null:
      if (intersection.width == 0) { return false; }
      
      // adjust the intersection to account for the bounds:
      intersection.x += bounds.left;
      intersection.y += bounds.top;
      
      img.dispose();
      return intersection.width > 0 && intersection.height > 0;
    }
  }

}