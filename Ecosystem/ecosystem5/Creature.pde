//Donat Salihu

class Creature {
  
  DNA dna;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxForce;
  float heading;
  float mass; 
  float energy;
  float xoff; //for perlin movements 
  float yoff; //for perlin movements
  float DNArangeOfSight;
  float DNAmaxSpeed;
  
  
  Creature() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);  
    acceleration = new PVector(0, 0); 
    maxForce = 0.01;
    heading = 0;
    mass = 2;
    energy = 20.0;
    DNArangeOfSight = 100.0;
    DNAmaxSpeed = 10;
    
  }

  Creature(float x, float y, DNA dna_) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);  
    acceleration = new PVector(0, 0); 
    //maxSpeed = 2;
    maxForce = 0.6;
    heading = 0;
    mass = random(1, 4);
    energy = 50.0;
    dna = dna_;
    DNAmaxSpeed = 3 * dna.genes[0]; // 3 is the avarege speed of a creature
    DNArangeOfSight = 90 * dna.genes[0]; // 90 pixels is the average range of sight of a creature
    
   
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  //return locations for the offspring
 float getLocationX(){
   return location.x;
 }
 float getLocationY(){
   return location.y;
 }
 
 
  void sight(ArrayList <PVector> food){
    for(int i = 0; i < food.size(); i++){
      float d = PVector.dist(location, food.get(i));
    
      if((d>0) && (d < DNArangeOfSight)){
         //PVector diff = PVector.sub(location, food.get(i));
         //diff.normalize();
        this.eat(food);
      }
    }
  }
  
  
  void eat(ArrayList<PVector> food){
    float record = 100000;
    PVector closet = new PVector(0,0);
    
    for(int i = 0; i < food.size(); i++){
      float d = dist(location.x, location.y, food.get(i).x, food.get(i).y);
      if(d < record){
        record = d;
        closet = food.get(i);
        
        }  
      }
    
     this.seek(closet);

     if(record < 5){
     if(food.remove(closet)){
        energy += 130;
       }
     }
  }

  //mate if the creature energy is 130units or above
  //Creature mateC(ArrayList<Creature> creatures){
  //  if(energy >= 130){
  //    this.mate(creatures);
  //  }
  //   return new Creature(location.x, location.y, dna);
  //}
   
   
  
  void seek(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.limit(DNAmaxSpeed);
    PVector steeringForce = PVector.sub(desired, velocity);
    steeringForce.limit(maxForce);
    this.applyForce(steeringForce);
  }
  
 
  void update() { 
   
    //Perlin noise movements
    float vx = map(noise(xoff),0,1,-DNAmaxSpeed,DNAmaxSpeed);
    float vy = map(noise(yoff),0,1,-DNAmaxSpeed,DNAmaxSpeed);
    xoff += random(0.001, 0.1);
    yoff += random(0.001, 0.1);
    PVector perlin = new PVector(vx,vy);
    ////////////////////////////////////////////////////
    
    location.add(perlin);
    velocity.add(acceleration);
    velocity.limit(DNAmaxSpeed);
    location.add(velocity);
    heading = velocity.heading();
    acceleration.mult(0);
    energy -= 0.08;
  }

  float getEnergy(){
    return energy;
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
  
  
  //void seekForMating(Creature c){
  //  PVector desired = PVector.sub(c.location, location);
  //  desired.normalize();
  //  desired.limit(DNAmaxSpeed);
  //  PVector steeringForce = PVector.sub(desired, velocity);
  //  steeringForce.limit(maxForce);
  //  this.applyForce(steeringForce);
  //}
  
  //void reproduction(Creature partner){
  //  Creature c = new Creature();
  //  partner =  new Creature();
        
        
  //      DNA cGenes = c.getDNA();
  //      DNA partnerGenes = partner.getDNA();
  //      //mate the genes
  //      DNA child = cGenes.crossover(partnerGenes);
   
  //    ;
  //  }
       
  
  //Creature mate(){
 
  //  for(int i = 0; i < creatures.size(); i++){
  //    Creature c = creatures.get(i);
  //    float d = PVector.dist(location, creatures.get(i).location);
  //     if((d > 0) && (d < DNArangeOfSight)){
  //       this.reproduction(c);
  //     }
  //  }
  //    return new Creature(location.x, location.y,dna );
  //}
  
  void display() {
    fill(pink);
    pushMatrix();
    translate(location.x, location.y);
    rotate(heading);
    ellipse(-mass*10, -mass*5, 30, 30);
    popMatrix();
  }

}
  
 
