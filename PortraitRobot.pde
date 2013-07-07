/**
 * Portrait robot 
 * 
 */ 
 
import processing.video.*;


// Size of each cell in the grid
int cellSize = 5;
// Number of columns and rows in our system
int cols, rows,value;
// Variable for capture device
Capture video;
int s = 50;
int trait = 2;
int espace = 2;

PVector portraitSize=new PVector(342, 480);

void setup() {
  size(1280, 800);
  frameRate(30);

  colorMode(RGB, 255, 255, 255, 100);

  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, 640,480);
  
  // Start capturing the images from the camera
  video.start();  
  
  background(0);
}


void draw() {
  cols = 640 / cellSize;
  rows = 480 / cellSize;
  
 background(0);
 int lines=0; 
  pushMatrix();
  translate(100,200);
  fill(255);
  rect(0,0,video.width,video.height);
  if (video.available()) {
    video.read();
    video.loadPixels();
  
    // Begin loop for columns
    for (int i = 0; i < cols; i++) {
      // Begin loop for rows
      for (int j = 0; j < rows; j=j+espace) {
       lines++;
        // Where are we, pixel-wise?
        int x = i*cellSize;
        int y = j*cellSize;
        int loc = (video.width - x - 1) + y*video.width; // Reversing x to mirror the image
      
        float r = red(video.pixels[loc]);
        float g = green(video.pixels[loc]);
        float b = blue(video.pixels[loc]);
        // Make a new color with an alpha component
      //  color c = color(r, g, b, 75);
        
        color c = color(video.pixels[loc]);
        int value = (int)brightness(c);
         noStroke();
        if (value<s)
        {
          fill(0);
        }
        else
        {
          fill(255);
        }
        
        
        
        
        // Code for drawing a single rect
        // Using translate in order for rotation to work properly
        pushMatrix();
        translate(x+cellSize/2, y+cellSize/2);
        // Rotation formula based on brightness
 //       rotate((2 * PI * brightness(c) / 255.0));
        //rectMode(CENTER);
    //    fill(c);
        noStroke();
        // Rects are larger than the cell for some overlap
        rect(0, 0, cellSize, cellSize);
        popMatrix();
      }
    }
  }
  
  //zone du portrait
  noFill();
  stroke(204, 102, 0);
  strokeWeight(3);
  rect(video.width/2-portraitSize.x/2,0,portraitSize.x,portraitSize.y);
  noStroke();
  
  //infos interface
  pushMatrix();
  fill(200);
  translate(video.width+ 50, 10);
  textSize(12);
  text("Seuil : "+ s , 0, 0);
  text("reglage du seuil (a-, z+)", 0, 20);
  
  text("Trait : "+ cellSize , 0, 40);
  text("reglage du trait (q-, s+)", 0, 60);
  
  text("Interligne : "+ espace , 0, 80);
  text("reglage du trait (w-, x+)", 0, 100);
  text("nbre de lignes : "+ lines, 0, 120);
  
  
  popMatrix();
  
  popMatrix();
  
}


void keyPressed() 
{
//reglage du seuil (a-, z+)  
 if( key == 'a') 
 {
   s = s - 1;
   println("s " + s);
 }
 if ( key == 'z')
 {
   s = s + 1;
   println("s " + s);
 }
 //reglage du trait (q-, s+)  
 if( key == 'q') 
 {
   cellSize++;
   println("t " + s);
 }
 if ( key == 's')
 {
   cellSize--;
   println("t " + s);
 }
 
  //reglage de l'interligne (w-, x+)  
 if( key == 'w') 
 {
   espace++;
   println("espace " + s);
 }
 if ( key == 'x')
 {
   espace--;
   println("espace " + s);
 }
}
