import controlP5.*;
import java.util.*;
import static javax.swing.JOptionPane.*;

Table table;
PFont font, font2, logFont;

int foundResult = 0;
String name, resultName, searchingFor;
String adminUser = "Admin", adminPass = "uhd", userPass = "", checkUser = "", checkPass = "";
boolean adminMode = false, userMode = false;

void loginView()
{
  cp5.get(Textfield.class, "uBox").show();
  cp5.get(Textfield.class, "pBox").show();
  cp5.get(Button.class, "LOGIN").show();
}

String checkupInfo()
{ 
  if (checkUser.equals("Admin") == false)
  {
    Search(checkUser); // Search for ID in table
  }

  if (checkUser.equals("") == true || checkPass.equals("") == true) // Verify for empty textfields
  {
    showMessageDialog(null, "Please enter a username/password in the textfields!", "Alert", ERROR_MESSAGE);
  } 
  else if (checkUser.equals(adminUser) == true && checkPass.equals(adminPass) == true)  // Verify Admin's credentials
  {
    nextScreen(adminUser);
  } 
  else if (userPass.equals("900449"+checkPass) && foundResult == 0)
  {
    nextScreen(checkUser);
  } else showMessageDialog(null, "Wrong Username/Password please try again!", "Alert", ERROR_MESSAGE);

  return "error";
}

void Search(String srch) 
{ 
  name = srch;

  table = loadTable("StudentRecords.csv", "header");

  for (int i = 0; i < table.getRowCount(); i++)
  {
    TableRow row = table.getRow(i);

    resultName = (row.getString("Name"));

    if (name.equals(resultName) == true)
    {
      resultName = (row.getString("ID"));
      userPass = resultName;
      foundResult = 0;
      break;
    } else
    {
      foundResult = 1;
    }
  }
}

void nextScreen(String whoLogged)
{ 
  if (whoLogged.equals("error"))
  {
    println("An Error has occurred!");
  }
  else if (whoLogged.equals(adminUser) == true)
  {
    cp5.get(Textfield.class, "uBox").hide();
    cp5.get(Textfield.class, "pBox").hide();
    cp5.get(Button.class, "LOGIN").hide();

    displayScreen = loadImage("adminMenu.jpg");

    adminMode = true;
    
    cp5.get(ScrollableList.class, "Course").show();
    cp5.get(ScrollableList.class, "Course").setPosition(408, 353);
    cp5.get(ScrollableList.class, "Student").show();
    cp5.get(Button.class, "Add").show();
    cp5.get(Button.class, "Edit").show();
    cp5.get(Button.class, "Delete").show();
    cp5.get(Button.class, "LOGOUT").show();
    cp5.get(Button.class, "LOGOUT").setPosition(850, 513);
  } 
  else if (whoLogged.equals(checkUser) && !(whoLogged.equals(adminUser)))
  {
    cp5.get(Textfield.class, "uBox").hide();
    cp5.get(Textfield.class, "pBox").hide();
    cp5.get(Button.class, "LOGIN").hide();

    displayScreen = loadImage("userMenu.jpg");
    
    userMode = true;
    userInfo("900449"+checkPass);
    
    cp5.get(ScrollableList.class, "Course").show();
    cp5.get(ScrollableList.class, "Course").setPosition(488, 37);
    cp5.get(Button.class, "LOGOUT").show();
    cp5.get(Button.class, "LOGOUT").setPosition(773, 522.5);
  }
}
