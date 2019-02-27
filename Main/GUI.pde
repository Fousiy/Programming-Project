import controlP5.*;

void Gui()
{
  StudentManager sm = StudentManager.getInstance(this); //<>//
  
  font = createFont("arial",40);
  logFont = createFont("arial",25);
  
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
            
            displayScreen = loadImage("BackGround.jpg");
            
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
     .removeItem("Name"); // Remove Dummy Variable
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
  /* request the selected item based on index n */
  println(studentN);
}
