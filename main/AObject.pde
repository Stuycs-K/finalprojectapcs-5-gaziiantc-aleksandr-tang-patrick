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



public void setHitbox(boolean state){
  double tempAngle = angle - Math.PI/2;
		if(state){
		  drawParaSquare(this.x, this.y, this.sizeX, this.sizeY, Math.sin(tempAngle), Math.cos(tempAngle));
    }else{
			while(chunks.size() > 0){
				chunks.pop().taken=false;
			}
		}
	}
}
