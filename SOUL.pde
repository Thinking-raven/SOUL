World world;

static enum Terrain {EARTH, WATER, SAND};


int cellsize = 20;
int worldWidth = 50;
int worldHeight = 50;

void setup() {
 // size(cellsize*worldWidth, cellsize*worldHeight);
  size(1000,1000);
  world = new World(worldWidth, worldHeight);
  world.dilateWorld(); 
  world.seedWorld();
}

void draw() {
 world.draw(cellsize);
 world.updateWorld();

}
