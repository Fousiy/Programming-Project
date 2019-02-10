import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

class Student {
  private String id;
  private String studentName;
  HashMap<String, Float> currentCourses;
  private float currentGPA;

  public String getId() {
    return this.id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getStudentName() {
    return this.studentName;
  }

  public void setStudentName(String name) {
    this.studentName = name;
  }

  public HashMap<String, Float> getCurrentCourses() {
    return this.currentCourses;
  }

  public void setCurrentCourses(HashMap<String, Float> currentCourses) {
    this.currentCourses = currentCourses;
  }

  public double getCurrentGPA() {
    return this.currentGPA;
  }

  public void setCurrentGPA(float gpa) {
    this.currentGPA = gpa;
  }
}

class StudentManager {
  private String recordPath =  dataPath("") +  "\\StudentRecords.csv";

  public HashMap<String, Float> parseCurrentCourses(String data) {
    HashMap<String, Float> currentCourses = new HashMap<String, Float>();
    String[] courses = data.split("-");
    for (String course : courses) {
      String[] values = course.split(":");
      currentCourses.put(values[0], float(values[1]));
    }
    return currentCourses;
  }

  public Student getStudent(String id) {
    Student student = new Student();
    File file = new File(this.recordPath);
    
    try {
      final Scanner scanner = new Scanner(file);
      while (scanner.hasNextLine()) {
        final String lineFromFile = scanner.nextLine();
        //print(lineFromFile);
        if (lineFromFile.contains(id)) {
          String[] data = lineFromFile.split(",");
          student.setId(data[0]);
          student.setStudentName(data[1]);
          student.setCurrentCourses(parseCurrentCourses(data[2]));
          student.setCurrentGPA(float(data[3]));
          scanner.close();
          break;
        }
      }
    } 
    catch (FileNotFoundException e) {
      e.printStackTrace();
    }
    return student;
  }
}

void setup() {
  size(400, 400);
  stroke(255);
  background(192, 64, 0);
} 

void draw() {
  //line(150, 25, mouseX, mouseY);
  StudentManager sm = new StudentManager();
  Student s1 = sm.getStudent("9004499112");
}
