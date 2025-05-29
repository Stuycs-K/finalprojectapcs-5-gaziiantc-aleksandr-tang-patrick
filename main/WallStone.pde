class WallStone extends ADefense {  
  public static final int maxHP = 15000;
  public WallStone(int x, int y){  
    super(maxHP, x, y, 75, 25, 3000);
  }
  @Override
  public void doCollisionStuff(AObject obj){  
    this.applyForce(obj.dx * obj.mass, obj.dy * obj.mass);
    this.dx *= 0.7; this.dy *= 0.7;
    obj.dx *= -1; obj.dy *= -1;
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
