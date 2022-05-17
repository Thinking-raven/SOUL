abstract class Agent {
  World world;
  
  int speed;
  PVector direction;
  IVector pos;
  int size;
  color agentColor;
  Terrain[] habitat;  
  int visionRange;
  
  abstract public void move();
  abstract public void feed();
  
}
