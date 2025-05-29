abstract class ADefense extends AObject {
	
	public ArrayList<Attribute> attribs; 
	public int hp;
	public ADefense(int hp, double x, double y, int sizex, int sizey, double mass){
		super(x, y, sizex, sizey, mass);
		attribs = new ArrayList<>();
		this.hp = hp;
	}

	public void addAttrib(Attribute attrib){	
		attribs.add(attrib);
	}

	public boolean containsAttrib(Attribute attrib){	
		return attribs.contains(attrib);
	}

	public void onHit(AObject obj){
		//do stuff here ig
		//not abstract in case the user wants to leave this blank
	}


  //do not override this unless you REALLY need to
  @Override
  public void collision(AObject obj){
     super.collision(obj);
     onHit(obj);
  }
	
}
