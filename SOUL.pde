World world;

int cellsize = 20;
int worldWidth = 50;
int worldHeight = 50;

void setup() {
 // size(cellsize*worldWidth, cellsize*worldHeight);
  size(1000,1000);
  world = new World(worldWidth, worldHeight);
 
  }

void draw() {
 world.draw(cellsize);
  
}
