World world;

int cellsize = 20;

float livechance = 100;


int interval = 100;
int lasttime = 0;

color land  = color(0, 110, 0);
color water = color(0, 0, 110);
color sand = color(150, 140, 140); 

int cells[][];

int[][] cellbuffer;

float empty = 4;
float t = 0;
void setup() {
  size(1920, 1080);


  cells = new int[width/cellsize][height/cellsize];
  cellbuffer = new int[width/cellsize][height/cellsize];

  stroke(40);
  noSmooth();

 
      }
    }
  }

}




void draw() {

  for (int x=0; x<width/cellsize; x++) {
    for (int y=0; y<height/cellsize; y++) {
        
        rect(cellsize*x,cellsize*y,cellsize,cellsize);

  }
  }
}
