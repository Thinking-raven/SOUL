class World{
  //laver vores class array cells.
  Cell[][] cells;
  //laver to fields som er vores height og width variabler
  int worldHeight, worldWidth;
  
  // constructor vores world og giver den nogle parametre. 
  World(int width, int height) {
      worldHeight = height;
      worldWidth = width;
      initWorld();
  }
 private void initWorld(){
   print("initializing world...");
   cells = new Cell[worldHeight][worldWidth];
   for (int y=0; y<worldHeight; y++) {
     for (int x=0; x<worldWidth; x++) {
       //println("x="+x+" y=" +y);
       cells[x][y] = createRandomCell();
     
     }
   }    
   println("done");
 } 
  
  private Cell createRandomCell() {
  //kører nogle if kommandoer som tager giver en tilfældig celle i return
    int t = int(random(3));
    if(t == 0) {
      return new WaterCell();
    }
    if(t == 1) {
      return new LandCell();
    }
    return new SandCell();
  
  }
  public void draw(int cellsize) {
    //laver et for loop som fylder skærmen ud med cells
    for (int y=0; y<worldHeight; y++) {
     for (int x=0; x<worldWidth; x++) {
     //  println("x="+x+" y=" +y);
       fill(cells[x][y].cellColor);
       //tegner kasserne som bliver til celler
       rect(x*cellsize, y*cellsize, cellsize, cellsize);
       
     }
   }    
  }
  public ArrayList<Cell> getCellCluster(int x, int y) {
    ArrayList<Cell> cluster = new ArrayList<Cell>();
    for(int dx = -1; dx<=1; dx++) {
      for(int dy = -1; dy<=1; dy++) {
        cluster.add(cells[x+dx][y+dy];
      }  
    }
  }
  
 private changeCell(){
   
 }  
 }
}
