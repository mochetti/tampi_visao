// Campos potenciais
// Gera um campo de vetores baseado na coordenada do alvo e obstáculo

PVector alvo;
Robo robo;

void setup() {
size(400, 400);
alvo = new PVector(width/2, height/2);
//robo = new Robo();
}

void draw() {
  background(0);
  //atualiza();
  //desenha();
  
  // gera um campo ao redor do alvo
  
}

void atualiza() {
}

void desenha() {
  fill(255, 0, 0);
  ellipse(alvo.x, alvo.y, 10, 10);
  
  robo.ang += 0.01;
  robo.show();
}
