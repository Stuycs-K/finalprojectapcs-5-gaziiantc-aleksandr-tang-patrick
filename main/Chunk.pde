class Chunk {
  public static final int size = 2;

  public int x; public int y; //programming standards my beloved
  public boolean taken;
  public AObject obj;
  
  public Chunk(int x, int y){
    this.x = x;
    this.y = y;
  }

  public void unTake(){
    this.taken = false;
    this.obj = null;
  }
}
