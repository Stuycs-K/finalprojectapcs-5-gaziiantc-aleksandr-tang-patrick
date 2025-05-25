import java.util.*;

List<Chunk> map;
TestClass test;
TestClass test2;
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
  //noStroke();
  test = new TestClass();
  test.applyForce(100, 100);
  test2 = new TestClass();
  test2.mass = 10;
  test2.sizeX -= 5;
  test2.sizeY -= 5;
  test2.x += 79;
  test2.y += 50;
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
  
  test2.setHitbox(true);
  test.setHitbox(true);
  
  test2.tick();
  test.tick();
  test.angle += test.dx / 25;
  test.angle %= 2 * Math.PI;
  println(test.dx);
  println(test2.dx);
  debugDraw();
}
