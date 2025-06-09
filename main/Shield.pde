class Shield extends ADefense {  
  public static final int maxHP = 15000;
  public int spawnTime;
  public float duration;
  public Shield(int x, int y, int spawnTime){  
    super(DefenseStats.SHIELD[0], x, y, DefenseStats.SHIELD[3], DefenseStats.SHIELD[4], DefenseStats.SHIELD[5], DefenseStats.SHIELD[6]);
    this.duration = defenseBaseStats[4];
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
      pushMatrix();
      translate((float)this.x, (float)this.y);
      beginShape();
      tint(255, 127);
      texture(assets.get("shield.jpg"));
      textureMode(NORMAL);
      vertex(-0.5 * this.sizeX, -0.5 * this.sizeY, 0, 0);
      vertex(0.5 * this.sizeX, -0.5 * this.sizeY, 1, 0);
      vertex(0.5 * this.sizeX, 0.5 * this.sizeY, 1, 1);
      vertex(-0.5 * this.sizeX, 0.5 * this.sizeY, 0, 1);
      rotate((float)this.angle*-1-HALF_PI);
      endShape();
      popMatrix();
     }
  }
  @Override
  public void tick(){  
    if(millis()-spawnTime > duration) {
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
  }

}
