class AgentGrass extends AgentPlant {
  AgentGrass(World world) {
    this.world = world;
    pos = new IVector(round(random(0, worldHeight-1)), round(random(0, worldHeight-1)));
  }
  public void setPosition(IVector pos) {
    this.pos.x = max(min(pos.x, worldWidth-1), 0);
    this.pos.y = max(min(pos.y, worldHeight-1), 0);
  }
}
