import java.util.*;

List<Chunk> map;
TestClass test;
TestClass test2;
boolean shop=false;
boolean placingBlock=false;
TestDefense test3;
Block selectedBlock=null;
List<Block> placedBlocks=new ArrayList<Block>();
MainBase plr;
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
  
  plr = new MainBase(width / 2, height / 2);
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
  rect(width/2,height/2,width,height);
  //debugDraw(); //this broke gg
  clearMap();
  plr.setHitbox(true);
  test3.setHitbox(true);
  test2.setHitbox(true);
  test.setHitbox(true);
  plr.draw();
  test3.draw();
  test2.draw();
  test.draw();
  plr.tick();
  test3.tick();
  test2.tick();
  test.tick();
  
  
  
  test.angle+=test.dx/25;
  test2.angle+=test2.dx/25;
  text(mouseX,500,10);
  text(mouseY,500,20);
  if(shop){
    fill(235,213,179);
    rect(400,400,400,500);
    fill(0);
    textSize(24);
    for(int i=0;i<5;i++){
      for(int j=0;j<6;j++){
        rect(250+75*i,220+75*j,50,50);
      }
    }
    text("Shop",350,175);
  }
  for(Block block:placedBlocks){
    block.display();
  }
  if(placingBlock&&selectedBlock!=null){
    selectedBlock.x=mouseX-selectedBlock.size/2;
    selectedBlock.y=mouseY-selectedBlock.size/2;
    selectedBlock.display();
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
    shop=!shop;
    if(!shop&&placingBlock){
      placingBlock=false;
      selectedBlock=null;
    }
  }
}

void mousePressed(){
  if(shop){
    for(int i=0;i<5;i++){
      for(int j=0;j<6;j++){
        float boxX=250+75*i;
        float boxY=220+75*j;
        if(mouseX>boxX&&mouseX<boxX+50&&mouseY>boxY&&mouseY<boxY+50){
          selectedBlock=new Block(mouseX,mouseY,color(0));
          placingBlock=true;
          shop=false;
          return;
        }
      }
    }
  }else if(placingBlock){
    placedBlocks.add(new Block(mouseX-selectedBlock.size/2,mouseY-selectedBlock.size/2,selectedBlock.blockColor));
    placingBlock=false;
    selectedBlock=null;
  }
}
