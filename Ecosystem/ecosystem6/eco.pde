World world;
  final color blue = color(25, 25, 112);
  final color pink = color(255, 182, 193);
  int generations;
  int longestGeneration;
  int lifetime;
  int numF;
  int numC;
  float mutationRate;
  float bestCreature;
 

void setup() {
   fullScreen();
   //size(720,520);
   background(blue);
   mutationRate = 0.0001;
   generations = 0;
   longestGeneration = 0;
   lifetime = 0;
   numC = 20;
   numF = 600;
   bestCreature = 0;
   world = new World(numC, numF);
   smooth();
  
 }
  
void draw() {

    background(255);
   
    if((world.creatures.size()>1) && (world.creatures.size()<200)){
   
    world.run();
    lifetime++;
    } else{
    
    
    for(int i = world.creatures.size() -1; i >= 0; i--){
    Creature c =  world.creatures.get(i);
    c.age += c.energy;
    world.creatureClones.add(c);
    world.creatures.remove(i);
      
    }
    
    if(lifetime > longestGeneration) longestGeneration = lifetime;
    
    lifetime = 0;
    generations ++;
    
    world.food.clear();
    for (int i=0; i < numF; i++) {                            
      world.food.add(new Food(random(0, width), random(0, height))); 
    }
     
     world.getMaxFitness();                                         // calculate bloops fitness
    if (world.getMaxFitness() > bestCreature) {
      bestCreature = world.getMaxFitness();
    }
    
    world.selection();
    world.reproduction();
    
   
    }
}
