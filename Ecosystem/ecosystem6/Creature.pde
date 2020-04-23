class Creature {
  
  DNA dna;
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector target;
  PVector desired;
  float maxForce;
  float heading;
  float wandertheta;
  float mass; 
  float r;
  float energy;
  float maxEnergy;
  float matingEnergy;
  float xoff; //for perlin movements 
  float yoff; //for perlin movements
  float DNArangeOfSight;
  float DNAmaxSpeed;
  float age;
  float matingAge;
  boolean mating;
 
  
  
  Creature() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);  
    acceleration = new PVector(0, 0);
    target = new PVector(0,0);
    desired = new PVector(0,0);
    maxForce = 0.01;
    heading = 0;
    wandertheta = 0;
    mass = 2;
    r = 10;
    energy = 20.0;
    maxEnergy = 500;
    matingEnergy = 130;
    DNArangeOfSight = 100.0;
    DNAmaxSpeed = 10;
    age = 0;
    matingAge = 150;
    mating = false;
    
  }

  Creature(float x, float y, DNA dna_) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);  
    acceleration = new PVector(0, 0); 
    target = new PVector(0,0);
    desired = new PVector(0,0);
    maxForce = 0.6;
    heading = 0;
    wandertheta = 0;
    maxEnergy = 500;
    matingEnergy = 130;
    mass = random(1, 4);
    r = 10;
    energy = 10.0;
    dna = dna_;
    DNAmaxSpeed =  dna.genes[0]; // 3 is the avarege speed of a creature
    DNArangeOfSight =  dna.genes[1]; // 90 pixels is the average range of sight of a creature
    age = 0;
    matingAge = 150;
    mating = false;
   
  }

 
 void run(){
   update();
   borders();
   wander();
   display();
     if(age > matingAge && random(1) < 0.000005) mating = true;
 }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  
  
 void wander() {
    float wanderR = 10;                       
    float wanderD = 30;                       
    float change = 0.3;
    wandertheta += random(-change, change);   

   
    PVector circlepos = velocity.copy();      
    circlepos.normalize();                    
    circlepos.mult(wanderD);                  
    circlepos.add(location);                  
 
    float h = velocity.heading();             
 
    PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h), wanderR*sin(wandertheta+h));
    target = PVector.add(circlepos, circleOffSet);    
    seek();  
 }
  
  
  void seek(){
    
    float record = 100000;
    PVector closest = new PVector(0,0);                 // we want to eat the closest food
    
    ArrayList<Food> food = world.getFood();
      for(int i = food.size()-1; i >= 0; i--){
        PVector foodLocation = food.get(i).location;
        float distance = PVector.dist(location,foodLocation);
      
      
        if(distance < record){
          record = distance;
          closest = foodLocation;
             
      }
         if(record < DNArangeOfSight){
          target = closest;                            //our target
         }
         if((distance < r/2) ) {
           //target = closest; 
           food.remove(i);
             energy =+ 10;  
   }
      
  }   
    
    if(mating){
      ArrayList<Creature> creatures = world.getCreature();
        for(int i = 0; i < creatures.size(); i++){
          PVector partnerLocation = creatures.get(i).location;
          float partnerDistance = PVector.dist(location, partnerLocation);
        
      if(partnerDistance < DNArangeOfSight && creatures.get(i).mating == true){
      target = partnerLocation;    //our target for mating
      
       if(partnerDistance < r){
          Creature partner = creatures.get(i);     
            
          DNA myGenes = dna;
          DNA partnerGenes = dna;
          
          DNA child = myGenes.crossover(partnerGenes);
          
          creatures.add(new Creature(location.x, location.y, child));
          energy =- 60;
          creatures.get(i).energy -=60;
          mating = false;
          creatures.get(i).mating = false;
      }
        
        }
     }   
    
    }
  
    
    
    
    desired = PVector.sub(target, location);
    desired.normalize();                              // Normalize desired and scale to maximum speed
    desired.mult(DNAmaxSpeed);    
    PVector steer = PVector.sub(desired, velocity);   // Steering = Desired minus Velocity
    steer.limit(maxForce);                            // Limit to maximum steering force
    applyForce(steer);
    }
  
 
  void update() { 
      
    velocity.add(acceleration);
    velocity.limit(DNAmaxSpeed);
    location.add(velocity);
    acceleration.mult(0);
    energy -= 0.08;
  }

  
   void borders() {
    if (location.x>width) location.x = 0;
    if (location.y>height) location.y =0;
    if (location.x<0) location.x = width;
    if (location.y<0) location.y = height;
  }

  boolean dead() {
    if (energy < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
  
  DNA getDNA(){
    return dna;
  }
  
    //void sight(ArrayList <PVector> food){
  //  for(int i = 0; i < food.size(); i++){
  //    float d = PVector.dist(location, food.get(i));
    
  //    if((d>0) && (d < DNArangeOfSight)){
  //       //PVector diff = PVector.sub(location, food.get(i));
  //       //diff.normalize();
  //      this.eat(food);
  //    }
  //  }
  //}
  
  
  //void eat(ArrayList<PVector> food){
  //  float record = 100000;
  //  PVector closet = new PVector(0,0);
    
  //  for(int i = 0; i < food.size(); i++){
  //    float d = dist(location.x, location.y, food.get(i).x, food.get(i).y);
  //    if(d < record){
  //      record = d;
  //      closet = food.get(i);
        
  //      }  
  //    }
    
  //   this.seek(closet);

  //   if(record < 5){
  //   if(food.remove(closet)){
  //      energy += 130;
  //     }
  //   }
  //}

  void display() {
    float theta = velocity.heading() + radians(90);
    stroke(0, energy+10);
    fill(25,25, 112);
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    ellipseMode(CENTER);
    ellipse(0, 0, r, r);    
    popMatrix();
  }
  

}
  
