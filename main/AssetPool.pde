class AssetPool {
  Map<String, PImage> txMap;
  public AssetPool(){ //non static purely because I cant do this statically for god knows what reason
    txMap = new HashMap<>();
  }
  
  public void add(String str) { 
     txMap.put(str, loadImage("assets/" + str));
  }
  public PImage get(String str){
    return txMap.get(str);
  }
}
