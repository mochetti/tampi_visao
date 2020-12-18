// Campos potenciais
// Gera um campo de vetores baseado na coordenada do alvo e Obstáculo

PVector destino, obs, eu;
Robo robo;
int x, y, s = 30;
Seta[][] campoDestino, campoObs, campo;

void setup() {
  size(400, 400);
  destino = new PVector(width/4, height/2);
  obs = new PVector(3*width/4, height/2);
  eu = new PVector();
  x = width / s;
  y = height / s;
  
  // inicializa os campos
  campoDestino = new Seta[x][y];
  campoObs = new Seta[x][y];
  campo = new Seta[x][y];
  for(int i=0; i<x; i++) {
    for(int j=0; j<y; j++) {
      campoDestino[i][j] = new Seta(0, true);
      campoObs[i][j] = new Seta(0, true);
      campo[i][j] = new Seta(0, true);
    }
  }
}

void draw() {
  background(0);
  atualiza();
  trajeto();
  desenha();
  //float xp = 2*s+s/2;
  //float yp = 6*s+s/2;
  //println(distSq(xp, yp, destino.x, destino.y), campoDestino[2][6].amp, campoDestino[2][6].ang*180/PI);
  //println(distSq(xp, yp, obs.x, obs.y), campoObs[2][6].amp, campoObs[2][6].ang*180/PI);
  //println(campo[2][6].amp, campo[2][6].ang*180/PI);
  //ellipse(2*s+s/2, 6*s+s/2, 5, 5);
  //noLoop();
  //Seta s = new Seta(35*PI/180, true);
  //s.mostra(200, 200);
}

void atualiza() {
  // destino é a coordenadas do mouse
  eu.x = mouseX;
  eu.y = mouseY;
  
  // campo destino usando força magnética
  for(int i=0; i<x; i++) {
    for(int j=0; j<y; j++) {
      float xp = i*s+s/2;
      float yp = j*s+s/2;
      float ang = PI/2 - atan2(destino.y - yp, destino.x - xp);
      campoDestino[i][j].ang = ang;
      float d2 = distSq(xp, yp, destino.x, destino.y);
      campoDestino[i][j].amp = 1/d2;
    }
  }
  
  // campo Obs usando força magnética
  for(int i=0; i<x; i++) {
    for(int j=0; j<y; j++) {
      float xp = i*s+s/2;
      float yp = j*s+s/2;
      float ang = - PI/2 - atan2(obs.y - yp, obs.x - xp);
      campoObs[i][j].ang = ang;
      float d2 = distSq(xp, yp, obs.x, obs.y);
      campoObs[i][j].amp = 1/d2;
    }
  }
  
  // campo total
  for(int i=0; i<x; i++) {
    for(int j=0; j<y; j++) {
      // forma retangular
      float xs = campoObs[i][j].amp*cos(campoObs[i][j].ang) + campoDestino[i][j].amp*cos(campoDestino[i][j].ang);
      float ys = campoObs[i][j].amp*sin(campoObs[i][j].ang) + campoDestino[i][j].amp*sin(campoDestino[i][j].ang);
      campo[i][j].amp = sqrt(xs*xs + ys*ys);
      campo[i][j].ang = atan2(ys, xs);
    }
  }
}

void trajeto() {
  // origem
  int xa = int(eu.x) / s;
  int ya = int(eu.y) / s;
  int xb, yb;
  
  // destino aproximado
  int dx = int(destino.x) / s;
  int dy = int(destino.y) / s;
  
  while(xa != dx || ya != dy) {
    // encontra a seta mais próxima
    fill(255);
    ellipse(xa*s + s/2, ya*s + s/2, 5, 5);
    
    xb = int(xa*s + s/2 + s*cos(campo[xa][ya].ang - PI/2)) / s;
    if(xb >= x) xb = x-1;
    if(xb < 0) xb = 0;
    yb = int(ya*s + s/2 + s*sin(campo[xa][ya].ang + PI/2)) / s;
    if(yb >= y) yb = y-1;
    if(yb < 0) yb = 0;
    
    line(xa*s + s/2, ya*s + s/2, xb*s + s/2, yb*s + s/2);
    xa = xb;
    ya = yb;
    
    println(xa, ya);
  }
  
}

void desenha() {
  // eu
  fill(255);
  ellipse(eu.x, eu.y, 10, 10);
  
  // obs
  fill(0, 255, 0);
  ellipse(obs.x, obs.y, 10, 10);
  
  // alvo
  fill(255, 0, 0);
  ellipse(destino.x, destino.y, 10, 10);
  
  for(int i=0; i<x; i++) {
    for(int j=0; j<y; j++) {
      float xp = i*s+s/2;
      float yp = j*s+s/2;
      campo[i][j].mostra(xp, yp);
    }
  }
}

float distancia(float x1, float y1, float x2, float y2) {
  return sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
}

float distSq(float x1, float y1, float x2, float y2) {
  return (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2);
}
