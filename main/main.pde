import java.util.*;

List<Chunk> map;

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
}

int getLoc(int x, int y){
  return x/Chunk.size + ((y/Chunk.size) * (width/Chunk.size));
}

void drawSlopedRect(){
  //TBD
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


void draw(){
  debugDraw();
}
