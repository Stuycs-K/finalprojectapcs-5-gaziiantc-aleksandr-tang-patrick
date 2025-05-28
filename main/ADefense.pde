abstract class ADefense extends AObject {
	public int hp;
	public ADefense(int hp, double x, double y, int sizex, int sizey, double mass){
		super(x, y, sizex, sizey, mass);
		this.hp = hp;
	}

	public void onHit(AObject obj){
		//do stuff here ig
		//not abstract in case the user wants to leave this blank
	}
	
}
