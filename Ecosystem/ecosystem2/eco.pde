Creature[] c;
ArrayList<PVector> food = new ArrayList<PVector>();



final color blue = color(25, 25, 112);
final color pink = color(255, 182, 193);
int num = 2;

void setup() {
  //frameRate(4);
  size(720,320);
  c = new Creature[num];
  for(int i = 0; i < num; i++){
    c[i] = new Creature(random(width), random(height));
  }
  
  background(blue);
  for(int i = 0; i < 100 ; i++){
    food.add(new PVector(random(width), random(height)));  
    
     
  }
}
 
void draw() {

    background(blue);
    
    for(int i = 0; i < c.length; i++){
    c[i].eat(food);
    c[i].update();
    c[i].passEdges();
    c[i].display();
   }
    for(int i = 0 ; i < food.size()-1; i++){
       fill(#49CB17);
       noStroke();
       rect(food.get(i).x, food.get(i).y, 10,10);
       
     
       
       
      
    }
}
