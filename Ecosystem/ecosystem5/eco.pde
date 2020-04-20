//Donat Salihu

World world;
  final color blue = color(25, 25, 112);
  final color pink = color(255, 182, 193);

 

void setup() {
   //frameRate(4);
   size(720,220);
   background(blue);
   world = new World(10);
   smooth();
  
 }
  
void draw() {

    background(blue);
    world.run();
    
   
   
}
