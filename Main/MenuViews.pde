import controlP5.*;
import java.util.*;
import static javax.swing.JOptionPane.*;

PImage nextMenu;
PFont font, logFont;

String adminUser = "Admin", adminPass = "uhd", checkUser, checkPass;

void loginView()
{
  cp5.get(Textfield.class, "uBox").show();
  cp5.get(Textfield.class, "pBox").show();
  cp5.get(Button.class, "LOGIN").show();
}

String checkupInfo()
{
  if(checkUser.equals("") == true || checkPass.equals("") == true) // Verify for empty textfields
  {
    showMessageDialog(null, "Please enter a username/password in the textfields!", "Alert", ERROR_MESSAGE);
  }
  else if(checkUser.equals(adminUser) == true && checkPass.equals(adminPass) == true)  // Verify Admin's credentials
  {
    return adminUser;
  }
  else showMessageDialog(null, "Wrong Username/Password please try again!", "Alert", ERROR_MESSAGE);
  return "error";
}

void nextScreen(String whoLogged)
{ 
  if(whoLogged.equals("error"))
  {
    println("An Error has occurred!");
  }
  else if(whoLogged.equals(adminUser) == true)
  {
    cp5.get(Textfield.class, "uBox").hide();
    cp5.get(Textfield.class, "pBox").hide();
    cp5.get(Button.class, "LOGIN").hide();
    
    displayScreen = loadImage("adminMenu.jpg");
    
    cp5.get(ScrollableList.class, "Student").show();
    cp5.get(Button.class, "LOGOUT").show();
  }
}



;
