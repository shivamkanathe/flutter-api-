class Student{
  final String id;
  final String studentName;
  final String schoolName;
  final int age;
  final int contactNumber;

  Student({this.age,this.contactNumber,this.schoolName,this.studentName,this.id});

  factory Student.fromJson(Map<String,dynamic>json){
    return Student(
        id: json['_id'],
        studentName: json['name'],
        schoolName: json['schoolName'],
        contactNumber:json['contactNumber'],
        age:json['age']
    );
  }

}