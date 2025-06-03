class Train extends AObject{
  public Train(double x, double y, AObject where){
    super(x, y, 350, 125, 1000);
    this.dx = (where.x - this.x) / 30;
    this.dy = (where.y - this.y) / 30;
    this.angle = Math.atan(this.dx / this.dy);
    this.attributes.add(Attribute.HEAVY);
  }

  @Override
  public void tick(){
    this.doMovementTick();
    
  }

  @Override
  public void draw(){
    //fill(this.clr);
    pushMatrix();
    translate((float)this.x, (float)this.y);
    beginShape();
    tint(255, 255);
    texture(assets.get("testclass.png"));
    textureMode(NORMAL);
    vertex(-0.5 * this.sizeX, -0.5 * this.sizeY, 0, 0);
    vertex(0.5 * this.sizeX, -0.5 * this.sizeY, 1, 0);
    vertex(0.5 * this.sizeX, 0.5 * this.sizeY, 1, 1);
    vertex(-0.5 * this.sizeX, 0.5 * this.sizeY, 0, 1);
    rotate((float)this.angle*-1-HALF_PI);
    endShape();

    //rectMode(CENTER); 
    //rect(0, 0, (float)this.sizeX, (float)this.sizeY);
    popMatrix();
    //this language made me religious because clearly hell is real and as a matter of fact im in it right now
}

  @Override
  public void doCollisionStuff(AObject obj){
    //double totaldx = (this.dx * this.mass + obj.dx * obj.mass) / (this.mass + obj.mass);
    //double totaldy = (this.dy * this.mass + obj.dy * obj.mass) / (this.mass + obj.mass);
    //this.x -= this.dx;
    //this.y -= this.dy;
    obj.applyForce(this.dx, this.dy);
    if(obj.mass > 100){
      this.dx *= -1; this.dy *= -1;
      this.x += this.dx; this.y += this.dy;
      this.dx *= 0.25; this.dy *= 0.25;
      
    }
  }
  
  @Override
  public void doBoundsStuff(){ 
          
  }
}
