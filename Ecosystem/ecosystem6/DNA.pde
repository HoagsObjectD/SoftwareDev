class DNA{
  
 // ArrayList<PVector> genes;
  float maxSpeed;
  float rangeOfSight;
  float[] genes;
  //int len = 20; //arbitrary length
  
  DNA(){
    //genes = new ArrayList<PVector>();
    //    for(int i = 0 ; i < num; i++){
    //    genes.add(new PVector(random(width), random(height)))
    //     }
    genes = new float[2];
    genes[0] = random(1,4); //dna for max speed
    genes[1] = random(70,130); //dna for rangeOfSight
    
      
    
  
  }
  
 DNA(float[] newgenes) {
    
    genes = newgenes;
  }

  
  DNA crossover(DNA partner) {
    float[] child = new float[genes.length];
    int crossover = int(random(genes.length));
    for (int i = 0; i < genes.length; i++) {
      if (i > crossover) child[i] = genes[i];
      else               child[i] = partner.genes[i];
    }
    DNA newgenes = new DNA(child);
    return newgenes;
  }
  
 
  
  
   void mutate(float m) {
    m = mutationRate;
      if (random(1) < m) {
         genes[0] = int(random(1,4));
      }
      if(random(1) < m){
        genes[1] = int(random(70,130));
      }
  }
  
  
  
  //DNA copy() {
  //  float[] newgenes = new float[genes.length];
  //  //arraycopy(genes,newgenes);
  //  // JS mode not supporting arraycopy
  //  for (int i = 0; i < newgenes.length; i++) {
  //    newgenes[i] = genes[i];
  //    }
  //}
  
  
  
}
