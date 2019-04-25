import java.text.DecimalFormat;

PImage displayScreen;

ControlP5 cp5;

void setup() 
{
  size(1000, 600);
  
  cp5 = new ControlP5(this);

  displayScreen = loadImage("BackGround.jpg");

  Gui(); // initiate button/textfield objects

  loginView();
} 

void draw() 
{
  image(displayScreen, 0, 0);
  if (adminMode == true && viewAdminInfo == true)
  {  // Display Student info in Admin View
    text(aID, 105, 148);
    text(aName, 140, 263);
    text(int(aC_G), 230, 380);
    DecimalFormat df = new DecimalFormat("#.#"); // Format for one decimal place
    text(df.format(aGPA), 130, 493);
  }
  else if (userMode == true && viewUserInfo)
  { // Display Student info in User View
    text(aID, 200, 143);
    text(aName, 235, 258);
    text(int(aC_G), 327, 371);
    DecimalFormat df = new DecimalFormat("#.#"); // Format for one decimal place
    text(df.format(aGPA), 228, 487);
  }
}

void keyPressed()
{
  switch(key)
  {
  case TAB:
    Textfield userBox = (Textfield) cp5.getController("uBox");
    Textfield passBox = (Textfield) cp5.getController("pBox");

    if (userBox.isFocus() == true)
    {
      userBox.setFocus(false);
      passBox.setFocus(true);
    } else if (passBox.isFocus() == true)
    {
      userBox.setFocus(true);
      passBox.setFocus(false);
    }
    break;
  }
}
