class MainBase extends ADefense {
	public static final int maxHP = 10000;
	public MainBase(int x, int y){
		super(maxHP, x, y, 50, 50, 25000); //can't really be moved the first time it gets hit
		this.clr = color(0);
	}
  @Override
  public void doCollisionStuff(AObject obj){
    this.applyForce(obj.dx * obj.mass * 0.5, obj.dy * obj.mass * 0.5);
    if(!obj.containsAttribute(Attribute.HEAVY)){
      obj.dx *= -1; obj.dy *= -1;
      obj.x += obj.dx; obj.y += obj.dy;
    }
  }
	public void onHit(AObject obj){	
    if(!(obj instanceof ADefense)){
  		this.hp -= (Math.abs(obj.dx) + Math.abs(obj.dy)) * obj.mass;
      print("hit " + this.hp);
  		if(this.hp > 0){
  			//it gets weaker as it takes more damage n stuff
  			this.mass = 2000 * (double)this.hp/maxHP + 500; 
  			this.clr = color((int)((maxHP-hp) * (200.0d/maxHP)), (int)((maxHP-hp) * (200.0d/maxHP)), (int)((maxHP-hp) * (200.0d/maxHP)));
  		}
    }
    


	}

  @Override
  public void tick(){
     this.doMovementTick(); 
     this.angle += this.dx / 180 * 3.14;
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

  @Override
  public void doBoundsStuff(){ 
     if(this.x > bounds[2] - (this.sizeX/2 * Math.cos(this.angle))){
        this.x -= this.sizeX/2; 
         dx = -0.9 * dx;
     }else if(this.x < bounds[0] + (this.sizeX/2 * Math.cos(this.angle))){
        this.x += this.sizeX/2; 
        dx = -0.9 * dx;
     }
     if(this.y > bounds[3] - (this.sizeY/2 * Math.sin(this.angle))){
        this.y -= this.sizeY/2; 
         dy = -0.9 * dy;
     }else if(this.y < bounds[1] + (this.sizeY/2 * Math.sin(this.angle)-5) + sHeight){
        this.y += this.sizeY/2; 
        dy = -0.9 * dy;
     }
          
  }

}
