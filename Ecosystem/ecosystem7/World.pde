class World {

 
  ArrayList<Food> food;
  ArrayList<Creature> creatures;
  ArrayList<Creature> creatureClones;
  ArrayList<Creature> matingPool;
  ArrayList<Carnivore> carnivores;
  ArrayList<Carnivore> carnivoreClones;
  ArrayList<Carnivore> carnivoreMatingPool;
  float foodSpawnRate;


  World(int numC, int numF) {

    foodSpawnRate = 0.5;
    matingPool = new ArrayList<Creature>();
    carnivoreMatingPool = new ArrayList<Carnivore>();
    creatureClones = new ArrayList<Creature>();
    carnivoreClones = new ArrayList<Carnivore>();
    
    creatures = new ArrayList<Creature>();
    //dna = new DNA();
    for (int i = 0; i < numC; i++) {
      float x = random(width);
      float y = random(height);
      creatures.add(new Creature(x, y, new DNA()));
    }

    carnivores = new ArrayList<Carnivore>();
    for (int i = 0; i < numPredators; i++) {
      float x = random(width);
      float y = random(height);
      carnivores.add(new Carnivore(x, y, new CarnivoreDNA()));
    }

    food = new ArrayList<Food>();
    //populate the array with food
    for (int i = 0; i < numF; i++) {
      food.add(new Food(random(width), random(height)));
    }
  }  


  void run() {

    //deal with creatures
    for (int i = creatures.size()-1; i > 0; i--) {
      Creature c = creatures.get(i);
      c.run();
   
   if (c.dead()) {
        creatures.remove(c);
        creatureClones.add(c);
      } else {
        c.age++;
      }
    }

    for (int i = carnivores.size()-1; i > 0; i--) {
      Carnivore carnivore = carnivores.get(i);
      carnivore.run();


      if (carnivore.dead()) {
        carnivores.remove(carnivore);
        carnivoreClones.add(carnivore);
      } else {
        carnivore.age++;
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
  void selection() {

    float maxFitness = getMaxFitness();
    for (int i = 0; i < creatureClones.size(); i++) {
      float fitnessNormal = map(creatureClones.get(i).age, 0, maxFitness, 0, 1);
      int n = (int) (fitnessNormal * 100);
      for (int j = 0; j < n; j++) {

        matingPool.add(creatureClones.get(i));
      }
    }
  }

  void selectionCarnivore() {

    float maxFitness = getMaxFitnessCarnivore();
    for (int i = 0; i < carnivoreClones.size(); i++) {
      float fitnessNormal = map(carnivoreClones.get(i).age, 0, maxFitness, 0, 1);
      int n = (int) (fitnessNormal * 100);
      for (int j = 0; j < n; j++) {

        carnivoreMatingPool.add(carnivoreClones.get(i));
      }
    }
  }



  void reproduction() {
    for (int i = 0; i < numC; i++) {
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


  void reproductionCarnivore() {
    for (int i = 0; i < numPredators; i++) {
      int m = int(random(carnivoreMatingPool.size()));
      int d = int(random(carnivoreMatingPool.size()));

      Carnivore mother = carnivoreMatingPool.get(m);
      Carnivore father = carnivoreMatingPool.get(d);
      CarnivoreDNA motherGenes = mother.getDNA();
      CarnivoreDNA fatherGenes = father.getDNA();

      CarnivoreDNA child = motherGenes.crossover(fatherGenes);
      child.mutate(mutationRate);

      carnivores.add(new Carnivore(random(width), random(height), child));
    }
  }

 

  float getMaxFitness() {
    float record = 0;
    for (int i = 0; i < creatureClones.size(); i++) {
      if (creatureClones.get(i).age > record) {    
        record = creatureClones.get(i).age;
      }
    }
    return record;
  }

  float getMaxFitnessCarnivore() {
    float record = 0;
    for (int i = 0; i < carnivoreClones.size(); i++) {
      if (carnivoreClones.get(i).age > record) {   
        record = carnivoreClones.get(i).age;
      }
    }
    return record;
  }


  ArrayList getCreatures() {
    return creatures;
  }

  ArrayList getCarnivores() {
    return carnivores;
  }

  ArrayList getFood() {
    return food;
  }
}
