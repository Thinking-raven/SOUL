class EarthCell extends Cell {
  
  EarthCell() {
    cellColor = color(132,98,81);
    //println("creating LandCell");
    
  }
  public color getCellColor() {
    if(hasGrass){
      return color(57,171,41);
      
    }
    
    return cellColor;
  }
}
