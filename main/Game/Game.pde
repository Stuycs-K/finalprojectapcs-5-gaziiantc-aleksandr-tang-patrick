import java.util.*;

List<Chunk> map;
boolean placed;
ArrayList<int[]> dropped = new ArrayList<int[]>();
ArrayList<int[]> bullet = new ArrayList<int[]>();

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
  noStroke();
  test = new TestClass();
  test.applyForce(100, 100);
  test2 = new TestClass();
  test2.mass = 10;
  test2.sizeX -= 5;
  test2.sizeY -= 5;
  test.sizeY += 25;
  test2.x += 79;
  test2.y += 50;
  
  test.x += 150;
  test2.x += 150;
}


int getLoc(int x, int y){
  return x/Chunk.size + ((y/Chunk.size) * (width/Chunk.size));
}

void drawSlopedRect(int x_start, int y_start, double slope, int w, int h){
  //divine intellect rasterization from ohio that came to me in a dream during gym last monday
  
  long time = System.nanoTime();
  if(Math.abs(slope) < 1){
    for(int x = x_start; x < x_start+h; x++){
      for(int i=0; (i)<w && slope*i<h; i++){
        //System.out.println("x : " + x + " y: " + (y_start + slope * i));
        int pos = getLoc(x + i, (int)(y_start + slope * i));
        if(pos < map.size() && pos > 0){
          map.get(pos).taken = true;
        }
      }
    }
  }else if (Math.abs(slope) < 3.5){
    for(int x = x_start; x < x_start+h; x++){
      for(int i=0; (i)<w && Math.abs(slope*i)<h; i++){
        //System.out.println("x : " + x + " y: " + (y_start + slope * i));
        int pos = getLoc((int)(x + Math.abs((i / slope))), (int)(y_start + slope * i));
        if(pos < map.size() && pos > 0){
          map.get(pos).taken = true;
        }
      }
    }
  } else {
    //just draw a normal rectangle at that point
    if(slope > 0){
      for(int x = x_start; x<x_start+h; x++){
        for(int y = y_start; y<y_start+w; y++){
          int pos = getLoc(x, y);
          if(pos < map.size() && pos > 0){
            map.get(pos).taken = true;
          }
        }
      }
    }else{
      for(int x = x_start; x<x_start+h; x++){
        for(int y = y_start; y>y_start-w; y--){
          int pos = getLoc(x, y);
          if(pos < map.size() && pos > 0){
            map.get(pos).taken = true;
          }
        }
      }
    }
  }
  //System.out.println((double)(System.nanoTime()-time) / 1_000_000_000);
}

void debugDraw(){
  //debug function so written poorly
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

void clearMap(){
  for(int i=0; i<map.size(); i++){
    map.get(i).taken = false;
  }
}

void draw(){
  drawSlopedRect(mouseX, mouseY, 1.0, 25, 25);
  debugDraw();
  for(int i=0;i<dropped.size();i++){
    drawSlopedRect(dropped.get(i)[0], dropped.get(i)[1], 1.0, 25, 25);
  }
  for(int i=0;i<bullet.size();i++){
    ellipse(bullet.get(i)[0], bullet.get(i)[1],10,10);
  }

}

void mouseDragged(){
   stroke(0);
   line(mouseX, mouseY, pmouseX, pmouseY);
   noStroke();
   test.applyForce((mouseX-pmouseX) / 2, (mouseY-pmouseY) / 2); 
}
void mousePressed(){
  dropped.add(new int[]{mouseX,mouseY});
}
void keyPressed(){
  bullet.add(new int[]{10,10});
}
