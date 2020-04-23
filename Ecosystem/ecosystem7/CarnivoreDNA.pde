class CarnivoreDNA {


  float[] genes;


  CarnivoreDNA() {

    genes = new float[2];
    genes[0] = random(3, 4.5); //dna for max speed
    genes[1] = random(90, 150); //dna for rangeOfSight
  }

  CarnivoreDNA(float[] newgenes) {

    genes = newgenes;
  }


  CarnivoreDNA crossover(CarnivoreDNA partner) {
    float[] child = new float[genes.length];
    int crossover = int(random(genes.length));
    for (int i = 0; i < genes.length; i++) {
      if (i > crossover) child[i] = genes[i];
      else               child[i] = partner.genes[i];
    }
    CarnivoreDNA newgenes = new CarnivoreDNA(child);
    return newgenes;
  }




  void mutate(float m) {
    m = mutationRate;
    if (random(1) < m) {
      genes[0] = int(random(2, 6));
    }
    if (random(1) < m) {
      genes[1] = int(random(90, 150));
    }
  }
}
