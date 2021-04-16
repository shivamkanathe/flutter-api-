class Student{
  final String studentName;
  final String schoolName;
  final int age;
  final int contactNumber;

  Student({this.age,this.contactNumber,this.schoolName,this.studentName});

  factory Student.fromJson(Map<String,dynamic>json){
    return Student(
        studentName: json['name'],
        schoolName: json['schoolName'],
        contactNumber:json['contactNumber'],
        age:json['age']
    );
  }

}