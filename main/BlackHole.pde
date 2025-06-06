class BlackHole extends ADefense {  
  public static final int maxHP = 15000;
  static final int duration = 5000;
  public BlackHole(int x, int y, int spawnTime){  
    super(maxHP, x, y, 50,50, 3000,50);
    this.spawnTime = spawnTime;
  }
  @Override
  public void doCollisionStuff(AObject obj){  
    this.applyForce(obj.dx * obj.mass, obj.dy * obj.mass);
    this.dx *= 0.7; this.dy *= 0.7;
    obj.dx *= -1; obj.dy *= -1;
  }
  @Override
  public void draw(){
    if (millis()-spawnTime < duration) {
      fill(0);
      pushMatrix();
      translate((float)this.x, (float)this.y);
      rotate((float)this.angle*-1-HALF_PI);
      //rectMode(CENTER);
      ellipse(0, 0, (float)this.sizeX, (float)this.sizeY);
      popMatrix();
    }
  }
  @Override
  public void tick(){  
    if (millis()-spawnTime > duration) {
      objects.remove(this);
      return;
    }
   this.doMovementTick();
  }
    public void onHit(AObject obj){
     if(!(obj instanceof ADefense)){
       double damage = 1000 * ((Math.abs(obj.dx) + Math.abs(obj.dy)) * obj.mass);
       score += (int)(damage * 0.05);
    }
      obj.x=10000000;
      obj.y=10000000;
  }
}
