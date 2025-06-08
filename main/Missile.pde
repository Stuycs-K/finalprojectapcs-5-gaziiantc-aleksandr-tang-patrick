class Missile extends AObject {
  private AObject target;
  private float speed = 4;
  private float circleRadius = 100;
  private float circleAngle = 0;
  
  public Missile(double x, double y, AObject target) {
    super(x, y, 35, 5, 0.1);
    this.target = target;
    this.x = target.x + cos(circleAngle) * circleRadius;
    this.y = target.y + sin(circleAngle) * circleRadius;
  }

  @Override
  public void tick(){
    circleAngle += 0.03; 
    double targetX = target.x + cos(circleAngle) * circleRadius;
    double targetY = target.y + sin(circleAngle) * circleRadius;
    
    this.dx = (targetX - x) * 0.1;
    this.dy = (targetY - y) * 0.1;
    this.angle = atan2((float)dy, (float)dx);
    
    if(isPathClear()){
      this.dx = (target.x - x) * 0.2;
      this.dy = (target.y - y) * 0.2;
    }
    
    this.doMovementTick();
    
    for(AObject obj : objects){
      if(obj instanceof ADefense && dist((float)x, (float)y, (float)obj.x, (float)obj.y) < obj.sizeX/2 + 20){
        this.x = 1000000;
        this.y = 1000000;
        if(obj instanceof ADefense){
          ((ADefense)obj).hp -= 40; 
        }
        return;
      }
    }
  }

  public boolean isPathClear(){
    PVector start = new PVector((float)x, (float)y);
    PVector end = new PVector((float)target.x, (float)target.y);
    PVector dir = PVector.sub(end, start);
    float distance = dir.mag();
    dir.normalize();
    for(float d = 0; d < distance; d += 10){
      PVector check = PVector.add(start, PVector.mult(dir, d));
      for(AObject obj : objects){
        if(obj instanceof ADefense && obj != target && PVector.dist(check, new PVector((float)obj.x, (float)obj.y)) < obj.sizeX/2 + 15){
          return false;
        }
      }
    }
    return true;
  }

  @Override
  public void draw() {
    pushMatrix();
    translate((float)x, (float)y);
    rotate((float)angle);
    beginShape();
    tint(255, 255);
    texture(assets.get("laser.png"));
    textureMode(NORMAL);
    vertex(-0.5*sizeX, -0.5*sizeY, 0, 0);
    vertex(0.5*sizeX, -0.5*sizeY, 1, 0);
    vertex(0.5*sizeX, 0.5*sizeY, 1, 1);
    vertex(-0.5*sizeX, 0.5*sizeY, 0, 1);
    endShape();
    popMatrix();
  }
}
