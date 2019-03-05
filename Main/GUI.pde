import controlP5.*;

String aID = "", aName = ""; float aGPA = 0; HashMap<String, Integer> aCG;
boolean viewAdminInfo = false, viewUserInfo;
boolean isOpen = false;

void Gui()
{   //<>//
  StudentManager sm = StudentManager.getInstance(this);
  
  font = createFont("arial",40);
  logFont = createFont("arial",25);
  isOpen = false;
  
  cp5.addTextfield("uBox") // Username field
     .setPosition(358,245)
     .setSize(502,63)
     .setFont(font)
     .setFocus(true)
     .hide()
     .setColor(color(0)) // Color of Font
     .setColorBackground(#CECACA) // Color of textfield
     .setCaptionLabel("")
     ;
     
  cp5.addTextfield("pBox") // Password field
     .setPosition(358,360)
     .setSize(502,63)
     .setFont(font)
     .hide()
     .setFocus(false)
     .setColor(color(0)) // Color of Font
     .setColorBackground(#CECACA) // Color of textfield
     .setCaptionLabel("")
     .setPasswordMode(true)
     ;
     
  cp5.addTextfield("Enter Student Name") // Password field
     .setPosition(1012,200)
     .setSize(170,40)
     .setFont(font)
     .hide()
     .setFocus(true)
     .setColor(color(0)) // Color of Font
     .setColorBackground(#CECACA) // Color of textfield
     .setCaptionLabel("")
     ;
     
  cp5.addButton("Add")
         .setPosition(1025,110)
         .setSize(144,45)
         .setFont(font) 
         .hide()
         .setColorBackground(#73e2f9) // Color of textfield
         .addCallback(new CallbackListener() {
         public void controlEvent(CallbackEvent event) {
         if (event.getAction() == ControlP5.RELEASED) {

           if(isOpen == false)
           {
             cp5.get(Textfield.class, "Enter Student Name").show();
             isOpen = true;
           }
           else 
           {
             cp5.get(Textfield.class, "Enter Student Name").hide(); 
             isOpen = false;
           }
        }
      }
    }
   );
     
  cp5.addButton("LOGIN")
         .setPosition(454,466)
         .setSize(309,63)
         .setFont(font) 
         .hide()
         .setColorBackground(#73e2f9) // Color of textfield
         .addCallback(new CallbackListener() {
         public void controlEvent(CallbackEvent event) {
         if (event.getAction() == ControlP5.RELEASED) {
           
           cp5.get(Textfield.class, "uBox").submit();
           cp5.get(Textfield.class, "pBox").submit();
           
           checkupInfo();
        }
      }
    }
   );
   
  cp5.addButton("LOGOUT")
         .setSize(144,45)
         .setFont(logFont) 
         .hide()
         .setColorBackground(#73e2f9) // Color of textfield
         .addCallback(new CallbackListener() {
         public void controlEvent(CallbackEvent event) {
         if (event.getAction() == ControlP5.RELEASED) {
            
            cp5.get(Button.class, "LOGOUT").hide();
            cp5.get(ScrollableList.class, "Student").hide();
            cp5.get(Button.class, "Add").hide();
            cp5.get(Textfield.class, "Enter Student Name").hide();

            displayScreen = loadImage("BackGround.jpg");

            adminMode = false;
            userMode = false;
            viewAdminInfo = false;
            
            cp5.get(Textfield.class, "uBox").show();
            cp5.get(Textfield.class, "pBox").show();
            cp5.get(Button.class, "LOGIN").show();
        }
      }
    }
   );
  
  // Store student names here
  cp5.addScrollableList("Student")
     .setPosition(225, 73)
     .setSize(500, 240)
     .setFont(logFont) 
     .hide()
     .close()
     .setBarHeight(40)
     .setItemHeight(50)
     .addItems(sm.getAllStudents().getStringColumn(1))
     ; 
}

public void uBox(String userInfo) 
{
  checkUser = userInfo;
}

public void pBox(String passInfo) 
{
  checkPass = passInfo;
}

void Student(int studentN) 
{
  StudentManager sm = StudentManager.getInstance(this);

  Student s = sm.getStudentByIndex(studentN); 
  
  aID = s.getId();
  aName = s.getStudentName();
  // Need to convert Hashmap into string for text() to work in Main function.
  aGPA = s.getCurrentGPA(); 
  
  viewAdminInfo = true;
}

void userInfo(String ID)
{
  StudentManager sm = StudentManager.getInstance(this);
  
  Student s = sm.getStudent(ID); 
  
  aID = s.getId();
  aName = s.getStudentName();
  // Need to convert Hashmap into string for text() to work in Main function.
  aGPA = s.getCurrentGPA(); 
  
  viewUserInfo = true;
}


/*
//Add new s2 student based on s1 detail
  Student s2 = s1;
  sm.addStudent(s2);

   //Change name for s1
  s1.setStudentName("John");
  sm.editStudent(s2);
*/
