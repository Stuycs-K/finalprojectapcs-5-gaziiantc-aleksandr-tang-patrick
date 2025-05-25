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
  private boolean FLAG; //not a fan of the prospect of calling this "edge-flag" so it will be staying ambiguous, with this comment being the only way of knowing what it means.

  public Stack<Chunk> chunks;


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
  }


  public abstract void tick();



  int getLoc(int x, int y) {
    return x/Chunk.size + ((y/Chunk.size) * (width/Chunk.size));
  }

  boolean isOnBorder(int x, int y) {
    return (x > width / Chunk.size) || (x < 0) || (y > height / Chunk.size) || (y < 0);
  }
  boolean isOnBorder(double x, double y) {
    return (x > width - 1) || (x <= 0) || (y > height) || (y < 0);
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
      } else {
        FLAG = true;
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
    AObject obj =  readParaSquare((int)(this.x + dx), (int)(this.y + dy), this.sizeX, this.sizeY, Math.sin(angle), Math.cos(angle));
    if (obj==null) {
      this.x += dx;
      this.y += dy;
      return null;
    } else {
      return obj;
    }
  }


  public void applyForce(double ddx, double ddy) {
    this.ddx += ddx/this.mass;
    this.ddy += ddy/this.mass;
  }

  public void doMovementTick() {
    this.dx += this.ddx;
    this.dy += this.ddy;
    this.ddx = 0;
    this.ddy = 0; //newton's 0th law fr
    AObject obj = this.tryMove(this.dx, this.dy);
    if (obj!=null) {
      obj.applyForce(this.dx * this.mass, this.dy * this.mass);
      this.doCollisionStuff(obj);
      obj.doCollisionStuff(this);
    }
    if (Math.abs(this.dx) < 0.01) {
      this.dx = 0;
    } else if (this.dx > 0) {
      this.dx -= 0.005;
    } else if (this.dx < 0) {
      this.dx += 0.005;
    }

    if (Math.abs(this.dy) < 0.01) {
      this.dy = 0;
    } else if (this.dy > 0) {
      this.dy -= 0.005;
    } else if (this.dx < 0) {
      this.dy += 0.005;
    }

    if (FLAG) {
      this.doOutOfBoundsStuff();
      FLAG = false;
    }
  }



  //THESE ARE FUNCTIONS THAT DO THINGS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  public void doCollisionStuff(AObject other){
    //Not abstract because overriding this just to have it do nothing would be dumb and stupid ok
  }

  public void doOutOfBoundsStuff() {
    
  }
}
