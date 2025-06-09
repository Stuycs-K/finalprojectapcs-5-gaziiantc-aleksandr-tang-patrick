class SheetMetal extends ADefense {  
  public static final int maxHP = 30000;
  public SheetMetal(int x, int y){  
    super(DefenseStats.METAL[0], x, y, DefenseStats.METAL[3], DefenseStats.METAL[4], DefenseStats.METAL[5], DefenseStats.METAL[6]);
  }

  @Override
  public void doCollisionStuff(AObject obj){  
    this.applyForce(obj.dx * obj.mass, obj.dy * obj.mass);
    this.dx *= 0.7; this.dy *= 0.7;
    obj.dx *= -0.7; obj.dy *= -0.7;
  }
  @Override
  public void draw(){
    pushMatrix();
    translate((float)this.x, (float)this.y);
    beginShape();
    tint(255, 255);
    texture(assets.get("sheetmetal.jpg"));
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
    if(hp<=0){
      objects.remove(this);
      return;
    }
    this.doMovementTick();
  }
    public void onHit(AObject obj){  
    if(!(obj instanceof ADefense)){
       double damage = 1000 * ((Math.abs(obj.dx) + Math.abs(obj.dy)) * obj.mass);
       this.hp -= damage;
       score += (int)(damage * 0.05);
    }
  }
}
