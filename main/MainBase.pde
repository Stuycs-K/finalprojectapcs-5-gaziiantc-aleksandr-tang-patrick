class MainBase extends ADefense {
	
	public MainBase(int x, int y){
		super(100, x, y, 50, 50, 25000); 
		this.clr = color(0);
	}

	public void onHit(AObject obj){	
		this.hp -= (obj.dx + obj.dy) * obj.mass;
		if(this.hp > 0){
			//it gets weaker as it takes more damage n stuff
			this.mass = 25000 * (this.hp/100);
			this.clr = color(255 - hp * 2.55, 255 - hp * 2.55, 255 - hp * 2.55);
		}else{	
			System.exit(1); //TODO: make actual end screen instead of this. 
		}

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
