/*
  This sketch will map the brightness of each pixel to a 3d triangle mesh in the 
  z-axis. The image texture is reapplied to each triangle after mesh is created.
  
  Keys:
  
  a - brings your image closer
  s - takes your image father away
  (spacebar) - saves the frame in the sketch's folder
*/

PImage img;
float[]depth;
//color[]colors;
PShader shader;
float zvalue = 700;

void setup(){
  fullScreen(P3D);
  //load your image here for texture
  img = loadImage("8-frozen-grass-seamless-textures.jpg");
  img.loadPixels();
  //initialize and load array
  depth = new float[img.width * img.height];
 //colors = new color[img.width * img.height];
  for(int i = 0; i < depth.length; i++){
    depth[i] = brightness((img.pixels[i]));
    //colors[i] = color(img.pixels[i]);
  }
  
}

void draw(){
  
  background(100);
  lights();
  
  translate(mouseX, mouseY, zvalue);
  for(int i = 0; i < img.width; i++){
    texture(img);
    //fill(255);
    //stroke(0);
    //strokeWeight(1);
    noStroke();
    beginShape(TRIANGLE_STRIP);
    texture(img);
   for(int j = 0; j < img.height - 1; j++){
     vertex(i,j, depth[i + j*img.width] / 10, i, j);
     vertex(i,j+1, depth[i + j*img.width] / 10, i, j+1);
   }
   endShape();
  }
  for(int j = 0; j < img.height - 1; j++){
    
    //stroke(0);
    //strokeWeight(1);
    noStroke();
    beginShape(TRIANGLE_STRIP);
    texture(img);
   for(int i = 0; i < img.width; i++){
     vertex(i,j, depth[i + j*img.width] / 10, i, j);
     vertex(i,j+1, depth[i + j*img.width] / 10, i, j+1);
   }
   endShape();
  }
}

void keyPressed(){
 if(key == 'a'){
   zvalue += 10.0;
 }
 if(key == 's'){
  zvalue -=10; 
 }
 if(key == ' '){
  saveFrame("DepthMap-#####.jpg"); 
 }
}