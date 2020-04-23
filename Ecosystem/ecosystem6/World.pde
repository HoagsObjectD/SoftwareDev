class World{

  ArrayList<Creature> creatures; 
  ArrayList<Food> food;
  ArrayList<Creature> creatureClones;
  ArrayList<Creature> matingPool;
  DNA dna;  
  float foodSpawnRate;
      

  World(int numC, int numF){
    
    foodSpawnRate = 0.5;
    matingPool = new ArrayList<Creature>();
    creatureClones = new ArrayList<Creature>();
    creatures = new ArrayList<Creature>();
    //dna = new DNA();
   for(int i = 0; i < numC; i++){
      float x = random(width);
      float y = random(height);
      dna = new DNA();
      creatures.add(new Creature(x,y,new DNA()));
    
   }
   food = new ArrayList<Food>();
    //populate the array with food
      for(int i = 0; i < numF ; i++){
      food.add(new Food(random(width), random(height))); 
      }    
 }  
  

  void run(){
  
    //deal with creatures
      for(int i = creatures.size()-1; i > 0; i--){
      Creature c = creatures.get(i);
        c.run();
        
      
    if(c.dead()){
      creatures.remove(c);
      creatureClones.add(c);
      }else{
        c.age++;
      }

   }
    
    //display food
    for (int i = food.size()-1; i >= 0; i--) {                  
      Food f = food.get(i);                                     
      f.run();
      //if (food.size() > 500) food.remove(0);     // max plants num
    }
  
    if (random(1) < foodSpawnRate) food.add(new Food(random(0, width), random(0, height)));

}
  void selection(){
    
    float maxFitness = getMaxFitness();
    for (int i = 0; i < creatureClones.size(); i++) {
      float fitnessNormal = map(creatureClones.get(i).age, 0, maxFitness, 0, 1);
      int n = (int) (fitnessNormal * 100);
      for (int j = 0; j < n; j++) {
             
          matingPool.add(creatureClones.get(i));
      }
    }
  
  
  }
  
  
  void reproduction(){
    for(int i = 0; i < numC; i++){
      int m = int(random(matingPool.size()));
      int d = int(random(matingPool.size()));
      
      Creature mother = matingPool.get(m);
      Creature father = matingPool.get(d);
      DNA motherGenes = mother.getDNA();
      DNA fatherGenes = father.getDNA();
      
      DNA child = motherGenes.crossover(fatherGenes);
      child.mutate(mutationRate);
       
      creatures.add(new Creature(random(width), random(height), child));
      
    }
     
  }
  
  float getMaxFitness() {
    float record = 0;
    for (int i = 0; i < creatureClones.size(); i++) {
      if (creatureClones.get(i).age > record) {    // in our case fitness is just "how long did you survived"
        record = creatureClones.get(i).age;
      }
    }
    return record;
  }
  
  
  ArrayList getCreature(){
    return creatures;
  }
  
  ArrayList getFood(){
    return food;
  }
}
