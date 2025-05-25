class TestClass extends AObject{
	public TestClass(){
		super(25, 25, 25, 25);
		this.angle = Math.PI;
	}

	@Override
	public void tick(){
    this.tryMove(1, 1);
		this.setHitbox(true);
	}
}
