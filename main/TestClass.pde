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
  public void doCollisionStuff(AObject other){
    other.dx *= 0.5;
    other.dy *= 0.5;
  }
  
  @Override
  public void doOutOfBoundsStuff(){
     double temp = this.dx;
     this.dx = this.dy * -1;
     this.dy = temp;
  }
}
