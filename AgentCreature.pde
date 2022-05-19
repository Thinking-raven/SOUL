abstract class AgentCreature extends Agent {
  World world;

  int speed;
  PVector direction;
  IVector pos;
  int size;
  color creatureColor;
  Terrain[] habitat;  
  int visionRange;

  abstract public void move();
  abstract public void feed();
}
