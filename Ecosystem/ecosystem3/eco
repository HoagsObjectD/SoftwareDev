//Donat Salihu

ArrayList<Creature> creatures = new ArrayList<Creature>();
ArrayList<PVector> food = new ArrayList<PVector>();



final color blue = color(25, 25, 112);
final color pink = color(255, 182, 193);
int num = 10;

void setup() {
  //frameRate(4);
  size(900,720);
 
  for(int i = 0; i < num; i++){
    creatures.add(new Creature(random(width), random(height)));
  }
  
  background(blue);
  for(int i = 0; i < 44 ; i++){
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
