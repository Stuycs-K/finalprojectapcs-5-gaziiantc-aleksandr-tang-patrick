class ExplosionEffect extends AObject{
  public float radius;
  public float maxRadius;
  public int lifespan = 30;
  
  public ExplosionEffect(double x, double y, float maxRadius){
    super(x, y, 1, 1, 0);
    this.radius = 5;
    this.maxRadius = maxRadius;
  }
  
  @Override
  public void tick(){
    radius += (maxRadius - radius) * 0.2;
    lifespan--;
    if (lifespan <= 0){
      this.destroy();
    }
  }
  
  @Override
  public void draw(){
    pushMatrix();
    translate((float)x, (float)y);
    noFill();
    stroke(255, 150, 0, lifespan * 8);
    strokeWeight(2);
    ellipse(0, 0, radius * 2, radius * 2);
    noStroke();
    popMatrix();
  }
}
