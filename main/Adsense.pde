class Adsense extends ADefense {  
  public static final int maxHP = 15000;
  public Adsense(int x, int y){  
    super(maxHP, x, y, 50, 50, 3000);
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
