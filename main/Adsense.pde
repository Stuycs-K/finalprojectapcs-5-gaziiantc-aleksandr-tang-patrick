class Adsense extends ADefense {  
  public static final int maxHP = 15000;
  public Adsense(int x, int y){  
    super(maxHP, x, y, 50, 50, 3000);
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

}
