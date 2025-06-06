import java.util.*;
import java.io.*;


static final int sHeight = 700;
static final int sWidth = 700;


List<Chunk> map;
ArrayList<AObject> objects;

int selectedDefenseIndex=-1;
ADefense[] defenses={new WallWooden(0,0),new WallStone(0,0),new SheetMetal(0,0),new Void(0,0),new Shield(0,0, Integer.MAX_VALUE),new BlackHole(0,0, Integer.MAX_VALUE),new Adsense(0,0)};
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
boolean start=false;
static int score=0;
boolean cheatsEnabled = false;

MainBase plr;
int nextLevel=50;
public AssetPool assets; //using a class in case i want to add shaders for whatever reason
boolean upgradeScreen = false;
int[] upgradeLevels = new int[defenses.length];
int[] upgradeCosts = {50, 100, 200, 500, 1000}; 
String[][] upgradeDescriptions = {{"+50% Health", "+100% Health", "+50% Size"},
    {"+50% Health", "+100% Health", "+50% Size"},
    {"+50% Health", "+100% Health", "+50% Size"},
    {"+50% Radius", "+100% Radius", "-50% Cost"},
    {"+50% Duration", "+100% Duration", "+50% Size"},
    {"+50% Radius", "+100% Radius", "+50% Duration"},
    {"+50% Cash Flow", "+100% Cash Flow", "+25% Score"}};

public int plrX = (int)(0.5 * sWidth); public int plrY = (int)(0.5 * sHeight);
public int[] bounds = new int[]{0-sWidth*2, 0-sHeight*2, sWidth * 2, sHeight * 2}; //left x y, right x y


public ArrayDeque<Attack> levelTypes = new ArrayDeque();
public ArrayDeque<Double> levelNums = new ArrayDeque();
Map<String, Attack> Strattmap = new HashMap<>();
int framesPerAtk = 1;
ArrayDeque<AObject> sel = new ArrayDeque(); //selected objects
int nSel = 0; //how much are selected
boolean pass = false;
double[] alloc;
AObject[] allocObj;
int selIndex;
AObject selobj = null; 

void loadLevel(String path){
    try{
      Scanner sc = new Scanner(new File(path));
      
      while(sc.hasNextLine()){
        levelTypes.add(Attack.PAUSE);
        String[] arr = sc.nextLine().split("-");
        levelNums.add(Double.parseDouble(arr[1]));
        for(int i=2; i<arr.length; i+=2){
          //println(Strattmap.get(arr[i]));
          if(Strattmap.get(arr[i])==null){
            throw new IllegalArgumentException(arr[i]);
          }
          System.out.println(i + "/" + arr[i] + " " + Arrays.toString(arr));
          System.out.println(levelTypes);
          System.out.println(levelNums);
          levelNums.add(Double.parseDouble(arr[i+1]));
          
          levelTypes.add(Strattmap.get(arr[i]));
          
        }
      }
      
      sc.close();
    }catch(FileNotFoundException e){
      throw new IllegalArgumentException("File " + path + " not found");
    }
    System.out.println(levelTypes);
    System.out.println(levelNums);
}


void setup(){
  objects = new ArrayList<>();
  size(700, 700, P2D);
  map = new ArrayList<>();
  fill(255);
  for(int x=bounds[0]; x<bounds[2]; x+=Chunk.size){
    for(int y=bounds[1]; y<bounds[3]; y+=Chunk.size){
      map.add(new Chunk(x, y));
      //rect(x, y, Chunk.size, Chunk.size);
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
  //Strattmap = new HashMap<>();
  Strattmap.put("LASER", Attack.LASER);
  Strattmap.put("TRAIN", Attack.TRAIN);
  Strattmap.put("FRAMES", Attack.FRAMES);
  Strattmap.put("SEL", Attack.SEL);
  Strattmap.put("FREEZE", Attack.FREEZE);
  Strattmap.put("MULSPEED", Attack.MULSPEED);
  
  Strattmap.put("ALLOC", Attack.ALLOC);
  Strattmap.put("SELINDEX", Attack.SELINDEX);
  Strattmap.put("WRITE", Attack.WRITE);
  
  Strattmap.put("ALLOCOBJ", Attack.ALLOCOBJ);
  
  Strattmap.put("WRITEVLASTOBJ", Attack.WRITEVLASTOBJ);
  
  
  Strattmap.put("IFLESSTHAN", Attack.IFLESSTHAN);
  Strattmap.put("WHILELESSTHAN", Attack.WHILELESSTHAN);
  Strattmap.put("ELSE", Attack.ELSE);
  Strattmap.put("END", Attack.END);
  
  Strattmap.put("MUL_N_SPEED", Attack.MUL_N_SPEED);
  noStroke();
  TestClass test = new TestClass();
  //test.applyForce(100, 100);
  TestClass test2 = new TestClass();
  test2.mass = 10;
  test2.sizeX -= 5;
  test2.sizeY -= 5;
  test.sizeX += 25;
  test.x = 0;
  test.y = 0;
  test5=new Shield(500,500, millis());
  test6=new BlackHole(100,500, millis());
  
  test.x += 150;
  test2.x += 150;
  
  WallWooden test3 = new WallWooden(width/2-100, height/2);
  
  plr = new MainBase(0, 0);
  objects.add(plr);
  objects.add(test);
  objects.add(test2);
  objects.add(test3);
  
  
  loadLevel("/home/bread/finalprojectapcs-5-gaziiantc-aleksandr-tang-patrick/main/assets/levels/test.lvl"); //this needs to be changed asap because it will literally not run on any other computer.
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
  
  if(keys['s']){
     if(plrY > bounds[1] + sWidth){
       plrY -= 5;  
     }
  }
  if(keys['d']){
     if(plrY > bounds[0] + sHeight){
       plrX -= 5;  
     }
  }
  if(keys['w']){
     if(plrY < bounds[3] - sWidth){ 
       plrY += 5;  
     }
  }
  if(keys['a']){
     if(plrY < bounds[2] - sHeight){
       plrX += 5;  
     }
  }
  
  translate(plrX, plrY);
  fill(255);
  if(levelTypes.size() > 0 && levelNums.size() > 0 && !(levelTypes.peek().equals(Attack.PAUSE))){
    if(frameCount%framesPerAtk == 0 || pass){
      pass = false;
      double n = levelNums.remove();
      if(n > 0){
        levelNums.addFirst(n-1);
        Attack a = levelTypes.peek();
        AObject obj = null;
        if(a.equals(Attack.LASER)){
          obj = (new Laser(Math.cos(frameCount / 5) * width * 1.2, Math.sin(frameCount / 5) * height * 1.2, plr)); 
        }else if(a.equals(Attack.TRAIN)){
          obj = (new Train(Math.cos(frameCount / 5) * width * 1.2, Math.sin(frameCount / 5) * height * 1.2, plr)); 
        }else if(a.equals(Attack.FRAMES)){
           //do nothing lol 
        }else if(a.equals(Attack.SEL)){
           nSel = (int)n;
           levelNums.remove();
           levelTypes.remove();
           pass = true;
        }else if(a.equals(Attack.FREEZE)){
           for(AObject o : sel){
              if(n<=0){
                break;
              }
              o.dx = 0; o.dy = 0;
              n--; 
           }
           levelNums.remove();
           levelTypes.remove();
           pass = true;
        }else if(a.equals(Attack.MULSPEED)){
          for(AObject o : sel){
            o.dx *= n; o.dy *= n; 
          }
          levelNums.remove();
          levelTypes.remove();
          pass = true;
        }
        
        else if(a.equals(Attack.ALLOC)){
          alloc=new double[(int)n];
          levelNums.remove();
          levelTypes.remove();
          pass = true;
        }else if(a.equals(Attack.SELINDEX)){
           selIndex = (int)n;
           levelNums.remove();
           levelTypes.remove();
           pass = true;
        }else if(a.equals(Attack.WRITE)){
           alloc[selIndex] = n;
           levelNums.remove();
           levelTypes.remove();
           pass = true; 
        }else if(a.equals(Attack.WRITEVLASTOBJ)){
           AObject o = sel.getLast();
           selobj = o;
           alloc[selIndex] = Math.sqrt(o.dx * o.dx + o.dy * o.dy);
           levelNums.remove();
           levelTypes.remove();
           pass = true; 
        }else if(a.equals(Attack.ALLOCOBJ)){
           allocObj = new AObject[(int)n];
           levelNums.remove();
           levelTypes.remove();
           pass = true; 
        }
        
        else if(a.equals(Attack.IFLESSTHAN)){
           System.out.println("reading if statement");
           if(alloc[selIndex] < n){
               println("more than");
               while(levelTypes.remove() != Attack.ELSE){
                   levelNums.removeFirst();  
               }
               levelNums.removeFirst();
               println("result: " + levelTypes);
               println(levelNums);
               println("if statement over");
               pass = true;
           }else{
               println("less than");
               ArrayDeque<Attack> storeTypes = new ArrayDeque<>();
               ArrayDeque<Double> storeNums = new ArrayDeque<>();
               while(levelTypes.peek() != Attack.ELSE){
                 storeTypes.add(levelTypes.removeFirst());
                 storeNums.add(levelNums.removeFirst());  
               }
               storeTypes.removeFirst(); storeNums.removeFirst(); //remove if statements
               println("Finished storing");
               println(storeTypes);
               println(storeNums);
               while(levelTypes.remove() != Attack.END){
                   levelNums.removeFirst();  
               }
               levelNums.removeFirst();
               while(storeTypes.size() > 0){
                  levelTypes.addFirst(storeTypes.removeLast()); 
                  levelNums.addFirst(storeNums.removeLast());
               }
               println(levelTypes);
               println(levelNums);
           }
        }
        else if(a.equals(Attack.WHILELESSTHAN)){
           println("while statement"); 
           Attack whilestatement = levelTypes.removeFirst();
           Double whilenum = n;
           ArrayDeque<Attack> storeTypes = new ArrayDeque<>();
           ArrayDeque<Double> storeNums = new ArrayDeque<>();
           while(levelTypes.peek() != Attack.END){
             storeTypes.add(levelTypes.removeFirst());
             storeNums.add(levelNums.removeFirst());  
           }
           println("removed stuff");
           println(alloc[selIndex] + " - " + n);
           if(alloc[selIndex] < n){
             println("is less"); 
             for(Attack moorevariables : storeTypes){
                levelTypes.addFirst(moorevariables);
             }
             for(Double d : storeNums){
                levelNums.addFirst(d); 
             }
              levelTypes.addFirst(whilestatement);
              levelNums.addFirst(whilenum);
              while(storeTypes.size() > 0){
                  levelTypes.addFirst(storeTypes.removeLast()); 
                  levelNums.addFirst(storeNums.removeLast());
               }
               
           }
        }  
        
        else if(a.equals(Attack.MUL_N_SPEED)){
           for(AObject o : sel){
              if(n<=0){
                break;
              }
              o.dx *= alloc[selIndex]; o.dy *= alloc[selIndex];
              n--; 
           }
           levelNums.remove();
           levelTypes.remove();
           pass = true;
        }
        
        
        if(nSel > 0 && obj!=null){
           sel.addLast(obj);
           nSel--;
        }
        if(obj!=null){
          objects.add(obj);
        }
      }else{
        levelTypes.remove();
      }
      System.out.println(levelTypes);
    System.out.println(levelNums);
    }
  }
  rect(bounds[0],bounds[1], 2 * (bounds[2]-bounds[0]), 2 * (bounds[3]-bounds[1]));
  //print(bounds[2] + " - " + bounds[0] + " = ");
  //println(bounds[2]-bounds[0]); //1800-(-1000), should be 2800
  //println(objects.get(0).getLoc(bounds[0]+1, bounds[1]+1));
  
  clearMap();
  
  for(int i=0; i<objects.size(); i++){	
    if(objects.get(i).x > 10000+width || objects.get(i).x < -10000 || objects.get(i).y > 10000+height || objects.get(i).y < -10000){
       objects.remove(i);
       i--;
    }
    if(i>=0){
	    objects.get(i).setHitbox(true);
    }
  }
  
  for(int i=0; i<objects.size(); i++){  
    objects.get(i).draw();
  }
  
  for(int i=0; i<objects.size(); i++){  
    objects.get(i).tick();
  }
  
  
  for(int i = 0; i < objects.size(); i++) {
    AObject obj = objects.get(i);
    if(obj instanceof ADefense) {
      ADefense defense = (ADefense)obj;
      if(defense.hp <= 0) {
        score += defense.pointValue;
        objects.remove(i);
        i--;
       }
     }
  }
  
  
  if(keys['r']){
    buildingAngle += (0.075);
  }
  if(keys['t']){
    buildingAngle -= (0.075);
  }
  
  if(millis()>cashTime){
    cashflow+=0.7;
    cashTime*=3;
  }
  objects.get(1).angle+=objects.get(1).dx/25;
  objects.get(2).angle+=objects.get(2).dx/25;
  fill(0);
  textSize(25);
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
    translate(mouseX-plrX,mouseY-plrY);
    defenses[selectedDefenseIndex].angle = buildingAngle;
    defenses[selectedDefenseIndex].draw();
    popMatrix();
  }
  cash+=cashflow;
  text("Cash: "+(double)(int)(cash*10000)/10000,10 - plrX, 70 - plrY);
  if(score>=nextLevel&& !upgradeScreen){
    //level++;
    start=false;
    upgradeScreen=true;
    nextLevel*=100;
  }
  if(upgradeScreen){
    drawUpgradeScreen();
    return;
  }
    if(!start){
    text("Press space to start", 10 - plrX, 110 - plrY);
  }
    text("Score: "+score, 10 - plrX, 50 - plrY);
    //text("Level: "+level, 10 - plrX, 90 - plrY);
    if(key=='['){
     debugDraw(); 
  }
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
  if(key=='o'){
      objects.add(new Train(Math.cos(frameCount / 5) * width * 1.2, Math.sin(frameCount / 5) * height * 1.2, plr)); 
   }
     if(key=='m'){
      objects.add(new Missile(100, 100, plr)); 
   }
        if(key=='b'){
      objects.add(new Bomb(100, 100, plr)); 
   }
  /*if(keyCode=='r'||keyCode=='R'){
     buildingAngle += HALF_PI;
  }
  if(keyCode=='t'||keyCode=='T'){
     buildingAngle -= HALF_PI; 
  }*/
  
  if(keyCode==' '||keyCode==' ' || key==' '){
    if(levelTypes.size() > 0 && levelTypes.peek().equals(Attack.PAUSE)){
      levelTypes.remove(); 
      framesPerAtk = levelNums.remove().intValue();
    }
  }
  if(keyCode == 'C'||keyCode == 'c' && shiftisspecial) {
    cheatsEnabled = !cheatsEnabled;
    println("Cheats " + (cheatsEnabled ? "ENABLED" : "DISABLED"));
    return;
  }  
  if(cheatsEnabled) {
    switch(key) {
      case 'M':
        cash += 1000;
        println("Added $1000");
        break;     
      case 'U':
        for(int i = 0; i < upgradeLevels.length; i++) {
          if(upgradeLevels[i] < 5) {
            upgradeLevels[i]++;
          }
        }
        println("All defenses upgraded");
        break;      
      case 'K': 
        for(int i = objects.size()-1; i >= 0; i--) {
          if(objects.get(i) instanceof AObject) {
            objects.remove(i);
          }
        }
        println("Killed All Enemies");
        break;        
      }
    }
}

void mousePressed(){
  if(shop){
    for(int i=0;i<5;i++){
      float x=250+75*i-plrX;
      float y=220-plrY;
      //rect(x, y, 50, 50);
      //print(mouseX+plrX>x);
      //print(mouseX-plrX<x+50);
      //print(mouseY+plrY>y);
      //print(mouseY-plrY<y+50);
      //println();
      if(mouseX+plrX>x&&mouseX-plrX<x+50&&mouseY+plrY>y&&mouseY-plrY<y+50&&cash>=cost[i]){
        selectedDefenseIndex=i;
        placingDefense=true;
        shop=false;
        return;
      }
    }
    for(int i=5;i<7;i++){ 
      float x=250+75*(i-5)-plrX;
      float y=320-plrY;
      //rect(x-plrX, y-plrY, 50, 50);
      if(mouseX+plrX>x&&mouseX-plrX<x+50&&mouseY+plrY>y&&mouseY-plrY<y+50&&cash>=cost[i]){
        selectedDefenseIndex=i;
        placingDefense=true;
        shop=false;
        return;
      }
    }
  }else if(placingDefense){
    ADefense placing = null;
    switch(selectedDefenseIndex){
      case 0: placing = (new WallWooden(mouseX-plrX,mouseY-plrY)); break;
      case 1: placing = (new WallStone(mouseX-plrX,mouseY-plrY)); break;
      case 2: placing = (new SheetMetal(mouseX-plrX,mouseY-plrY)); break;
      case 3: placing = (new Void(mouseX-plrX,mouseY-plrY)); break;
      case 4: 
        placing = (new Shield(mouseX-plrX,mouseY-plrY, millis())); 
        break;
      case 5: 
        placing = (new BlackHole(mouseX-plrX,mouseY-plrY, millis()));
        break;
      case 6: 
        placing = (new Adsense(mouseX-plrX,mouseY-plrY));
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
     
  if (upgradeScreen) {
    for (int i = 0; i < defenses.length; i++) {
      if (upgradeLevels[i] >= 5) continue;   
       float x = width/2 - 200 + (i%4)*130-plrX;
       float y = height/2 - 100 + floor(i/4)*150-plrY;
       if (mouseX+plrX>x&&mouseX-plrX<x+50&&mouseY+plrY>y&&mouseY-plrY<y+50) {
         if (cash >= upgradeCosts[upgradeLevels[i]]) {
           cash -= upgradeCosts[upgradeLevels[i]];
           applyUpgrade(i);
           upgradeScreen = false;
           break;
         }
        }
       }
      return;
    }
}
void drawShop(){
  fill(235,213,179);
  rect(400-plrX,400-plrY,400,500);
  fill(0);
  textSize(24);
  for(int i=0;i<5;i++){
    float x=250+75*i-plrX;
    float y=220-plrY;
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
    float x=250+75*(i-5)-plrX;
    float y=320-plrY;
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
  text("Shop",350-plrX,175-plrY);
}
void drawUpgradeScreen() {
    fill(200, 230, 200);
    rect(width/2-plrX, height/2-plrY, 500, 500);
    fill(0);
    textSize(32);
    text("Level Up!", width/2-plrX, height/2 - 200-plrY);
    textSize(16);
    text("Choose one upgrade", width/2-plrX, height/2 - 160-plrY);
    for (int i = 0; i < defenses.length; i++) {
        if (upgradeLevels[i] >= 5) continue;
        float x = width/2 - 200 + (i%4)*130-plrX;
        float y = height/2 - 100 + floor(i/4)*150-plrY;
        pushMatrix();
        translate(x+50, y+30);
        scale(0.3);
        defenses[i].draw();
        popMatrix();
        text(defenseNames[i], x, y);
        text(upgradeDescriptions[i][upgradeLevels[i]], x, y+20);
        text("$"+upgradeCosts[upgradeLevels[i]], x, y+40);
        if (mouseX+plrX>x&&mouseX-plrX<x+50&&mouseY+plrY>y&&mouseY-plrY<y+50) {
            noFill();
            stroke(0, 255, 0);
            rect(x, y, 100, 80);
            noStroke();
        }
    }
}
void applyUpgrade(int defenseIndex) {
    upgradeLevels[defenseIndex]++;
    switch(defenseIndex) {
        case 0:
            
            break;
            
        case 1:
            break;
            
        case 5:
            break;
            
        case 4:
            break;
            
        case 6:
            break;
    }
}
