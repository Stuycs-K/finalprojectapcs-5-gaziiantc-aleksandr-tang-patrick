class WallWooden extends ADefense {	
	public static final int maxHP = 5000;
	public WallWooden(int x, int y){	
		super(maxHP, x, y, 60, 20, 1000);
	}
	@Override
	public void doCollisionStuff(AObject obj){	
		this.applyForce(obj.dx * obj.mass, obj.dy * obj.mass);
		this.dx *= 0.7; this.dy *= 0.7;
		obj.dx *= -1; obj.dy *= -1;
		obj.x += obj.dx; obj.y += obj.dy;
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
	public void tick(){	
		this.doMovementTick();
	}
}
