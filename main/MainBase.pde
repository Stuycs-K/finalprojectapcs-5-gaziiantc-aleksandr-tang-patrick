class MainBase extends ADefense {
	public static final int maxHP = 10000;
	public MainBase(int x, int y){
		super(100, x, y, 50, 50, 25000); 
		this.clr = color(0);
	}

	public void onHit(AObject obj){	
    this.applyForce(obj.dx * obj.mass, obj.dy * obj.mass);
    this.dx *= 0.5; this.dy *= 0.5;
		this.hp -= (obj.dx + obj.dy) * obj.mass / 250;
    print("hit");
		if(this.hp > 0){
			//it gets weaker as it takes more damage n stuff
			this.mass = 25000 * (this.hp/100); 
      print("mass changed");
			this.clr = color(255 - hp * 2.55, 255 - hp * 2.55, 255 - hp * 2.55);
		}
    obj.dx *= -1; obj.dy *= -1;


	}

  @Override
  public void tick(){
     this.doMovementTick(); 
  }
  
  @Override
  public void draw(){
    fill(this.clr);
    pushMatrix();
    translate((float)this.x, (float)this.y);
    rotate((float)this.angle*-1-HALF_PI);
    rectMode(CENTER);
    rect(0, 0, (float)this.sizeX, (float)this.sizeY);
    popMatrix();
  }

}
