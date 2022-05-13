class World{
  
  Cell[][] cells;
  
  int worldHeight, worldWidth;
  
  World(int width, int height) {
      worldHeight = height;
      worldWidth = width;
      initWorld();
  }
 private void initWorld(){
   cells = new Cell[worldHeight][worldWidth];
   for (int y=0; y<worldHeight; y++) {
     for (int x=0; x<worldWidth; x++) {
       println("x="+x+" y=" +y);
       cells[x][y] = createRandomCell();
     }
   }    
 } 
  
  private Cell createRandomCell() {
  
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
    for (int y=0; y<worldHeight; y++) {
     for (int x=0; x<worldWidth; x++) {
       println("x="+x+" y=" +y);
       fill(cells[x][y].cellColor);
       rect(x*cellsize, y*cellsize, cellsize, cellsize);
       
     }
   }    

  
  }
}
