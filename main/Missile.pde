class Missile extends AObject {
  private AObject target;
  private float circleRadius = 200;
  private float circleAngle = 0;
  private boolean hasCompletedCircle = false;
  private boolean isCharging = false;
  
  public Missile(double x, double y, AObject target){
    super(x, y, 35, 5, 0.1);
    this.target = target;
    this.x = target.x + circleRadius;
    this.y = target.y;
  }

  @Override
  public void tick(){
    if (isCharging) {
      this.doMovementTick();
      checkCollision();
      return;
    }
    circleAngle += 0.03;
    double targetX = target.x + cos(circleAngle) * circleRadius;
    double targetY = target.y + sin(circleAngle) * circleRadius;
    this.dx = (targetX - x) * 0.1;
    this.dy = (targetY - y) * 0.1;
    this.angle = atan2((float)dy, (float)dx);
    if(circleAngle >= TWO_PI){
      hasCompletedCircle = true;
    }
    if(hasClearPathToBase() || hasCompletedCircle){
      isCharging = true;
      this.dx = (target.x - x) * 0.25;
      this.dy = (target.y - y) * 0.25;
      this.angle = atan2((float)dy, (float)dx);
    }
    
    this.doMovementTick();
    checkCollision();
  }

  public boolean hasClearPathToBase(){
    PVector start = new PVector((float)x, (float)y);
    PVector end = new PVector((float)target.x, (float)target.y);
    PVector dir = PVector.sub(end, start);
    float distance = dir.mag();
    dir.normalize();
    for(float d = 0; d < distance; d += 5){
      PVector check = PVector.add(start, PVector.mult(dir, d));
      if(PVector.dist(check, end) < target.sizeX/2){
        return true;
      }
      for(AObject obj:objects){
        if(obj instanceof ADefense && obj != target &&  PVector.dist(check, new PVector((float)obj.x, (float)obj.y)) < obj.sizeX/2 + 10){
          return false;
        }
      }
    }
    return true;
  }

  public void checkCollision(){
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

  @Override
  public void draw() {
    if (x > 999999) return;
    
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
