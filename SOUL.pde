World world;

int cellsize = 20;
int worldWidth = 5;
int worldHeight = 5;


float livechance = 100;


int interval = 100;
int lasttime = 0;








void setup() {
 // size(cellsize*worldWidth, cellsize*worldHeight);
  size(100,100);
  world = new World(worldWidth, worldHeight);
 
  }
    
  






void draw() {
 world.draw(cellsize);
  
}
