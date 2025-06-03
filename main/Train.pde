class Train extends AObject{
  public Train(){
    super(-25, -25, 250, 75, 2500);
    
    this.applyForce((width/2 - this.x) * 100, (height/2-this.y) * 100);
    this.angle = Math.atan((width/2-this.x) / (height/2-this.y));
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
    obj.dx *= -1; obj.dy *= -1;
  }
  
  @Override
  public void doBoundsStuff(){ 
          
  }
}
