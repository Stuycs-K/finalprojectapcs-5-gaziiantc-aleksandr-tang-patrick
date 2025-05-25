class TestClass extends AObject{
	public TestClass(){
		super(25, 25, 25, 25);
		this.angle = Math.PI;
	}

	@Override
	public void tick(){
		this.setHitbox(true);
	}
}
