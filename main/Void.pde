class Void extends ADefense {  
  public static final int maxHP = 15000;
  public float radius;
  public Void(int x, int y){  
    super(DefenseStats.VOID[0], x, y, DefenseStats.VOID[3], DefenseStats.VOID[4], DefenseStats.VOID[5], DefenseStats.VOID[6]);
    this.radius = defenseBaseStats[3];
  }
  @Override
  public void draw(){
    pushMatrix();
    translate((float)this.x, (float)this.y);
    beginShape();
    tint(255, 255);
    texture(assets.get("void.png"));
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
    public void onHit(AObject obj){
      if(!(obj instanceof ADefense)){
        obj.destroy();
        this.destroy();
        double damage = 1000 * ((Math.abs(obj.dx) + Math.abs(obj.dy)) * obj.mass);
        score += (int)(damage * 0.05);
      }
  }
}
