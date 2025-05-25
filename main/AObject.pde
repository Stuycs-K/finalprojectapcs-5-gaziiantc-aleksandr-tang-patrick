abstract class AObject {
	public int x; public int y;
	public int sizeX; public int sizeY;
	public double angle;

	public Stack<Chunk> chunks; 


  public AObject(int x, int y, int sizex, int sizey){
     this.x = x;
     this.y = y;
     this.sizeX = sizex;
     this.sizeY = sizey;
     this.chunks = new Stack<>();
  }



	public abstract void tick();
  

	/*we're making our own polar coordinate system out here fr
	 180
	  |
	  | 
270-------90 that is to say I add 90 degrees to every angle (divine intellect) (Instead of just making the function work in 360 degrees it will offset the object by sizex and sizey before drawing it, offering improvements in literally nothing, truly I am genius)
	  |
	  |
	  0
	*/

  int getLoc(int x, int y){
    return x/Chunk.size + ((y/Chunk.size) * (width/Chunk.size));
  }

  void drawParaLine(int pX, int pY, int len, double dx, double dy){
    for(int t=-1 * len / 2; t<len / 2; t++){
      if(getLoc((int)(pX + dx * t), (int)(pY + dy * t)) < map.size() && getLoc((int)(pX + dx * t), (int)(pY + dy * t)) > 0){
        map.get(getLoc((int)(pX + dx * t), (int)(pY + dy * t))).taken = true;
        map.get(getLoc((int)(pX + dx * t), (int)(pY + dy * t))).obj = this;
      }
    }
  }

  void drawParaSquare(int pX, int pY, int sX, int sY, double dx, double dy){ //naming standards vs calculus epic rap battles of history
    for(int t=-1 * sX / 2; t<sX / 2; t++){
      drawParaLine((int)(pX + dx * t), (int)(pY + dy * t), sY, dy * -1, dx);
    }
  }
  boolean readParaLine(int pX, int pY, int len, double dx, double dy){
    for(int t=-1 * len / 2; t<len / 2; t++){
      if(getLoc((int)(pX + dx * t), (int)(pY + dy * t)) < map.size() && getLoc((int)(pX + dx * t), (int)(pY + dy * t)) > 0){
        if(map.get(getLoc((int)(pX + dx * t), (int)(pY + dy * t))).taken && map.get(getLoc((int)(pX + dx * t), (int)(pY + dy * t))).obj != this){
          return false;
        }
      }
    }
    return true;
  }

  boolean readParaSquare(int pX, int pY, int sX, int sY, double dx, double dy){
   for(int t=-1 * sX / 2; t<sX / 2; t++){
      if(!readParaLine((int)(pX + dx * t), (int)(pY + dy * t), sY, dy * -1, dx)){
        return false;
      }
    }
    return true;
  }


  public void setHitbox(boolean state){
    if(state){
      drawParaSquare(this.x-this.sizeX, this.y, this.sizeX, this.sizeY, Math.sin(angle), Math.cos(angle));
    }else{
      while(chunks.size() > 0){
        chunks.pop().unTake();
      }
    }
	}

  public boolean tryMove(int dx, int dy){
      if(readParaSquare(this.x + dx, this.y + dy, this.sizeX, this.sizeY, Math.sin(angle), Math.cos(angle))){
        this.x += dx;
        this.y += dy;
        return true;
      }else{
        return false; 
      }
  }
}
