abstract class AObject {
	public int x; public int y;
	public int sizeX; public int sizeY;
	public double angle;

	public Stack<Chunk> chunks; 

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
		if(state){
			if(angle > 180){
				drawSlopedRect(x-sizeX, y-sizeY, Math.tan(angle-180), sizeX, sizeY); 				
			}else{
				drawSlopedRect(x, y, Math.tan(angle), sizeX, sizeY);
			}
		}else{
			while(chunks.size() > 0){
				chunks.pop().taken=false;
			}
		}
	}
}
