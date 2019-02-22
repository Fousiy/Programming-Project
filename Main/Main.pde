PImage displayScreen;

ControlP5 cp5;

void setup() 
{
  size(1200, 800);
  
  cp5 = new ControlP5(this);
  
  displayScreen = loadImage("BackGround.jpg");
  
  Gui(); // initiate button/textfield objects
  loginView();
} 

void draw() 
{
  image(displayScreen,0,0);
  //displayInfo();
}
