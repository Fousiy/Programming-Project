import java.io.File; //<>// //<>// //<>//
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Scanner;
import java.util.Map;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

class Student {
  private String id;
  private String studentName;
  HashMap<String, Integer> currentCourses;
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

  public HashMap<String, Integer> getCurrentCourses() {
    return this.currentCourses;
  }

  public void setCurrentCourses(HashMap<String, Integer> currentCourses) {
    this.currentCourses = currentCourses;
  }

  public float getCurrentGPA() {
    return this.currentGPA;
  }

  public void setCurrentGPA(float gpa) {
    this.currentGPA = gpa;
  }
}

class StudentManager {
  private String recordPath =  dataPath("") +  "\\StudentRecords.csv";

  private HashMap<String, Integer> parseCurrentCourses(String data) {
    HashMap<String, Integer> currentCourses = new HashMap<String, Integer>();
    String[] courses = data.split("-");
    for (String course : courses) {
      String[] values = course.split(":");
      currentCourses.put(values[0], int(values[1]));
    }
    return currentCourses;
  }

  private String buildCurrentCoursesString(HashMap<String, Integer> data) {
    String result ="";
    for (Map.Entry me : data.entrySet()) {
      result += me.getKey() + ":" + me.getValue() + "-";
    }
    return result.substring(0, result.length()-1);
  }

  private String generateStudentId() {
    Table table = loadTable(this.recordPath);
    String[] ids = table.getStringColumn(0);
    int id = int(ids[ids.length-1])+1;
    return Integer.toString(id);
  }

  private String findExistingStudentRecord(String id) {
    String result = "";
    try {
      FileReader fr = new FileReader(this.recordPath);
      BufferedReader br = new BufferedReader(fr);
      String lineFromFile;
      while ((lineFromFile = br.readLine()) != null) {
        if (lineFromFile.contains(id)) {
          result = lineFromFile;
          break;
        }
      }
      br.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
    return result;
  }

  public void addStudent(Student s) {
    String studentRecord = generateStudentId() + "," + s.getStudentName() + "," + buildCurrentCoursesString(s.getCurrentCourses()) + "," + nf(s.getCurrentGPA(), 0, 1) + "\n";
    try {
      FileWriter fw = new FileWriter(this.recordPath, true);
      fw.write(studentRecord);
      fw.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public void editStudent(Student s) {
    String oldRecord = findExistingStudentRecord(s.getId());
    String newRecord = s.getId() + "," + s.getStudentName() + "," + buildCurrentCoursesString(s.getCurrentCourses()) + "," + nf(s.getCurrentGPA(), 0, 1);

    Path path = Paths.get(this.recordPath);
    Charset charset = StandardCharsets.UTF_8;

    try {
      String content = new String(Files.readAllBytes(path), charset);
      content = content.replace(oldRecord, newRecord);
      Files.write(path, content.getBytes(charset));
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public Student getStudent(String id) {
    Student student = new Student();
    String[] data = findExistingStudentRecord(id).split(",");
    student.setId(data[0]);
    student.setStudentName(data[1]);
    student.setCurrentCourses(parseCurrentCourses(data[2]));
    student.setCurrentGPA(float(data[3]));
    return student;
  }
}

void setup() {
  size(400, 400);
  stroke(255);
  background(192, 64, 0);
  StudentManager sm = new StudentManager();
  //Retrive student1 detail
  Student s1 = sm.getStudent("900449912");
  
  //Add new s2 student based on s1 detail
  Student s2 = s1;
  sm.addStudent(s2);
  
  //Change name for s1
  s1.setStudentName("John");
  sm.editStudent(s2);

  HashMap<String, Integer> currentCourses = s1.getCurrentCourses();
  for (Map.Entry me : currentCourses.entrySet()) {
    print(me.getKey() + " is ");
    println(me.getValue());
  }
} 
