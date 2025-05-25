class TestClass extends AObject{
	public TestClass(){
		super(200, 200, 25, 25);
		this.angle = Math.PI;
	}

	@Override
	public void tick(){
    //this.tryMove(1, 1);
		this.setHitbox(true);
	}
}
