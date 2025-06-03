class BlackHole extends ADefense {  
  public static final int maxHP = 15000;
  public BlackHole(int x, int y){  
    super(maxHP, x, y, 50,50, 3000);
    this.duration = 5000; 
  }
  @Override
  public void doCollisionStuff(AObject obj){  
    this.applyForce(obj.dx * obj.mass, obj.dy * obj.mass);
    this.dx *= 0.7; this.dy *= 0.7;
    obj.dx *= -1; obj.dy *= -1;
  }
  @Override
  public void draw(){
    if (isActive()) {
      fill(0);
      pushMatrix();
      translate((float)this.x, (float)this.y);
      rotate((float)this.angle*-1-HALF_PI);
      rectMode(CENTER);
      ellipse(0, 0, (float)this.sizeX, (float)this.sizeY);
      popMatrix();
    }
  }
  @Override
  public void tick(){  
    if (!isActive()) {
      objects.remove(this);
      return;
    }
   this.doMovementTick();
  }
    public void onHit(AObject obj){
      obj.x=10000000;
      obj.y=10000000;
  }
}
