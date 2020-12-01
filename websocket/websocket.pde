import websockets.*;

WebsocketClient wsc;
int now;
boolean newEllipse;

void setup(){
  size(200,200);
  
  newEllipse=true;
  
  wsc= new WebsocketClient(this, "ws://192.168.4.1:81");
  now=millis();
}

void draw(){
  if(newEllipse){
    ellipse(random(width),random(height),10,10);
    newEllipse=false;
  }
    
  if(millis()>now+100){
    wsc.sendMessage("x:" + mouseX + "  y:" + mouseY);
    now=millis();
  }
}

void webSocketEvent(String msg){
 println(msg);
 newEllipse=true;
}
