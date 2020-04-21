class Creature {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float maxForce;
  float heading;
  float mass; 
  float energy;

  Creature() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);  
    acceleration = new PVector(0, 0); 
    maxSpeed = 0.01;
    maxForce = 0.01;
    heading = 0;
    mass = 2;
    energy = 20.0;
  }

  Creature(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);  
    acceleration = new PVector(0, 0); 
    maxSpeed = 2;
    maxForce = 0.6;
    heading = 0;
    mass = random(1, 4);
    energy = 20.0;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  void eat(ArrayList<PVector> food){
    float record = 100000;
    PVector closet = new PVector(0,0);
    
    for(int i = 0; i < food.size(); i++){
      float d = dist(location.x, location.y, food.get(i).x, food.get(i).y);
      if(d < record){
        record = d;
        closet = food.get(i);
        energy += 10;
        }  
      }
    
     this.seek(closet);

     if(record < 5){
     food.remove(closet);
     }
  }
 
  
  
  void seek(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.limit(maxSpeed);
    PVector steeringForce = PVector.sub(desired, velocity);
    steeringForce.limit(maxForce);
    this.applyForce(steeringForce);
  }

  void update() { 
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    heading = velocity.heading();
    acceleration.mult(0);
    energy -= 5;
  }

   void borders() {
    if (location.x>width) location.x = 0;
    if (location.y>height) location.y =0;
    if (location.x<0) location.x = width;
    if (location.y<0) location.y = height;
  }


  void display() {
    fill(pink);
    pushMatrix();
    translate(location.x, location.y);
    rotate(heading);
    ellipse(-mass*10, -mass*5, 30, 30);
    popMatrix();
  }
  
  boolean dead() {
    if (energy < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
  
}

