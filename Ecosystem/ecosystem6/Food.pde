class Food {
 
  PVector location;
 
  Food(float x, float y) {
    location = new PVector(x, y);
  }
 
  void run() {
    display();
  }  
 
  void display() {
    stroke(0);
    fill(200, 200, 0);
    ellipse(location.x, location.y, 5, 5);
  }
}
