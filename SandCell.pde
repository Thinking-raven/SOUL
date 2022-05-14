class SandCell extends Cell { 
  SandCell() {
    cellColor = color(220,221,176);
    grassODDS = 0.1;
   //println("creating SandCell");
  }
  
  public color getCellColor() {
    if(hasGrass){
      return color(57,171,41);  
    }
    return cellColor;
  }
}
