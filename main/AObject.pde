abstract class AObject {
  public double x;
  public double y;
  public int sizeX;
  public int sizeY;
  public double angle;

  public double dx;
  public double dy;
  public double ddx;
  public double ddy;
  //vector2f or whatever processing calls it is for the weak
  public double mass;
  public int FLAGx; //not a fan of the prospect of calling this "edgeFlag" so it will be staying ambiguous, with this comment being the only way of knowing what it means.
  public int FLAGy;

  public color clr;

  public Stack<Chunk> chunks;
  public int iframes;

  public static final double FRICTION_CONST = 1;

  public ArrayList<Attribute> attributes; 


  public AObject(double x, double y, int sizex, int sizey, double mass) {
    this.x = x;
    this.y = y;
    this.sizeX = sizex;
    this.sizeY = sizey;
    this.mass = mass;
    this.chunks = new Stack<>();
    this.dx = 0;
    this.dy = 0;
    this.ddx = 0;
    this.ddy = 0;
    this.clr = color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
    iframes = 0;
    this.attributes = new ArrayList<>();
  }


  public abstract void tick();

  public abstract void draw();


  public void addAttrib(Attribute attrib){	
	  attributes.add(attrib);
  }

  public boolean containsAttribute(Attribute attrib){	
	  return attributes.contains(attrib);
  }
  int getLoc(int x, int y) {
    return (x-bounds[0])/Chunk.size + (((y-bounds[1])/Chunk.size) * ((bounds[2]-bounds[0])/Chunk.size));
  }

  boolean isOnBorder(double x, double y) {
    if((x >= (bounds[2] - 10)) || (x <= (bounds[0] + 10))){
      FLAGx++;
      if((y >= bounds[3] -10) || (y <= bounds[1] + 10)) FLAGy++;
      return true;
    }else if((y >= bounds[3]-10) || (y <= bounds[1] + 10)){
      FLAGy++;
      if((x >= bounds[2] - 10) || (x <= bounds[0] + 10)) FLAGx++;
      return true;
    }
    return false;
  }
  void drawParaLine(int pX, int pY, int len, double dx, double dy) {
    for (int t=-1 * len / 2; t<len / 2; t++) {
      if (!isOnBorder(pX + dx * t, pY + dy * t)) {
        if (getLoc((int)(pX + dx * t), (int)(pY + dy * t)) < map.size() && getLoc((int)(pX + dx * t), (int)(pY + dy * t)) > 0) {
          map.get(getLoc((int)(pX + dx * t), (int)(pY + dy * t))).taken = true;
          map.get(getLoc((int)(pX + dx * t), (int)(pY + dy * t))).obj = this;
        }
      }
    }
  }

  void drawParaSquare(int pX, int pY, int sX, int sY, double dx, double dy) { //naming standards vs calculus epic rap battles of history
    for (int t=-1 * sX / 2; t<sX / 2; t++) {
      drawParaLine((int)(pX + dx * t), (int)(pY + dy * t), sY, dy * -1, dx);
    }
  }
  AObject readParaLine(int pX, int pY, int len, double dx, double dy) {
    for (int t=-1 * len / 2; t<len / 2; t++) {
      if (!isOnBorder(pX + dx * t, pY + dy * t)) {
        if (getLoc((int)(pX + dx * t), (int)(pY + dy * t)) < map.size() && getLoc((int)(pX + dx * t), (int)(pY + dy * t)) > 0) {
          if (map.get(getLoc((int)(pX + dx * t), (int)(pY + dy * t))).taken && map.get(getLoc((int)(pX + dx * t), (int)(pY + dy * t))).obj != this) {
            return map.get(getLoc((int)(pX + dx * t), (int)(pY + dy * t))).obj;
          }
        }
      }
    }
    return null;
  }

  AObject readParaSquare(int pX, int pY, int sX, int sY, double dx, double dy) {
    for (int t=-1 * sX / 2; t<sX / 2; t++) {
      AObject obj = readParaLine((int)(pX + dx * t), (int)(pY + dy * t), sY, dy * -1, dx);
      if (obj != null) {
        return obj;
      }
    }
    return null;
  }


  public void setHitbox(boolean state) {
    if (state) {
      drawParaSquare((int)this.x, (int)this.y, this.sizeX, this.sizeY, Math.sin(angle), Math.cos(angle));
    } else {
      while (chunks.size() > 0) {
        chunks.pop().unTake();
      }
    }
  }

  public AObject tryMove(double dx, double dy) {
	this.y += dy;
	this.x += dx;
    AObject obj =  readParaSquare((int)(this.x), (int)(this.y), this.sizeX, this.sizeY, Math.sin(angle), Math.cos(angle));
    if (obj==null) {
      return null;
    } else {
	  //doing it this way will reuslt in stuff pushing maybe?

      return obj;
    }
  }


  public void applyForce(double ddx, double ddy) {
    if(iframes <= 0){
      this.ddx += ddx/this.mass;
      this.ddy += ddy/this.mass;
    }
  }

  public void doMovementTick() {
    this.dx += this.ddx;
    this.dy += this.ddy;
    this.ddx = 0;
    this.ddy = 0; //newton's 0th law fr
    AObject obj = this.tryMove(this.dx, this.dy);
    if (obj!=null) {
      this.collision(obj);
      obj.collision(this);
      
    }
    if (Math.abs(this.dx) < 0.01) {
      this.dx = 0;
    } else if (this.dx > 0) {
      this.dx -= 0.005 * FRICTION_CONST;
    } else if (this.dx < 0) {
      this.dx += 0.005 * FRICTION_CONST;
    }

    if (Math.abs(this.dy) < 0.01) {
      this.dy = 0;
    } else if (this.dy > 0) {
      this.dy -= 0.005 * FRICTION_CONST;
    } else if (this.dx < 0) {
      this.dy += 0.005 * FRICTION_CONST;
    }

    this.doBoundsStuff();
    FLAGx = 0; FLAGy = 0;
    iframes--;
  }



  //THESE ARE FUNCTIONS THAT DO THINGS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  public void doCollisionStuff(AObject other){
    //Not abstract because overriding this just to have it do nothing would be dumb and stupid ok
  }

  public void doBoundsStuff() {
    
  }
  
  //do not override this unless you REALLY need to
  public void collision(AObject obj){
     doCollisionStuff(obj);
  }

  public void destroy(){	
	this.x = 10000;
	this.y = 10000; 
	//game loop should remove objects that are significantly out of bounds like this one
  }
  
}
