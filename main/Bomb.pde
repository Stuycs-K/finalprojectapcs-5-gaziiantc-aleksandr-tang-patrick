class Bomb extends AObject {  
  public Bomb(double x, double y, AObject where){  
    //super(Math.cos(frameCount / 5) * width * 1.2, Math.sin(frameCount / 5) * height * 1.2, 25, 10, 0.1);
    super(x, y, 20, 20, 100);
    this.dx = (where.x - this.x) / 100;
    this.dy = (where.y - this.y) / 100;
    this.angle = Math.atan(this.dx / this.dy);
  }
  


  @Override 
  public void tick(){  
    this.dx *= 0.999; this.dy *= 0.999; //air resistance (real)
    if(Math.abs(this.dx) < 0.5 && Math.abs(this.dy) < 0.5){  
      this.destroy();
    }
    this.doMovementTick();
  }

  @Override
  public void draw(){  
    pushMatrix();
    translate((float)this.x, (float)this.y);
    beginShape();
    tint(255, (float)((this.dx * this.dx + this.dy * this.dy) * 40) + 20);
    texture(assets.get("laser.png"));
    textureMode(NORMAL);
    vertex(-0.5 * this.sizeX, -0.5 * this.sizeY, 0, 0);
    vertex(0.5 * this.sizeX, -0.5 * this.sizeY, 1, 0);
    vertex(0.5 * this.sizeX, 0.5 * this.sizeY, 1, 1);
    vertex(-0.5 * this.sizeX, 0.5 * this.sizeY, 0, 1);
    rotate((float)this.angle*-1-HALF_PI);
    endShape();
    popMatrix();
  }
  
  public void doCollisionStuff(AObject obj){  
    if(obj.containsAttribute(Attribute.FLAMMABLE)){  
      obj.destroy();
    }

    obj.applyForce(this.dx * this.mass, this.dy * this.mass);
    //this.applyForce(-1 * this.dx, -1 * this.dy);
    
    
    
  }
}
