class AgentGrass extends AgentPlant {
  
  final int SPREAD_THRESHOLD = 100;
  
  AgentGrass(World world, int x, int y) {
    this.world = world;
    pos = new IVector(x,y);
    setPosition(pos); // Call setPosition to make sure that we are not out of bounds
    agentColor = color(57, 171, 41); // GREEN
    print("G");
  }
  
  public void setPosition(IVector pos) {
    this.pos.x = max(min(pos.x, worldWidth-1), 0);
    this.pos.y = max(min(pos.y, worldHeight-1), 0);
  }
  
  public void update() {
    grow();
  }
  
  public boolean consume(int amount) {
    health -= amount;
    //println("Grass consumed", pos.x, pos.y, health);
    if (health <= 0) {
      return false;
    } 
    return true;  
  }
  
  
  private void grow() {
    health += 2;
    if (health > SPREAD_THRESHOLD) {
      spread();
    }
  }
  
  private void spread() {
    
  }
}
