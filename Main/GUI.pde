import controlP5.*; //<>// //<>//

String aID = "", aName = ""; 
float aGPA = 0, aC_G; 
boolean viewAdminInfo = false, viewUserInfo;
boolean isOpen = false;

List<String> courseNames = new ArrayList();
List<String> courseGrades = new ArrayList();
String[] courseNameArray;

void Gui()
{  
  StudentManager sm = StudentManager.getInstance(this);

  font = createFont("arial", 40);
  font2 = createFont("arial", 15);
  logFont = createFont("arial", 25);
  isOpen = false;

  cp5.addTextfield("uBox") // Username field
    .setPosition(358, 245)
    .setSize(502, 63)
    .setFont(font)
    .setFocus(true)
    .hide()
    .setColor(color(0)) // Color of Font
    .setColorBackground(#CECACA) // Color of textfield
    .setCaptionLabel("")
    ;

  cp5.addTextfield("pBox") // Password field
    .setPosition(358, 360)
    .setSize(502, 63)
    .setFont(font)
    .hide()
    .setFocus(false)
    .setColor(color(0)) // Color of Font
    .setColorBackground(#CECACA) // Color of textfield
    .setCaptionLabel("")
    .setPasswordMode(true)
    ;

  cp5.addTextfield("EnterStudent") // new Student textfield from add button
    .setPosition(1012, 200)
    .setSize(170, 40)
    .setFont(font2)
    .hide()
    .setFocus(true)
    .setColor(color(0)) // Color of Font
    .setColorBackground(#CECACA) // Color of textfield
    ;

  cp5.addButton("Add")
    .setPosition(1025, 110)
    .setSize(144, 45)
    .setFont(font) 
    .hide()
    .setColorBackground(#73e2f9) // Color of textfield
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASED) {

        if (isOpen == false)
        {
          cp5.get(Textfield.class, "EnterStudent").show();
          isOpen = true;
        } else 
        {
          cp5.get(Textfield.class, "EnterStudent").hide(); 
          isOpen = false;
        }
      }
    }
  }
  );

  cp5.addButton("LOGIN")
    .setPosition(454, 466)
    .setSize(309, 63)
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
    .setSize(144, 45)
    .setFont(logFont) 
    .hide()
    .setColorBackground(#73e2f9) // Color of textfield
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASED) {

        cp5.get(Button.class, "LOGOUT").hide();
        cp5.get(ScrollableList.class, "Student").hide();
        cp5.get(Button.class, "Add").hide();
        cp5.get(Textfield.class, "EnterStudent").hide();
        cp5.get(ScrollableList.class, "Course").hide();
        
        displayScreen = loadImage("BackGround.jpg");

        adminMode = false;
        userMode = false;
        viewAdminInfo = false;
        
        cp5.get(ScrollableList.class, "Course").clear();
        aC_G = 0;
        
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
    
  // Store student courses here
  cp5.addScrollableList("Course")
    .setSize(500, 240)
    .setFont(logFont) 
    .hide()
    .close()
    .setBarHeight(40)
    .setItemHeight(50)
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

public void EnterStudent(String studInfo)
{ 
  String[] newName = { studInfo };
  
  StudentManager sm = StudentManager.getInstance(this);
  
  Student oldStud = sm.getStudent("900449912"); 
  Student newStud = oldStud;
 
  newStud.setStudentName(studInfo);
  //newStud.setCurrentGPA(3.2); method removed  since new auto calculating gpa under coureseGrades hashmap
  
  sm.addStudent(newStud);
  
  cp5.get(ScrollableList.class, "Student").addItems(newName);
}

void Student(int studentN) 
{
  cp5.get(ScrollableList.class, "Course").clear();
  
  StudentManager sm = StudentManager.getInstance(this);

  Student s = sm.getStudentByIndex(studentN); 

  aID = s.getId();
  aName = s.getStudentName();
  aGPA = s.getCurrentGPA(); 
  
   // Note the HashMap's "key" is a String and "value" is an Integer
  HashMap<String, Integer> hm = s.getCurrentCourses();

  // Using an enhanced loop to iterate over each entry
  for (Map.Entry me : hm.entrySet()) {
    courseNames.add(me.getKey().toString());
    courseGrades.add(me.getValue().toString());
  }
  
  courseNameArray = new String[hm.size()];
  
  for (int i = 0; i < hm.size(); i++) 
  {
    courseNameArray[i] = courseNames.get(i);
  }
  cp5.get(ScrollableList.class, "Course").addItems(courseNameArray);
  
  viewAdminInfo = true;
}

void Course(int courseN) 
{ 
  aC_G = float(courseGrades.get(courseN));
}

void userInfo(String ID)
{
  String passRef = ID;
  
  StudentManager sm = StudentManager.getInstance(this);

  Student s = sm.getStudent(ID); 

  aID = s.getId();
  aName = s.getStudentName();
  
  aGPA = s.getCurrentGPA(); 

  viewUserInfo = true;
  
  userCourse(passRef);
}

void userCourse(String ID)
{    
  StudentManager sm = StudentManager.getInstance(this);
  
  Student s = sm.getStudent(ID); 

  // Note the HashMap's "key" is a String and "value" is an Integer
  HashMap<String, Integer> hm = s.getCurrentCourses();

  // Using an enhanced loop to iterate over each entry
  for (Map.Entry me : hm.entrySet()) {
    courseNames.add(me.getKey().toString());
    courseGrades.add(me.getValue().toString());
  }
  
  courseNameArray = new String[hm.size()];
  
  for (int i = 0; i < hm.size(); i++) 
  {
    courseNameArray[i] = courseNames.get(i);
  }
   cp5.get(ScrollableList.class, "Course").addItems(courseNameArray);
}

/*
//Add new s2 student based on s1 detail
 Student s2 = s1;
 sm.addStudent(s2);
 
 //Change name for s1
 s1.setStudentName("John");
 sm.editStudent(s2);
 */
