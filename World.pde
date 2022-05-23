class World {
  final int grassSeeds = 100;
  final int numBunnies = 20;
  final int numFoxes = 3;
  final int grassDensity = 10;

  int updateInterval = 100;
  //laver vores class array cells.
  Cell[][] cells;
  public ArrayList<AgentGrass> grasses = new ArrayList<AgentGrass>();
  public ArrayList<AgentBunny> bunnies = new ArrayList<AgentBunny>();
  public ArrayList<AgentFox> foxes = new ArrayList<AgentFox>();

  //laver to fields som er vores height og width variabler
  int worldHeight, worldWidth;

  // constructor vores world og giver den nogle parametre.
  World(int width, int height) {
    worldHeight = height;
    worldWidth = width;
    initWorld();
  }

  private void initWorld() {
    print("initializing world...", worldHeight, worldWidth);
    cells = new Cell[worldWidth][worldHeight];
    for (int y=0; y<worldHeight; y++) {
      for (int x=0; x<worldWidth; x++) {
        cells[x][y] = createRandomCell();
      }//x
    }//y

    dilateWorld(); 

    plantGrass();
    spawnBunnies(numBunnies);
    spawnFoxes(numFoxes);

    println("done");
  }

  private Cell createRandomCell() {
    //kører nogle if kommandoer som tager giver en tilfældig celle i return
    int t = int(random(3));
    if (t == 0) {
      return new WaterCell();
    }
    if (t == 1) {
      return new EarthCell();
    }
    return new SandCell();
  }

  public void draw(int cellsize) {

    //laver et for loop som fylder skærmen ud med cells
    for (int y=0; y<worldHeight; y++) {
      for (int x=0; x<worldWidth; x++) {
        //  println("x="+x+" y=" +y);
        fill(cells[x][y].getCellColor());
        //tegner kasserne som bliver til celler
        rect(x*cellsize, y*cellsize, cellsize, cellsize);
      }
    }

    for ( AgentGrass grass : grasses) {
      fill(grass.getColor()); // TODO Skal bruge AgentGas
      rect(grass.pos.x*cellsize, grass.pos.y*cellsize, cellsize, cellsize);
    }

    for ( AgentBunny bunny : bunnies) {
      //size(10, 10);
      fill(bunny.getColor());
      int bunnySize = min(bunny.getHealth()/5, 12);
      ellipse(bunny.pos.x*cellsize + cellsize/2, bunny.pos.y*cellsize + cellsize/2, bunnySize, bunnySize);
      //println("bunny at position", bunny.pos);
    }
    
     for ( AgentFox fox : foxes) {
      fill(fox.getColor());
      int foxSize = min(fox.getHealth()/4, 15);
      ellipse(fox.pos.x*cellsize + cellsize/2, fox.pos.y*cellsize + cellsize/2, foxSize, foxSize);
      //println("fox at position", fox.pos.x, fox.pos.y);
    }
  }

  private ArrayList<Cell> getCellCluster(int x, int y) {
    return getCellCluster(x, y, 1);
  }

  private ArrayList<Cell> getCellCluster(int x, int y, int size) {
    ArrayList<Cell> cluster = new ArrayList<Cell>();
    for (int dx = -size; dx<=size; dx++) {
      for (int dy = -size; dy<=size; dy++) {
        if (x+dx >= 0 &&
          x+dx < worldWidth &&
          y+dy >= 0 &&
          y+dy < worldHeight) {
          cluster.add(cells[x+dx][y+dy]);
        }
      }
    }
    return cluster;
  }


  private <T extends Agent> ArrayList<T> findClosest(ArrayList<T> agents, int x, int y, float maxDist) {
    ArrayList<T> closest = new ArrayList<T>();

    for (T agent : agents) {
      if (dist(agent.pos.x, agent.pos.y, x, y) < maxDist) {
        closest.clear();
        closest.add(agent);
        maxDist = dist(agent.pos.x, agent.pos.y, x, y);
      } else if (dist(agent.pos.x, agent.pos.y, x, y) == maxDist) {
        closest.add(agent);
      }
    }
    return closest;
  }

  public ArrayList<AgentBunny> findClosestBunnies(int x, int y, float maxDist) {
    return findClosest(bunnies, x, y, maxDist);
  }

  public ArrayList<AgentGrass> findClosestGrass(int x, int y, float maxDist) {
    return findClosest(grasses, x, y, maxDist);
  }

  public void changeCell(int x, int y) {
    ArrayList<Cell> cluster = getCellCluster(x, y);
    int g = int(random(cluster.size()));
    Cell c = cluster.get(g);
    if (c instanceof SandCell) {
      cells[x][y] = new SandCell();
    } else if (c instanceof WaterCell) {
      cells[x][y] = new WaterCell();
    } else if (c instanceof EarthCell) {
      cells[x][y] = new EarthCell();
    }
  }

  public void growCell(int x, int y) {
    ArrayList<Cell> cluster = getCellCluster(x, y);
    int g = int(random(cluster.size()));
    Cell c = cluster.get(g);
    if (c instanceof SandCell) {
      cells[x][y] = new SandCell();
    } else if (c instanceof WaterCell) {
      cells[x][y] = new WaterCell();
    } else if (c instanceof EarthCell) {
      cells[x][y] = new EarthCell();
    }
  }

  /**
   * Performs dilation on cluster - creating a more even world
   */
  public void dilateCluster(int x, int y) {
    ArrayList<Cell> cluster = getCellCluster(x, y);
    int numSand = 0;
    int numLand = 0;
    int numWater = 0;

    for (Cell c : cluster) {
      if (c instanceof EarthCell) {
        numLand += 1;
      } else if (c instanceof WaterCell) {
        numWater += 1;
      } else if (c instanceof SandCell) {
        numSand += 1;
      }
    }

    int i = numSand;
    Terrain terrain = Terrain.SAND;

    if (numWater >= i) {
      i = numWater;
      terrain = Terrain.WATER;
    }

    if (numLand >= i) {
      terrain = Terrain.EARTH;
    }

    switch (terrain) {
    case SAND:
      cells[x][y] = new SandCell();
      break;
    case EARTH:
      cells[x][y] = new EarthCell();
      break;
    case WATER:
      cells[x][y] = new WaterCell();
    }
  } // dilateCluster

  public void updateWorld() {
    //int locx = int(random(0, worldWidth));
    //int locy = int(random(0, worldHeight));
    //grow(locx, locy);

    if (updateInterval == 0) {
      updatePlants();
      updateBunnies();
      updateFoxes();
      updateInterval = 50;
    }
    updateInterval -= 1;

    // changeCell(locx, locy);
  } // updateWorld

  public void dilateWorld() {
    for (int locx = 0; locx < worldWidth; locx++) {
      for (int locy = 0; locy < worldHeight; locy++) {
        dilateCluster(locx, locy);
        // changeCell(locx, locy);
      }
    }
  }

  private void updateBunnies() {
    ArrayList<AgentCreature> deadBunnies = new ArrayList<AgentCreature>();
    for ( AgentCreature bunny : bunnies) {
      if (bunny.getHealth() <= 0) {
        println("Bunny died");
        deadBunnies.add(bunny);
      } else {
        bunny.update();
      }
    }
    bunnies.removeAll(deadBunnies);
  }

  private void updateFoxes() {
    ArrayList<AgentCreature> deadFoxes = new ArrayList<AgentCreature>();
    for ( AgentCreature fox : foxes) {
      if (fox.getHealth() <= 0) {
        println("Fox starved to death");
        deadFoxes.add(fox);
      } else {
        fox.update();
      }
    }
    foxes.removeAll(deadFoxes);
  }

  private void updatePlants() {
    ArrayList<AgentPlant> deadPlants = new ArrayList<AgentPlant>();
    for ( AgentPlant plant : grasses) {
      if (plant.getHealth() <= 0) {
        println("Grass died");
        deadPlants.add(plant);
      } else {
        plant.update();
      }
    }
    grasses.removeAll(deadPlants);
  }

  public void grow(int x, int y) {
    //int grass = 0;
    ArrayList<Cell> cluster = getCellCluster(x, y);
      for (Cell c : cluster) {
        if ( cells[x][y] instanceof EarthCell || cells[x][y] instanceof SandCell) {
        //if (c.hasGrass) {
        //  grass += 1;
        //}
      }
      //if ( 1 - float(grass)/float(cluster.size()) < cells[x][y].grassODDS) {
      //  cells[x][y].hasGrass = true;
      //  //print("*");
      //}
    }
  }


  public void plantGrass() {
    println("Planting Grass...");
    for (int y=0; y < worldHeight; y++) {
      for (int x=0; x < worldWidth; x++) {
        if ( cells[x][y] instanceof EarthCell) {
          if (cells[x][y].chanceOfGrass > random(0, 100)) {
            grasses.add(new AgentGrass(this, x, y));
          }
        }
      }//x
    }//y
  }


//  private <T extends AgentCreature> void spawnCreatures(ArrayList<T> creatures, int numCreatures) {
//    int i = numCreatures;
//    while ( i > 0) {
//      creatures.add(new T(this));  // Can't do new T(); :-(
//       -= 1;
//      print("B");
//    }
//  }


  private void spawnFoxes(int numFoxes) {
    print("spawning foxes");
    int f = numFoxes;
    while ( f > 0) {
      foxes.add(new AgentFox(this));
      f -= 1;
      print("F");
    }
  }

  private void spawnBunnies(int numBunnies) {
    print("spawning bunnies");
    int b = numBunnies;
    while ( b > 0) {
      bunnies.add(new AgentBunny(this));
      b -= 1;
      print("B");
    }
  }
} // WORLD
