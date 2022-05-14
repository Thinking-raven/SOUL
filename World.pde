class World {
  final int grassSeeds = 100;

  //laver vores class array cells.
  Cell[][] cells;
  Agent agent;
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
      return new EarthCell();
    }
    return new SandCell();
  
  }
  public void draw(int cellsize) {
    //laver et for loop som fylder skærmen ud med cells
    for (int y=0; y<worldHeight; y++) {
     for (int x=0; x<worldWidth; x++) {
     //  println("x="+x+" y=" +y);
       fill(cells[x][y].getCellColor());
       //tegner kasserne som bliver til celler
       rect(x*cellsize, y*cellsize, cellsize, cellsize);
       
     }
   }    
  }
  private ArrayList<Cell> getCellCluster(int x, int y) {
    ArrayList<Cell> cluster = new ArrayList<Cell>();
    for(int dx = -1; dx<=1; dx++) {
      for(int dy = -1; dy<=1; dy++) {
        if (x+dx >= 0 && 
            x+dx < worldWidth && 
            y+dy >= 0 && 
            y+dy < worldHeight) {
          cluster.add(cells[x+dx][y+dy]);
        }
      }  
    }
    return cluster;
  }
  
 public void changeCell(int x, int y) {
   ArrayList<Cell> cluster = getCellCluster(x, y);
   int g = int(random(cluster.size()));
   Cell c = cluster.get(g);
   if (c instanceof SandCell) {
     cells[x][y] = new SandCell();
   }   
   else if (c instanceof WaterCell) {
     cells[x][y] = new WaterCell();
   }
   else if (c instanceof EarthCell) {
     cells[x][y] = new EarthCell();
   }
 }
 
 public void growCell(int x, int y) {
   ArrayList<Cell> cluster = getCellCluster(x, y);
   int g = int(random(cluster.size()));
   Cell c = cluster.get(g);
   if (c instanceof SandCell) {
     cells[x][y] = new SandCell();
   }   
   else if (c instanceof WaterCell) {
     cells[x][y] = new WaterCell();
   }
   else if (c instanceof EarthCell) {
     cells[x][y] = new EarthCell();
   }
 }
 
 /**
  * Performs dilation on cluster - creating a more even world
  */ 
  public void dilateCluster(int x, int y) { 
    ArrayList<Cell> cluster = getCellCluster(x, y);
    int numSand = 0;
    int numLand = 0;
    int numWater = 0;
  
    for (Cell c : cluster) {
      if (c instanceof EarthCell) {
        numLand += 1;
      }   
      else if (c instanceof WaterCell) {
        numWater += 1;
      }
      else if (c instanceof SandCell) {
        numSand += 1;
      }
    }
    
    //println("Found: " + numSand + " Sandcells, " + numWater + " WaterCells, " + numLand + " LandCells");
    
    int i = numSand;
    Terrain terrain = Terrain.SAND;
   
    if (numWater >= i) {
      i = numWater;
      terrain = Terrain.WATER;
    }
   
    if (numLand >= i) {
      terrain = Terrain.EARTH;
    }
   
    switch (terrain) {
      case SAND: 
        cells[x][y] = new SandCell(); 
       // println ("Chose SandCell");
        break;
      case EARTH:
        cells[x][y] = new EarthCell();
        //println ("Chose LandCell");
        break; 
      case WATER:
        cells[x][y] = new WaterCell();
        //println ("Chose WaterCell");
    } 
 } // dilateCluster
   
   
  public void seedWorld(){
    int i = grassSeeds;
    while ( i > 0 ) {
      int locx = int(random(1, worldWidth - 1));
      int locy = int(random(1, worldHeight - 1));
      boolean planted = plantGrass(locx, locy);
      if ( planted) {
        i -= 1;
      }
      
    }
 }  
 
 
 
 
 public void updateWorld(){
   int locx = int(random(0, worldWidth));
   int locy = int(random(0, worldHeight));
   grow(locx, locy);
   // changeCell(locx, locy);
 } // updateWorld
 
 public void dilateWorld() {
   for (int locx = 0; locx < worldWidth; locx++) {
     for (int locy = 0; locy < worldHeight; locy++) {
       dilateCluster(locx, locy);
       // changeCell(locx, locy);
     }
   }
 }
  public void grow(int x, int y) {
    int grass = 0;
    final float ODDS = 0.3;
    ArrayList<Cell> cluster = getCellCluster(x, y);
     if ( cells[x][y] instanceof EarthCell) {
       for (Cell c : cluster) {
         if (c.hasGrass) {
          grass += 1; 
         }
       }
       //println("ODDS = ", float(grass)/float(cluster.size()));
       if ( float(grass)/float(cluster.size()) > ODDS) {
         cells[x][y].hasGrass = true;
         print("growing grass");
       }   
          

   }
  }
  
  
  
  public boolean plantGrass(int x, int y) {
   if( cells[x][y] instanceof EarthCell) {
     cells[x][y].hasGrass = true;
     return true;
  }
  return false;
 }
} // WORLD
