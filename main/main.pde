import java.util.*;

List<Chunk> map;
ArrayList<AObject> objects;

int selectedDefenseIndex=-1;
ADefense[] defenses={new WallWooden(0,0),new WallStone(0,0),new SheetMetal(0,0),new Void(0,0),new Shield(0,0),new BlackHole(0,0),new Adsense(0,0)};
int[] baseCost = {50,75,125,50,175,250,400};
int purchaseCount[] = new int[baseCost.length]; 
int[] cost = baseCost.clone();
String[] defenseNames={"Wooden","Stone","Metal","Void","Shield","Black Hole","Adsense"};
boolean shop=false;
boolean placingDefense=false;
ADefense selectedDefense=null;
WallWooden test3;
Void test4;
Shield test5;
BlackHole test6;
boolean voidplaced=false;
double cash=99999.0;
double cashflow=.1;
int cashTime=30000;
double buildingAngle = -HALF_PI;
public AssetPool assets; //using a class in case i want to add shaders for whatever reason


void setup(){
  objects = new ArrayList<>();
  size(700, 700, P2D);
  map = new ArrayList<>();
  fill(255);
  for(int x=0; x<width; x+=Chunk.size){
    for(int y=0; y<height; y+=Chunk.size){
      map.add(new Chunk(x, y));
      rect(x, y, Chunk.size, Chunk.size);
    }
  }
  
  assets = new AssetPool();
  assets.add("testclass.png");
  assets.add("shield.jpg");
  assets.add("sheetmetal.jpg");
  assets.add("woodwall.jpg");
  assets.add("stonewall.jpg");
  assets.add("laser.png");
  assets.add("void.png");
  assets.add("adsense.jpeg");
  
  noStroke();
  TestClass test = new TestClass();
  test.applyForce(100, 100);
  TestClass test2 = new TestClass();
  test2.mass = 10;
  test2.sizeX -= 5;
  test2.sizeY -= 5;
  test.sizeX += 25;
  test2.x += 79;
  test2.y += 50;
  test5=new Shield(500,500);
  test6=new BlackHole(100,500);
  
  test.x += 150;
  test2.x += 150;
  
  WallWooden test3 = new WallWooden(width/2-100, height/2);
  
  MainBase plr = new MainBase(width / 2, height / 2);
  objects.add(plr);
  objects.add(test);
  objects.add(test2);
  objects.add(test3);
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
  if(frameCount > 200 && frameCount%5 == 0){
    objects.add(new Laser());
  }
  rect(width/2,height/2,width,height);
  
  
  
  
  
  clearMap();
  
  for(int i=0; i<objects.size(); i++){	
    if(objects.get(i).x > 1000+width || objects.get(i).x < -1000 || objects.get(i).y > 1000+height || objects.get(i).y < -1000){
       objects.remove(i);
       i--;
    }
	  objects.get(i).setHitbox(true);
  }
  if(key=='d'){
     debugDraw(); //this broke gg
  }
  for(int i=0; i<objects.size(); i++){  
    objects.get(i).draw();
  }
  
  for(int i=0; i<objects.size(); i++){  
    objects.get(i).tick();
  }
  if(keys['r']){
    buildingAngle += (0.075);
  }
  if(keys['t']){
    buildingAngle -= (0.075);
  }
  
  if(millis()<test5.duration){
    test5.draw();
    test5.tick();
  }
    if(millis()<test6.duration){
    test6.draw();
    test6.tick();
  }
  if(millis()>cashTime){
    cashflow+=0.7;
    cashTime*=3;
  }
  objects.get(1).angle+=objects.get(1).dx/25;
  objects.get(2).angle+=objects.get(2).dx/25;
  fill(0);
  textSize(25);
  text(mouseX,500,10);
  text(mouseY,500,20);
  int e = 0;
  for(int i=0; i<objects.size(); i++){
     e+=objects.get(i).mass * (Math.pow(objects.get(i).dx, 2) + Math.pow(objects.get(i).dy, 2));
  }
  text("Total energy in system: " + e, 100, 10);
  if(shop){
    drawShop();
  }
  if(placingDefense&&selectedDefenseIndex>=0){
    pushMatrix();
    translate(mouseX,mouseY);
    defenses[selectedDefenseIndex].angle = buildingAngle;
    defenses[selectedDefenseIndex].draw();
    popMatrix();
  }
  cash+=cashflow;
  text("Cash: "+(double)(int)(cash*10000)/10000,100,100);

}

void mouseDragged(){
   stroke(0);
   line(mouseX, mouseY, pmouseX, pmouseY);
   noStroke();
   objects.get(1).applyForce((mouseX-pmouseX) / 2, (mouseY-pmouseY) / 2); 
}

boolean[] keys = new boolean[200]; //oversized because i dont trust processing
boolean shiftisspecial;
void keyReleased(){
  if(key < keys.length){  
    keys[key] = false;
  }else{
    if(keyCode==SHIFT){
      shiftisspecial = false;  
    }
  }
} 

void keyPressed(){
  if(key < keys.length){
    keys[key] = true;
  }else{
    if(keyCode==SHIFT){
      shiftisspecial = true;  
    }
  }
  if(keyCode=='E'||keyCode=='e'){
    shop=!shop;
    if(!shop&&placingDefense){
      placingDefense=false;
      selectedDefenseIndex=-1;
    }
  }
  if(keyCode=='v'||keyCode=='V'){
    Void test4=new Void(mouseX,mouseY);
    voidplaced=true;
    objects.add(test4);
  }
  if(keyCode=='l'||keyCode=='L'){
     objects.add(new Laser());
  }
  if(key==' '){
      objects.add(new Train()); 
   }
  /*if(keyCode=='r'||keyCode=='R'){
     buildingAngle += HALF_PI;
  }
  if(keyCode=='t'||keyCode=='T'){
     buildingAngle -= HALF_PI; 
  }*/
}

void mousePressed(){
  if(shop){
    for(int i=0;i<5;i++){
      float x=250+75*i;
      float y=220;
      if(mouseX>x&&mouseX<x+50&&mouseY>y&&mouseY<y+50&&cash>=cost[i]){
        selectedDefenseIndex=i;
        placingDefense=true;
        shop=false;
        return;
      }
    }
    for(int i=5;i<10;i++){
      float x=250+75*(i-5);
      float y=320;
      if(mouseX>x&&mouseX<x+50&&mouseY>y&&mouseY<y+50&&cash>=cost[i]){
        selectedDefenseIndex=i;
        placingDefense=true;
        shop=false;
        return;
      }
    }
  }else if(placingDefense){
    AObject placing = null;
    switch(selectedDefenseIndex){
      case 0: placing = (new WallWooden(mouseX,mouseY)); break;
      case 1: placing = (new WallStone(mouseX,mouseY)); break;
      case 2: placing = (new SheetMetal(mouseX,mouseY)); break;
      case 3: placing = (new Void(mouseX,mouseY));
      case 4: placing = (new Shield(mouseX,mouseY)); break;
      case 5: placing = (new BlackHole(mouseX,mouseY)); break;
      case 6: 
        placing = (new Adsense(mouseX,mouseY));
        cashflow *= 2;
        break;
    }
    if(placing != null){
      placing.angle = buildingAngle;
      objects.add(placing);
      //print(objects.get(objects.size()-1));
      purchaseCount[selectedDefenseIndex]++;
      cash -= cost[selectedDefenseIndex];
      //no. cost[selectedDefenseIndex] = baseCost[selectedDefenseIndex] + (25 * purchaseCount[selectedDefenseIndex]);
      placingDefense = false;
    }
    selectedDefenseIndex = -1;
  }
}
void drawShop(){
  fill(235,213,179);
  rect(400,400,400,500);
  fill(0);
  textSize(24);
  for(int i=0;i<5;i++){
    float x=250+75*i;
    float y=220;
    pushMatrix();
    translate(x+25,y+25);
    scale(0.4);
    defenses[i].draw();
    popMatrix();
    textSize(14);
    text(defenseNames[i],x-15,y+80);
    text("$"+cost[i],x-5,y+95);
    if(cash<cost[i]) fill(255,0,0);
    text("cost: "+cost[i],x-15,y+110);
    fill(0);
    if(selectedDefenseIndex==i){
      noFill();
      stroke(255,0,0);
      rect(x,y,50,50);
      noStroke();
    }
  }
   for(int i=5;i<10 && i < defenses.length;i++){
    float x=250+75*(i-5);
    float y=320;
    pushMatrix();
    translate(x+25,y+25);
    scale(0.4);
    defenses[i].draw();
    popMatrix();
    textSize(14);
    text(defenseNames[i],x-15,y+80);
    text("$"+cost[i],x-5,y+95);
    if(cash<cost[i]) fill(255,0,0);
    text("cost: "+cost[i],x-15,y+110);
    fill(0);
    if(selectedDefenseIndex==i){
      noFill();
      stroke(255,0,0);
      rect(x,y,50,50);
      noStroke();
    }
  }
  textSize(24);
  text("Shop",350,175);
}
