class AssetPool {
  Map<String, PImage> map = new HashMap<>();
  public AssetPool(){ //non static purely because I cant do this statically for god knows what reason
     map = new HashMap<>(); 
  }
  
  public void add(String str) { 
     map.put(str, loadImage("assets/" + str));
  }
  public PImage get(String str){
    return map.get(str);
  }
}
