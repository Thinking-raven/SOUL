class AgentBunny extends AgentCreature { //<>//
  AgentBunny(World world) {
    this.world = world;

    visionRange = 5;

    pos = new IVector(round(random(0, worldHeight-1)), round(random(0, worldHeight-1)));
    print("H");
  }

  public void setPosition(IVector pos) {
    this.pos.x = max(min(pos.x, worldWidth-1), 0);
    this.pos.y = max(min(pos.y, worldHeight-1), 0);
  }

  public void move() {
    println("current pos ", pos.x, pos.y);
    ArrayList<IVector> grass = findCloseGrass();
    // print("found", grass.size());
    IVector target, direction;
    if ( grass.size() == 0) {
      setPosition(new IVector(round(random(-1, 1))+pos.x, round(random(-1, 1))+pos.y));
    } else {
      int i = int(random(grass.size()));
      target = grass.get(i);
      direction = new IVector(target.x-pos.x, target.y-pos.y);
      println("target is ", target.x, target.y);
      IVector steps  = direction.normalize();
      println("steps = ", steps.x, steps.y);
      setPosition(steps.add(pos));
      println("moving to grass", pos.x, pos.y);
    }
  }

  public void feed() {
    world.cells[pos.x][pos.y].hasGrass = false;
  }

  private ArrayList<IVector> findCloseGrass() {
    ArrayList<IVector> closeGrass = new ArrayList<IVector>();
    float maxDist = worldWidth + worldHeight;
    for (int dx = -visionRange; dx<=visionRange; dx++) {
      for (int dy = -visionRange; dy<=visionRange; dy++) {
        if (pos.x+dx >= 0 && 
          pos.x+dx < worldWidth && 
          pos.y+dy >= 0 && 
          pos.y+dy < worldHeight) {
          if ( world.cells[pos.x+dx][pos.y+dy].hasGrass) {
            if ( mag(dx, dy) < maxDist) {
              closeGrass.clear();
              println("found grass at ", pos.x+dx, pos.y+dy, maxDist);
              closeGrass.add(new IVector(pos.x+dx, pos.y+dy));
              println("dx, dy = ", dx, dy);
              maxDist = mag(dx, dy);
            }
            if ( mag(dx, dy) == maxDist) {
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
