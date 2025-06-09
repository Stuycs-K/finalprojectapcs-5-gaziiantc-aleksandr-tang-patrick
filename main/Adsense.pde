class Adsense extends ADefense {  
  public static final int maxHP = 15000;
  public float multiplier;
  public Adsense(int x, int y){  
    super(DefenseStats.ADSENSE[0], x, y, DefenseStats.ADSENSE[3], DefenseStats.ADSENSE[4], DefenseStats.ADSENSE[5], DefenseStats.ADSENSE[6]);
    this.multiplier = defenseBaseStats[6];
  }
  @Override
  public void draw(){
    pushMatrix();
    translate((float)this.x, (float)this.y);
    beginShape();
    tint(255, 255);
    texture(assets.get("adsense.jpeg"));
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
       double damage = 1000 * ((Math.abs(obj.dx) + Math.abs(obj.dy)) * obj.mass);
       this.hp -= damage;
       score += (int)(damage * 0.05);
    }
  } 

}
