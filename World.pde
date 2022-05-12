abstract class World{
  
  Cell[][] cells;
  
  int worldHeight, worldWidth;
  
  World(int height, int width) {
      worldHeight = height;
      worldWidth = width;
      initWorld();
  }
 private void initWorld(){
   cells = new Cell[worldHeight][worldWidth];
    for (int x=0; x<width/cellsize; x++) {
     for (int y=0; y<height/cellsize; y++) {
      t = round(random(2));
      if (empty > t) {

        if (t == 0) {
          empty = sand;
        }
        if (t == 1) {
          empty = water;
        }
        if (t == 2) {
          empty = land;
        }
        cells[x][y] = int(empty);
        fill(empty);
        }
      }
    }    
  } 
}
