//Donat Salihu

class Population{
  
  ArrayList <Creature> creatures;
  DNA dna;
  DNA child;
  Creature c;
  
  
  
  Population(){
    creatures = new ArrayList<Creature>();
    dna = new DNA();
    c = new Creature();
    child = new DNA();
    
  }
  
  void reproduce(Creature partner){
    
    
    for(int i = 0 ; i < creatures.size(); i++){
       c = creatures.get(i);
      
        DNA cGenes = c.getDNA();
        DNA partnerGenes = partner.getDNA();
        //mate the genes
        child = cGenes.crossover(partnerGenes);
       //Creature kid = new Creature(c.getLocationX(), c.getLocationY(), child);
     
    }
    
      
  }
  
  Creature mate(Creature p){
    float d = PVector.dist(c.location, p.location);
     if((d > 0) && (d < c.DNArangeOfSight)){
        this.reproduce(p);     
     }
    return new Creature(c.getLocationX(), c.getLocationY(), child);
  }


}
