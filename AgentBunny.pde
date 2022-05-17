class AgentBunny extends Agent {
   AgentBunny(World world) {
     this.world = world;
     
     visionRange = 5;
     
     pos = new IVector(round(random(0, worldHeight)), round(random(0, worldHeight)));
     print("H");
    
   }
   
   public void setPosition(IVector pos) {
     this.pos.x = max(min(pos.x, worldWidth-1),0);
     this.pos.y = max(min(pos.y, worldHeight-1), 0);
   }
   
    public void move() {
      ArrayList<IVector> grass = findCloseGrass();
     // print("found", grass.size());
      IVector target;
      if ( grass.size() == 0) {
//        pos.add(new IVector(round(random(-1,1)), round(random(-1,1)))); 
      } else {
        int i = int(random(grass.size()));
        target = grass.get(i);
        println("target is ", target.x, target.y);
        IVector newPos = target.normalize();
        newPos.add(pos);
        setPosition(newPos);
        println("moving to grass", pos.x, pos.y);
      }
   }
   
   public void feed() {
     world.cells[pos.x][pos.y].hasGrass = false;
   }
   
   private ArrayList<IVector> findCloseGrass() {
   ArrayList<IVector> closeGrass = new ArrayList<IVector>();
   float maxDist = worldHeight + worldWidth;
   for(int dx = -visionRange; dx<=visionRange; dx++) {
      for(int dy = -visionRange; dy<=visionRange; dy++) {
        if (pos.x+dx >= 0 && 
            pos.x+dx < worldWidth && 
            pos.y+dy >= 0 && 
            pos.y+dy < worldHeight) {
            if ( world.cells[pos.x+dx][pos.y+dy].hasGrass) {
              if ( dist(0, 0, dx, dy) < maxDist) {
                closeGrass.clear();
                println("found grass at ", pos.x+dx, pos.y+dy);
                closeGrass.add(new IVector(pos.x+dx, pos.y+dy));
              }
              if ( dist(0, 0, dx, dy) == maxDist) {
                println("found more grass at ", pos.x+dx, pos.y+dy);
                closeGrass.add(new IVector(pos.x+dx, pos.y+dy));
              }
            }
        }
      }  
    }
   return closeGrass;
   
 }
}
