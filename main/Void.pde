class Void extends ADefense {  
  public static final int maxHP = 15000;
  public Void(int x, int y){  
    super(maxHP, x, y, 25, 25, 3000);
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
    public void onHit(AObject obj){
      obj.x=10000000;
      obj.y=10000000;
            this.x=10000000;
      this.y=10000000;
  }
}
