class TestClass extends AObject{
	public TestClass(){
		super(25, 25, 25, 25, 25);
		this.angle = Math.PI;
	}

	@Override
	public void tick(){
    this.doMovementTick();
	}

  @Override
  public void draw(){
    fill(this.clr);
    pushMatrix();
    translate((float)this.x, (float)this.y);
    rotate((float)this.angle*-1);
    rectMode(CENTER); 
    rect(0, 0, (float)this.sizeX, (float)this.sizeY);
    popMatrix();
    //this language made me religious because clearly hell is real and as a matter of fact im in it right now
}

  @Override
  public void doCollisionStuff(AObject other){
    other.dx *= 0.9;
    other.dy *= 0.9;
  }
  
  @Override
  public void doBoundsStuff(){ 
     if(this.x > width - this.sizeX/2){
        this.x -= this.sizeX/2; 
         dx = -0.9 * dx;
     }else if(this.x < this.sizeX/2){
        this.x += this.sizeX/2; 
        dx = -0.9 * dx;
     }
     if(this.y > height - this.sizeY/2){
        this.y -= this.sizeY/2; 
         dy = -0.9 * dy;
     }else if(this.y < this.sizeY/2){
        this.y += this.sizeY/2; 
        dy = -0.9 * dy;
     }
          
  }
}
