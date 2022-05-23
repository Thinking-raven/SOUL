class AgentFox extends AgentCreature {
  AgentFox(World world) {

    this.world = world; 
    
    this.health = 200;
    
    visionRange = 5;
    agentColor = color(220, 100, 10); 
    pos = new IVector(round(random(0, worldHeight-1)), round(random(0, worldHeight-1)));
    println("Fox at " + pos.x, pos.y);
  }

  public void move() {
    //println("Fox.move", pos.x, pos.y, health);
    ArrayList<AgentBunny> bunnies = world.findClosestBunnies(pos.x, pos.y, visionRange);
    AgentBunny target;
    IVector direction;
    if ( bunnies.size() == 0) {
      setPosition(new IVector(round(random(-1, 1))+pos.x, round(random(-1, 1))+pos.y));
    } else {
      println("Fox spotted a bunny!!");
      int i = int(random(bunnies.size()));
      target = bunnies.get(i);
      direction = new IVector(target.pos.x-pos.x, target.pos.y-pos.y);
      //println("target is ", target.pos.x, target.pos.y);
      IVector steps  = direction.normalize();
      if (mag(steps.x, steps.y) > 0) {
        // Fox uses energy to hunt
        health -= 4;
      }
      setPosition(steps.add(pos));
      //println("moving to grass", pos.x, pos.y);
    }
}

  public void feed() {
    ArrayList<AgentBunny> bunnies = world.findClosestBunnies(pos.x, pos.y, 0);
    
    if (bunnies.size() > 0) {
      println("Fox eating bunny...", pos.x, pos.y, health, bunnies.get(0).getHealth()); 
      bunnies.get(0).consume(5);
      health += 5;
    }
    

  }
}
