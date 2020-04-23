class Carnivore {

  CarnivoreDNA dna;
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



  Carnivore() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);  
    acceleration = new PVector(0, 0);
    target = new PVector(0, 0);
    desired = new PVector(0, 0);
    maxForce = 0.01;
    heading = 0;
    wandertheta = 0;
    mass = 2;
    r = 6;
    energy = 40.0;
    maxEnergy = 600;
    matingEnergy = 130;
    DNArangeOfSight = 100.0;
    DNAmaxSpeed = 10;
    age = 0;
    matingAge = 150;
    mating = false;
  }

  Carnivore(float x, float y, CarnivoreDNA dna_) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);  
    acceleration = new PVector(0, 0); 
    target = new PVector(0, 0);
    desired = new PVector(0, 0);
    maxForce = 0.6;
    heading = 0;
    wandertheta = 0;
    maxEnergy = 600;
    matingEnergy = 130;
    mass = random(1, 4);
    r = 6;
    energy = 40.0;
    dna = dna_;
    DNAmaxSpeed =  dna.genes[0]; 
    DNArangeOfSight =  dna.genes[1]; 
    age = 0;
    matingAge = 100;
    mating = false;
  }

  void run() {
    update();
    borders();
    wander();
    display();
      if (age > matingAge && random(1) < 0.005) mating = true;
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

  void seek() {

    
      
    
    float record = 100000;
    PVector closest = new PVector(0, 0);                 // we want to eat the closest food

    ArrayList<Creature> herbivores = world.getCreatures();
    for (int i = herbivores.size()-1; i >= 0; i--) {
      PVector herbivoreLocation = herbivores.get(i).location;
      float distance = PVector.dist(location, herbivoreLocation);


      if (distance < record) {
        record = distance;
        closest = herbivoreLocation;
      }
      if (record < DNArangeOfSight) {
        target = closest;                            //our target
      }
      if ((distance < r/2) ) {
        //target = closest; 
        herbivores.remove(i);
        energy =+ 80;              //eating another creature gives more enrgy than eating plants
      }
    }   

    if (mating) {
      ArrayList<Carnivore> carnivores = world.getCarnivores();
      for (int i = 0; i < carnivores.size(); i++) {
        PVector partnerLocation = carnivores.get(i).location;
        float partnerDistance = PVector.dist(location, partnerLocation);

        if (partnerDistance < DNArangeOfSight && carnivores.get(i).mating == true) {
          target = partnerLocation;    //our target for mating

          if (partnerDistance < DNArangeOfSight) {
            Carnivore partner = carnivores.get(i);     

            CarnivoreDNA myGenes = dna;
            CarnivoreDNA partnerGenes = dna;

            CarnivoreDNA child = myGenes.crossover(partnerGenes);

            carnivores.add(new Carnivore(location.x, location.y, child));
            energy =- 60;
            carnivores.get(i).energy -=60;
            mating = false;
            carnivores.get(i).mating = false;
          }
        }
      }
    }
  
  

    desired = PVector.sub(target, location);
    desired.normalize();                              
    desired.mult(DNAmaxSpeed);    
    PVector steer = PVector.sub(desired, velocity);   
    steer.limit(maxForce);                            
    applyForce(steer);
  }

  boolean dead() {
    if (energy < 0.0) {
      return true;
    } else {
      return false;
    }
  }

  CarnivoreDNA getDNA() {
    return dna;
  }

  void update() { 

    velocity.add(acceleration);
    velocity.limit(DNAmaxSpeed);
    location.add(velocity);
    acceleration.mult(0);
    energy -= 0.08;      // predators loose more energy
  }

  void borders() {
    if (location.x>width) location.x = 0;
    if (location.y>height) location.y =0;
    if (location.x<0) location.x = width;
    if (location.y<0) location.y = height;
  }

  void display() {


    float theta = velocity.heading() + radians(90); 
    fill(#E32E2E);  

    stroke(0, energy+10);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(); 
    popMatrix();
  }
}
