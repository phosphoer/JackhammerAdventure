package JackHammer 
{
  import flash.display.Bitmap;
	/**
   * ...
   * @author David Evans
   */
  public final class Resources 
  {
    
    [Embed (source = "../../res/tile.png")]
    private static const TileClass:Class;
    public static const Tile:Bitmap = new TileClass() as Bitmap;
    
  }

}