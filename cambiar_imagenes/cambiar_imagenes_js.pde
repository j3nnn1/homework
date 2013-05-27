/* @pjs preload="200401_buenosaires.png, 200402_buenosaires.png, 200403_buenosaires.png, 200404_buenosaires.png, 200405_buenosaires.png, 200406_buenosaires.png, 200407_buenosaires.png, 200408_buenosaires.png, 200409_buenosaires.png, 200410_buenosaires.png, 200411_buenosaires.png, 200412_buenosaires.png"; */
PImage[] images = new PImage[11];
int sizeimage = images.length;
void setup() {
size(600,600);
images[0] = loadImage("200401_buenosaires.png");
images[1] = loadImage("200402_buenosaires.png");
images[2] = loadImage("200403_buenosaires.png");
images[3] = loadImage("200404_buenosaires.png");
images[4] = loadImage("200405_buenosaires.png");
images[5] = loadImage("200406_buenosaires.png");
images[6] = loadImage("200407_buenosaires.png");
images[7] = loadImage("200408_buenosaires.png");
images[8] = loadImage("200409_buenosaires.png");
images[9] = loadImage("200410_buenosaires.png");
images[10] = loadImage("200411_buenosaires.png");
images[11] = loadImage("200412_buenosaires.png");
image(images[0], 0, 0);
}
void mouseMoved() {
  float mice = mouseX;
  float indexRange = map(mice, 0, width, 0, (sizeimage + 1));
  int index = (int) indexRange;
  if (index < (sizeimage+1)){
     image(images[index], 0, 0);
  }
  text(getMonth(index),mouseX,mouseY);
}
void draw() {
}

String getMonth(int index) {
 String mes;
 switch(index){
 case 0: mes = "Enero"; break;
 case 1: mes = "Febrero"; break;
 case 2: mes = "Marzo"; break;
 case 3: mes = "Abril"; break;
 case 4: mes = "Mayo"; break;
 case 5: mes = "Junio"; break;
 case 6: mes = "Julio"; break;
 case 7: mes = "Agosto"; break;
 case 8: mes = "Septiembre"; break;
 case 9: mes = "Octubre"; break;
 case 10: mes = "Noviembre"; break;
 case 11: mes = "Diciembre"; break;
 default: mes = "No Mes"; break;
 }
 return mes; 
}





