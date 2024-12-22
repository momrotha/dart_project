// Input data students
import 'dart:convert';
import 'dart:io';

class Student {
  String id;
  String name;
  String sex;
  int age;
  String address;
  String phoneNumber;

  Student({
    required this.id,
    required this.name,
    required this.sex,
    required this.age,
    required this.address,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sex': sex,
      'age': age,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      sex: json['sex'],
      age: json['age'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
    );
  }

  @override
  String toString() {
    return 'ID: $id, Name: $name, Sex: $sex, Age: $age, Address: $address, Phone: $phoneNumber';
  }
}

void saveToFile(List<Student> students) {
  final file = File('data.json');
  List<Map<String, dynamic>> jsonData = students.map((student) => student.toJson()).toList();
  file.writeAsStringSync(jsonEncode(jsonData));
}

List<Student> loadFromFile() {
  final file = File('data.json');
  if (!file.existsSync()) return [];

  List<dynamic> jsonData = jsonDecode(file.readAsStringSync());
  return jsonData.map((data) => Student.fromJson(data)).toList();
}

void showTable(List<Student> students) {
  if (students.isEmpty) {
    print("No students found.");
    return;
  }

  print("\n--- List of Students ---");
  print("+------+----------------------+------------+-----------+--------------------------+-------------------+");
  print("| ID   | Name                 | Sex        | Age       | Address                  | Phone             |");
  print("+------+----------------------+------------+-----------+--------------------------+-------------------+");
  for (var student in students) {
    print(
        "| ${student.id.padRight(4)} | ${student.name.padRight(20)} | ${student.sex.padRight(10)} | ${student.age.toString().padRight(9)} | ${student.address.padRight(24)} | ${student.phoneNumber.padRight(17)} |");
  }
  print("+------+----------------------+------------+-----------+--------------------------+-------------------+");
}

void main() {
  List<Student> students = loadFromFile();

  while (true) {
    print("\n--- Student Management System ---");
    print("1. Add Student");
    print("2. Show All Students");
    print("3. Delete Student");
    print("4. Update Student");
    print("5. Exit");
    stdout.write("Enter your choice: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write("Enter Student ID: ");
        String id = stdin.readLineSync()!;

        stdout.write("Enter Student Name: ");
        String name = stdin.readLineSync()!;

        stdout.write("Enter Student Sex (Male/Female): ");
        String sex = stdin.readLineSync()!;

        stdout.write("Enter Student Age: ");
        int age = int.parse(stdin.readLineSync()!);

        stdout.write("Enter Student Address: ");
        String address = stdin.readLineSync()!;

        stdout.write("Enter Student Phone Number: ");
        String phoneNumber = stdin.readLineSync()!;

        students.add(Student(id: id, name: name, sex: sex, age: age, address: address, phoneNumber: phoneNumber));
        saveToFile(students);
        print("Student added successfully!");
        break;

      case '2':
        showTable(students);
        break;

      case '3':
        stdout.write("Enter Student ID to delete: ");
        String idToDelete = stdin.readLineSync()!;
        students.removeWhere((student) => student.id == idToDelete);
        saveToFile(students);
        print("Student deleted successfully (if found)!");
        break;

      case '4':
  stdout.write("Enter Student ID to update: ");
  String idToUpdate = stdin.readLineSync()!;
  Student? student = students.firstWhere(
    (student) => student.id == idToUpdate,
    orElse: () => Student(
      id: '',
      name: '',
      sex: '',
      age: 0,
      address: '',
      phoneNumber: '',
    ),
  );

  if (student.id.isNotEmpty) {
    stdout.write("Do you want to update (1) one field or (2) all fields? (Enter 1 or 2): ");
    String? option = stdin.readLineSync();

    if (option == '1') {
      stdout.write("Which field do you want to update? (name/sex/age/address/phone): ");
      String? fieldToUpdate = stdin.readLineSync();

      if (fieldToUpdate == 'name') {
        stdout.write("Enter New Name (${student.name}): ");
        String? newName = stdin.readLineSync();
        student.name = newName!.isEmpty ? student.name : newName;
      } else if (fieldToUpdate == 'sex') {
        stdout.write("Enter New Sex (${student.sex}): ");
        String? newSex = stdin.readLineSync();
        student.sex = newSex!.isEmpty ? student.sex : newSex;
      } else if (fieldToUpdate == 'age') {
        stdout.write("Enter New Age (${student.age}): ");
        String? newAgeStr = stdin.readLineSync();
        student.age = newAgeStr!.isEmpty ? student.age : int.parse(newAgeStr);
      } else if (fieldToUpdate == 'address') {
        stdout.write("Enter New Address (${student.address}): ");
        String? newAddress = stdin.readLineSync();
        student.address = newAddress!.isEmpty ? student.address : newAddress;
      } else if (fieldToUpdate == 'phone') {
        stdout.write("Enter New Phone Number (${student.phoneNumber}): ");
        String? newPhoneNumber = stdin.readLineSync();
        student.phoneNumber = newPhoneNumber!.isEmpty ? student.phoneNumber : newPhoneNumber;
      } else {
        print("Invalid field.");
        break;
      }

      print("Student's $fieldToUpdate updated successfully!");
    } else if (option == '2') {
      stdout.write("Enter New Name (${student.name}): ");
      String? newName = stdin.readLineSync();

      stdout.write("Enter New Sex (${student.sex}): ");
      String? newSex = stdin.readLineSync();

      stdout.write("Enter New Age (${student.age}): ");
      String? newAgeStr = stdin.readLineSync();

      stdout.write("Enter New Address (${student.address}): ");
      String? newAddress = stdin.readLineSync();

      stdout.write("Enter New Phone Number (${student.phoneNumber}): ");
      String? newPhoneNumber = stdin.readLineSync();

      student.name = newName!.isEmpty ? student.name : newName;
      student.sex = newSex!.isEmpty ? student.sex : newSex;
      student.age = newAgeStr!.isEmpty ? student.age : int.parse(newAgeStr);
      student.address = newAddress!.isEmpty ? student.address : newAddress;
      student.phoneNumber = newPhoneNumber!.isEmpty ? student.phoneNumber : newPhoneNumber;

      print("Student updated successfully!");
    } else {
      print("Invalid option.");
    }
  } else {
    print("Student not found.");
  }
  break;

      case '5':
        print("Exiting the program. Goodbye!");
        return;

      default:
        print("Invalid choice. Please try again.");
    }
  }
}
