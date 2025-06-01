//EBCAUSE OF COURSE PROCESSING WONT LET ME DO IT WITHOTU AN ASSETPOOL WHAT WAS I THINKING AM I STUPID???? WHAT KIND OF LANGUAGE LETS YOU JUST DO THINGS????????????????????????????? JAVA????????? BUDDY THIS IS PROCESSING HERE!!!!!!!!!!!!!!!!

class AssetPool {
  Map<String, PImage> map = new HashMap<>();
  public AssetPool(){ //non static because processing straight up wont let me do this statically LMAO
     map = new HashMap<>(); 
  }
  
  public void add(String str) { 
     map.put(str, loadImage("assets/" + str));
  }
  public PImage get(String str){
    return map.get(str);
  }
}
