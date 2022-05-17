class IVector {
  
 int x;
 int y; 
 
 IVector(int x, int y) {
   this.x = x;
   this.y = y;
 }
 
public IVector normalize() {
  float length = mag(x, y);
  return new IVector(round(x/length), round(y/length));
 }
 
 public void add(IVector v) { 
   this.x += v.x;
   this.y += v.y;
 }
}
