import java.util.*;

List<Chunk> map;
TestClass test;
void setup(){
  size(700, 700, P2D);
  map = new ArrayList<>();
  fill(255);
  for(int x=0; x<width; x+=Chunk.size){
    for(int y=0; y<height; y+=Chunk.size){
      map.add(new Chunk(x, y));
      rect(x, y, Chunk.size, Chunk.size);
    }
  }
  test = new TestClass();
  
}

int getLoc(int x, int y){
  return x/Chunk.size + ((y/Chunk.size) * (width/Chunk.size));
}

void drawParaLine(int pX, int pY, int len, double dx, double dy, AObject obj){
  for(int t=0; t<len; t++){
    map.get(getLoc((int)(x + dx * t), (int)(y + dy * t))).taken = true;
    map.get(getLoc((int)(x + dx * t), (int)(y + dy * t))).obj = obj;
  }
}

void drawParaSquare(int pX, int pY, int sX, int sY, double dx, double dy, AObject obj){ //naming standards vs calculus epic rap battles of history
  for(int x = 0; x<sX; x++){
    drawParaLine(x + pX, pY, sY, dx, dy);
  }
}

void debugDraw(){
  //debug function so kinda slow
  for(int i=0; i<map.size(); i++){
    if(map.get(i).taken){
      map.get(i).taken = false;
      fill(0);
    }else{
      fill(255);
    }
    rect(map.get(i).y, map.get(i).x, Chunk.size, Chunk.size);
  }
}


void draw(){
  test.tick();
  test.angle += 0.01;
  test.angle %= 2 * Math.PI;
  println(test.angle);
  debugDraw();
}
