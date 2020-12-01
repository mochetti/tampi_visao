float ang = 0;
float distancia = 100;
void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  distancia = distancia + random(30) - 15;
  if(distancia > 200) distancia = 200;
  if(distancia < 0) distancia  = 0;
  stroke(255);
  strokeWeight(3);
  line(width/2, height/2, width/2 + distancia*cos(ang), height/2 + distancia*sin(ang));
  ang += 0.01;
}
