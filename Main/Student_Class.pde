import java.io.File; //<>// //<>// //<>// //<>//
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Map;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

static class Student {
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
    float sum =0;
    for (Integer value : currentCourses.values()) {
      if (value >= 90) {
        sum += 4;
      } else if (value < 90 && value >= 80) {
        sum += 3;
      } else if (value < 80 && value >= 70) {
        sum += 2;
      } else if (value < 70 && value >= 60) {
        sum += 1;
      } else {
        sum += 0;
      }
    } //<>//
    this.currentGPA = sum/currentCourses.size();
  }

  public float getCurrentGPA() {
    return this.currentGPA;
  }
}

static class StudentManager {
  private static StudentManager singleton = null;
  private static PApplet p;
  private static String recordPath;
  private static Table Students;

  private StudentManager() {
    recordPath = p.dataPath("") +  "\\StudentRecords.csv";
    Students = p.loadTable(recordPath, "header");
  }

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
    String[] ids = Students.getStringColumn(0);
    int id = int(ids[ids.length-1])+1;
    return Integer.toString(id);
  }

  private String findExistingStudentRecord(String id) {
    String result = "";
    try {
      FileReader fr = new FileReader(recordPath);
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

  public static StudentManager getInstance(PApplet papp) 
  { 
    if (singleton == null) {
      p = papp;
      singleton = new StudentManager();
    }
    return singleton;
  }

  public void addStudent(Student s) {
    String newId = generateStudentId();
    String studentRecord = newId + "," + s.getStudentName() + "," + buildCurrentCoursesString(s.getCurrentCourses()) + "," + nf(s.getCurrentGPA(), 0, 1) + "\n";
    try {
      FileWriter fw = new FileWriter(recordPath, true);
      fw.write(studentRecord);
      fw.close();
      Students.clearRows();
      Students = p.loadTable(recordPath, "header");
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public void editStudent(Student s) {
    String oldRecord = findExistingStudentRecord(s.getId());
    String newRecord = s.getId() + "," + s.getStudentName() + "," + buildCurrentCoursesString(s.getCurrentCourses()) + "," + nf(s.getCurrentGPA(), 0, 1);

    Path path = Paths.get(recordPath);
    Charset charset = StandardCharsets.UTF_8;

    try {
      String content = new String(Files.readAllBytes(path), charset);
      content = content.replace(oldRecord, newRecord);
      Files.write(path, content.getBytes(charset));
      Students.clearRows();
      Students = p.loadTable(recordPath, "header");
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }
  
  public void deleteStudent(String id) {
    String stringRecord = System.lineSeparator()+findExistingStudentRecord(id);
    Path path = Paths.get(recordPath);
    Charset charset = StandardCharsets.UTF_8;
    try {
      String content = new String(Files.readAllBytes(path), charset);
      content = content.replace(stringRecord,"");
      Files.write(path, content.getBytes(charset));
      Students.clearRows();
      Students = p.loadTable(recordPath, "header");
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public Student getStudent(String id) {
    Student student = new Student();
    for (TableRow row : Students.rows()) {
      if (row.getString(0).equals(id)) {
        student.setId(id);
        student.setStudentName(row.getString(1));
        student.setCurrentCourses(parseCurrentCourses(row.getString(2)));
        student.setCurrentGPA(row.getFloat(3));
        break;
      }
    }
    return student;
  }

  public Student getStudentByIndex(int index) {
    Student student = new Student();
    TableRow row = Students.getRow(index);
    student.setId(row.getString(0));
    student.setStudentName(row.getString(1));
    student.setCurrentCourses(parseCurrentCourses(row.getString(2)));
    student.setCurrentGPA(row.getFloat(3));
    return student;
  }

  public Table getAllStudents() {
    return Students;
  }
}
