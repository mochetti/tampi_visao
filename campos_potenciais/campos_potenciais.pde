// Campos potenciais
// Gera um campo de vetores baseado na coordenada do alvo e obstáculo

PVector alvo;
Robo robo;
int x, y, s = 20;

void setup() {
  size(400, 400);
  alvo = new PVector(width/2, height/2);
  x = width / s;
  y = height / s;
}

void draw() {
  background(0);
  atualiza();
  desenha();  
}

void atualiza() {
  alvo.x = mouseX;
  alvo.y = mouseY;
}

void desenha() {
  ellipse(alvo.x, alvo.y, 10, 10);
  
  for(int i=0; i<x; i++) {
    for(int j=0; j<y; j++) {
      float xp = i*s+s/2;
      float yp = j*s+s/2;
      float ang = PI/2 - atan2(alvo.y - yp, alvo.x - xp);
      Seta seta = new Seta(ang, true);
      seta.mostra(xp, yp, 10);
    }
  }
}
