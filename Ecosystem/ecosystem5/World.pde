//Donat Salihu

class World{

  ArrayList<Creature> creatures; 
  ArrayList<PVector> food;
  Population p;
  DNA dna;  
      

  World(int num){
    
    p = new Population();
    creatures = new ArrayList<Creature>();
    //dna = new DNA();
   for(int i = 0; i < num; i++){
      float x = random(width);
      float y = random(height);
      dna = new DNA();
      creatures.add(new Creature(x,y,dna));
    //creatures.add(new Creature(random(width), random(height)));
  }
    food = new ArrayList<PVector>();
    //populate the array with food
      for(int i = 0; i < 40 ; i++){
      food.add(new PVector(random(width), random(height))); 
  }
}
  

  void run(){
  
    //deal with creatures
      for(int i = creatures.size()-1; i > 0; i--){
      Creature c = creatures.get(i);
      
      c.sight(food);
      c.update();
      c.borders();
      c.display();
    
    if(creatures.get(i).dead()){
      creatures.remove(i);
      }
      
      if(c.getEnergy() >= 130){
        Creature child = p.mate(c);
        creatures.add(child);
      }
   }
    
    //display food
    for(int i = 0 ; i < food.size()-1; i++){
       fill(#49CB17);
       noStroke();
       rect(food.get(i).x, food.get(i).y, 10,10);

      }
  }
}
