class Block {
  float x,y;
  int size=50;
  color blockColor;
  Block(float x,float y,color c) {
    this.x=x;
    this.y=y;
    this.blockColor=c;
  }
  void display() {
    fill(blockColor);
    rect(x,y,size,size);
  }
}
