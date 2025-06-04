abstract class ADefense extends AObject {
	
	public int hp;
  public long spawnTime;
  public int pointValue;
	public ADefense(int hp, double x, double y, int sizex, int sizey, double mass,int pointValue){
		super(x, y, sizex, sizey, mass);
		attributes = new ArrayList<>();
    //this.spawnTime=millis(); there is 0 reason to have every single object track this.
		this.hp = hp;
    this.pointValue = pointValue;
	}

	

	public void onHit(AObject obj){
		//do stuff here ig
		//not abstract in case the user wants to leave this blank
    double collisionEnergy = obj.mass * Math.sqrt(obj.dx*obj.dx + obj.dy*obj.dy);
    score += (int)(collisionEnergy * 0.1);
  }


  //do not override this unless you REALLY need to
  @Override
  public void collision(AObject obj){
     super.collision(obj);
     onHit(obj);
  }

	
}
