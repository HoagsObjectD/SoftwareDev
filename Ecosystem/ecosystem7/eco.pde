World world;
final color blue = color(25, 25, 112);
final color pink = color(255, 182, 193);
int generations;
int longestGeneration;
int lifetime;
int numF;
int numC;
int numPredators;
float mutationRate;
float bestCreature;
float bestPredator;


void setup() {
  fullScreen();
  //size(720,520);
  background(blue);
  mutationRate = 0.0001;
  generations = 0;
  longestGeneration = 0;
  lifetime = 0;
  numC = 70;
  numF = 500;
  numPredators = 7;
  bestCreature = 0;
  bestPredator = 0;
  world = new World(numC, numF);
  smooth();
}

void draw() {

  background(255);

  if ((world.creatures.size()>1) && (world.carnivores.size() > 1)) {

    world.run();
    lifetime++;
  } else {


    for (int i = world.creatures.size() -1; i >= 0; i--) {
      Creature c =  world.creatures.get(i);
      c.age += c.energy;
      world.creatureClones.add(c);
      world.creatures.remove(i);
    }  
    
    for (int i = world.carnivores.size() -1; i >= 0; i--) {
      Carnivore carnivore =  world.carnivores.get(i);
      carnivore.age += carnivore.energy;
      world.carnivoreClones.add(carnivore);
      world.carnivores.remove(i);
    }  
    

    if (lifetime > longestGeneration) longestGeneration = lifetime;

    lifetime = 0;
    generations ++;

    world.food.clear();
    for (int i=0; i < numF; i++) {                            
      world.food.add(new Food(random(0, width), random(0, height)));
    }

    world.getMaxFitness();                                         
    if (world.getMaxFitness() > bestCreature) {
      bestCreature = world.getMaxFitness();
    }
    
    world.selection();
    world.reproduction();
  
   world.getMaxFitnessCarnivore();                                         
    if (world.getMaxFitnessCarnivore() > bestPredator) {
      bestPredator = world.getMaxFitnessCarnivore();
    }
    
    world.selectionCarnivore();
    world.reproductionCarnivore();
    
  }
}
