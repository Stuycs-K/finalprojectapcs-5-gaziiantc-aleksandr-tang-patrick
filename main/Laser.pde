class Laser extends AObject {	
	public Laser(){	
		super(Math.cos(frameCount / 5) * width * 1.2, Math.sin(frameCount / 5) * height * 1.2, 25, 10, 10);
		this.dx = (width/2 - this.x) / 60;
		this.dy = (height/2 - this.y) / 60;
		this.angle = Math.atan(this.dx / this.dy);
	}


	@Override 
	public void tick(){	
		this.dx *= 0.999; this.dy *= 0.999; //air resistance (real)
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
	
	public void doCollisionStuff(AObject obj){	
		if(obj.containsAttrib(Attribute.FRAGILE)){	
			obj.destroy();
		}

		this.dx *= 0.5; this.dy *= 0.5;
		obj.dx += this.dx; obj.dy += this.dy;

		if(Math.abs(this.dx) < 0.5 && Math.abs(this.dy) < 0.5){	
			this.destroy();
		}
		
		double temp = this.dy;
		this.dy = this.dx;
		this.dx = temp * -1;

		this.angle = Math.atan(this.dx / this.dy);

	}
}
