class WallWooden extends ADefense {	
	public static final int maxHP = 5000;
	public WallWooden(int x, int y){	
		super(maxHP, x, y, 60, 20, 1000);
    this.attributes.add(Attribute.FLAMMABLE);
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
    pushMatrix();
    translate((float)this.x, (float)this.y);
    beginShape();
    tint(255, 255);
    texture(assets.get("woodwall.jpg"));
    textureMode(NORMAL);
    vertex(-0.5 * this.sizeX, -0.5 * this.sizeY, 0, 0);
    vertex(0.5 * this.sizeX, -0.5 * this.sizeY, 1, 0);
    vertex(0.5 * this.sizeX, 0.5 * this.sizeY, 1, 1);
    vertex(-0.5 * this.sizeX, 0.5 * this.sizeY, 0, 1);
    rotate((float)this.angle*-1-HALF_PI);
    endShape();
    popMatrix();
  }
	@Override
	public void tick(){	
		this.doMovementTick();
	}
}
