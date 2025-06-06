class TestDefense extends ADefense{
	public TestDefense(){
		super(25, 25, 25, 25, 25, 250,50);
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
		rotate((float)this.angle*-1-HALF_PI);
		rectMode(CENTER);
		rect(0, 0, (float)this.sizeX, (float)this.sizeY);
		popMatrix();
	}

	@Override
	public void onHit(AObject obj){
    this.applyForce(obj.dx * obj.mass, obj.dy * obj.mass);
		obj.dx *= -1; obj.dy *= -1;
    this.dx *= 0.5; this.dy *= 0.5;
	}

	//notice how I didnt override doCollisionStuff or doBoundsStuff :shocked:
}
