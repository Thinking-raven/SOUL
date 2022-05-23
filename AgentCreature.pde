abstract class AgentCreature extends Agent {
  World world;

  int speed;
  PVector direction;
  int size;
  Terrain[] habitat;  
  int visionRange;

  abstract protected void move();
  abstract protected void feed();
  
  //protected AgentCreature(World world) {
  //  this.world = world;  
  //}
  
  public void update() {
    health -= 1; // All Creatures uses one eneryg 
    move();
    feed();
  }
}
