ArrayList<Creature> creatures = new ArrayList<Creature>();
ArrayList<PVector> food = new ArrayList<PVector>();
DNA dna;


final color blue = color(25, 25, 112);
final color pink = color(255, 182, 193);
int num = 6;
 

void setup() {
  //frameRate(4);
  size(900,720);
  background(blue);
  
  
  for(int i = 0; i < num; i++){
    float x = random(width);
    float y = random(height);
    dna = new DNA();
    creatures.add(new Creature(x,y,dna));
    //creatures.add(new Creature(random(width), random(height)));
  }
  
   
  
  
  for(int i = 0; i < 25 ; i++){
    food.add(new PVector(random(width), random(height)));  
    
     
  }
}
 
void draw() {

    background(blue);
    
    for(int i = 0; i < creatures.size(); i++){
    creatures.get(i).sight(food);
    creatures.get(i).update();
    creatures.get(i).borders();
    creatures.get(i).display();
    creatures.get(i).mateC(creatures);
   // new Creature(x,y,dna);
    
    if(creatures.get(i).dead()){
      creatures.remove(i);
    }
    
   }
    for(int i = 0 ; i < food.size()-1; i++){
       fill(#49CB17);
       noStroke();
       rect(food.get(i).x, food.get(i).y, 10,10);
       
    }
}
