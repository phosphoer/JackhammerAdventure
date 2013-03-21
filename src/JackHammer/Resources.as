package JackHammer 
{
  import flash.display.Bitmap;
	/**
   * ...
   * @author David Evans
   */
  public final class Resources 
  {
    [Embed (source = "../../res/TileRock.png")]
    private static const TileRockClass:Class;
    public static const TileRock:Bitmap = new TileRockClass() as Bitmap;
    
    [Embed (source = "../../res/TileRockDeep.png")]
    private static const TileRockDeepClass:Class;
    public static const TileRockDeep:Bitmap = new TileRockDeepClass() as Bitmap;
    
    [Embed (source = "../../res/TileRockDug.png")]
    private static const TileRockDugClass:Class;
    public static const TileRockDug:Bitmap = new TileRockDugClass() as Bitmap;
    
    [Embed (source = "../../res/Jackhammer.png")]
    private static const JackhammerClass:Class;
    public static const Jackhammer:Bitmap = new JackhammerClass() as Bitmap;
    
    [Embed (source = "../../res/Jack.png")]
    private static const JackClass:Class;
    public static const Jack:Bitmap = new JackClass() as Bitmap;
    
    [Embed (source = "../../res/JackStand.png")]
    private static const JackStandClass:Class;
    public static const JackStand:Bitmap = new JackStandClass() as Bitmap;
    
    [Embed (source = "../../res/Bubble.png")]
    private static const BubbleClass:Class;
    public static const Bubble:Bitmap = new BubbleClass() as Bitmap;
    
    [Embed (source = "../../res/Lava.png")]
    private static const LavaClass:Class;
    public static const Lava:Bitmap = new LavaClass() as Bitmap;
  }

}