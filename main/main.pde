import java.util.*;

List<Chunk> map;
TestClass test;
TestClass test2;
<<<<<<< HEAD
boolean inventory=false;
=======
TestDefense test3;
>>>>>>> 9e7b44a42fa55378210b38b4712d19c35ff55dc9
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
  
  test3 = new TestDefense();
  test3.x += 250;
  test3.sizeX += 400;
}







void debugDraw(){
  //debug function so kinda slow
  for(int i=0; i<map.size(); i++){
    if(map.get(i).taken){
      //map.get(i).taken = false;
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
  fill(255);
  rect(width/2, height/2, width, height);
  //debugDraw();
  clearMap();
  test3.setHitbox(true);
  test2.setHitbox(true);
  test.setHitbox(true);
  test3.draw();
  test2.draw();
  test.draw();
  test3.tick();
  test2.tick();
  test.tick();

  

  test.angle += test.dx / 25;
  test2.angle += test2.dx / 25;
  //test.angle += 0.01;
  //println(test.dx);
  //println(test2.dx);
  text(mouseX,500,10);
    text(mouseY,500,20);
  if(inventory){
    fill(235,213,179);
    rect(400,400,400,500);
    fill(0);
    for(int i=0;i<5;i++){
      for(int j=0;j<7;j++){
        rect(120+50*i,120+50*j,25,25);
      }
    }
  }
  
}

void mouseDragged(){
   stroke(0);
   line(mouseX, mouseY, pmouseX, pmouseY);
   noStroke();
   test.applyForce((mouseX-pmouseX) / 2, (mouseY-pmouseY) / 2); 
}

void keyPressed(){
  if(keyCode=='E'||keyCode=='e'){
    inventory=!inventory;
  }

}
