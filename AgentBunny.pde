class AgentBunny extends AgentCreature { //<>//

  int consumptionRate = 3;
  
  AgentBunny(World world) {
    this.world = world;

    visionRange = 5;
    agentColor = color(255, 240, 240); // Pink
    pos = new IVector(round(random(0, worldHeight-1)), round(random(0, worldHeight-1)));
  }


  protected void move() {
    //println("current pos ", pos.x, pos.y);
    ArrayList<AgentGrass> grass = world.findClosestGrass(pos.x, pos.y, visionRange);
    // print("found", grass.size());
    AgentGrass target;
    IVector direction;
    if ( grass.size() == 0) {
      setPosition(new IVector(round(random(-1, 1))+pos.x, round(random(-1, 1))+pos.y));
    } else {
      int i = int(random(grass.size()));
      target = grass.get(i);
      direction = new IVector(target.pos.x-pos.x, target.pos.y-pos.y);
      //println("target is ", target.pos.x, target.pos.y);
      IVector steps  = direction.normalize();
      if (mag(steps.x, steps.y) > 0) {
        // Fox uses energy to hunt
        health -= 1;
      }

      //println("steps = ", steps.x, steps.y);
      setPosition(steps.add(pos));
      //println("moving to grass", pos.x, pos.y);
    }
  }

  protected void feed() {
    ArrayList<AgentGrass> grass = world.findClosestGrass(pos.x, pos.y, 0);
    
    if (grass.size() > 0) { //<>//
      //println("Bunny eating...", pos.x, pos.y); 
      grass.get(0).consume(consumptionRate);
      health += consumptionRate;
    }
    
    //world.cells[pos.x][pos.y].health -= 1;
  }

  
  public boolean consume(int amount) {
    health -= amount;
    if (health <= 0) {
      println("Bunny died!!!");
      return false;
    } 
    return true;  
  }
  


  //private ArrayList<IVector> findCloseGrass() {
  //  ArrayList<IVector> closeGrass = new ArrayList<IVector>();
  //  float maxDist = worldWidth + worldHeight;
  //  for (int dx = -visionRange; dx<=visionRange; dx++) {
  //    for (int dy = -visionRange; dy<=visionRange; dy++) {
  //      if (pos.x+dx >= 0 && 
  //        pos.x+dx < worldWidth && 
  //        pos.y+dy >= 0 && 
  //        pos.y+dy < worldHeight) {
  //        if ( world.cells[pos.x+dx][pos.y+dy].hasGrass) {
  //          if ( mag(dx, dy) < maxDist) {
  //            closeGrass.clear();
  //            println("found grass at ", pos.x+dx, pos.y+dy, maxDist);
  //            closeGrass.add(new IVector(pos.x+dx, pos.y+dy));
  //            println("dx, dy = ", dx, dy);
  //            maxDist = mag(dx, dy);
  //          } //<>//
  //          if ( mag(dx, dy) == maxDist) {
  //            println("found more grass at ", pos.x+dx, pos.y+dy);
  //            closeGrass.add(new IVector(pos.x+dx, pos.y+dy));
  //          } //<>//
  //        }
  //      }
  //    }
  //  }
  //  return closeGrass;
  //} //<>//
  
  
  
}
