abstract class Agent {
  
  World world;
  IVector pos;
  color agentColor;

  
  abstract public void update();

  public void setPosition(IVector pos) {
    this.pos.x = max(min(pos.x, worldWidth-1), 0);
    this.pos.y = max(min(pos.y, worldHeight-1), 0);
  }

  public color getColor() {
    return agentColor;
  }
  protected int health = 5;
  
  public int getHealth() { return health; }
  public void setHealth(int health) { this.health = health; }  
}
