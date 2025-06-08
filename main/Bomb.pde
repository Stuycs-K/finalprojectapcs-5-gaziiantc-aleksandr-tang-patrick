class Bomb extends AObject {  
  public float explosionRadius = 100;
  public float damage = 300;
  public Bomb(double x, double y, AObject where){  
    //super(Math.cos(frameCount / 5) * width * 1.2, Math.sin(frameCount / 5) * height * 1.2, 25, 10, 0.1);
    super(x, y, 20, 20, 200);
    this.dx = (where.x - this.x) / 100;
    this.dy = (where.y - this.y) / 100;
    this.angle = Math.atan(this.dx / this.dy);
  }
  


  @Override 
  public void tick(){  

    this.doMovementTick();
    for(AObject obj:objects){
      if(obj!=this && dist((float)x, (float)y, (float)obj.x, (float)obj.y) < obj.sizeX/2 + sizeX/2){
        explode();
        return;
      }
    }
  }

  @Override
  public void draw(){  
    pushMatrix();
    translate((float)this.x, (float)this.y);
    rotate((float)this.angle);
    fill(255, 100, 0);
    ellipse(0, 0, sizeX, sizeY);
    popMatrix();
  }
  
  public void doCollisionStuff(AObject obj){  
    explode();
  }
  public void explode() {
    for(AObject obj : objects){
      if(obj != this){
        float distance = dist((float)x, (float)y, (float)obj.x, (float)obj.y);
        if(distance<explosionRadius){
          float scaledDamage = damage * (1 - distance/explosionRadius);
          if (obj instanceof ADefense){
            ((ADefense)obj).hp -= scaledDamage;
          }
          PVector forceDir = new PVector((float)(obj.x - x),(float)(obj.y - y)).normalize();
          obj.applyForce(forceDir.x * 50, forceDir.y * 50);
        }
      }
    }
    objects.add(new ExplosionEffect(x, y, explosionRadius));
    this.destroy();
  }
}
