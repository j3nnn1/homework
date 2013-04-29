PImage[] images = new PImage[12];
int size = images.length;
void setup() {
images[0] = loadImage("./data/200401_buenosaires.png");
images[1] = loadImage("./data/200402_buenosaires.png");
images[2] = loadImage("./data/200403_buenosaires.png");
images[3] = loadImage("./data/200404_buenosaires.png");
images[4] = loadImage("./data/200405_buenosaires.png");
images[5] = loadImage("./data/200406_buenosaires.png");
images[6] = loadImage("./data/200407_buenosaires.png");
images[7] = loadImage("./data/200408_buenosaires.png");
images[8] = loadImage("./data/200409_buenosaires.png");
images[9] = loadImage("./data/200410_buenosaires.png");
images[10] = loadImage("./data/200411_buenosaires.png");
images[11] = loadImage("./data/200412_buenosaires.png");
size(800,600);
image(images[0], 0, 0);
}
void mouseMoved() {
  float mice = mouseX;
  float indexRange = map(mice, 0, width, 0, (size));
  int index = (int) indexRange;
  if (index < size){
     image(images[index], 0, 0);
  }
}
void draw() {
    
}
