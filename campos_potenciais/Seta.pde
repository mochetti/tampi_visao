class Seta {
  float ang = 0;
  
  Seta(float a, boolean rad) {
    if(rad) ang = a;
    else ang = (a + 90) * PI / 180 ;
  }
  
  void mostra(float x, float y, float s) {
    stroke(255);
    strokeWeight(1);
    float xp = x + s*sin(ang);
    float yp = y + s*cos(ang);
    line(xp, yp, x - s*sin(ang), y - s*cos(ang));
    line(xp, yp, xp - s*sin(PI/6 + ang), yp - s*cos(PI/6 + ang));
    line(xp, yp, xp - s*sin(-PI/6 + ang), yp - s*cos(-PI/6 + ang));
  }
}
