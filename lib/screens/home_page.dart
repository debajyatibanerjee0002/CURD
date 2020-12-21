import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String studentName, studentId, study;
  double studentGPA;

  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(id) {
    this.studentId = id;
  }

  getStudentStudy(study) {
    this.study = study;
  }

  getStudentGpa(gpa) {
    this.studentGPA = double.parse(gpa);
  }

  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Mystudents").doc(studentName);

    // create map
    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentId": studentId,
      "study": study,
      "studentGPA": studentGPA,
    };

    documentReference
        .set(students)
        .whenComplete(() => print("$studentName created"));
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Mystudents").doc(studentName);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data());
    });
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Mystudents").doc(studentName);

    // create map
    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentId": studentId,
      "study": study,
      "studentGPA": studentGPA,
    };

    documentReference
        .set(students)
        .whenComplete(() => print("$studentName updated"));
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Mystudents").doc(studentName);

    documentReference
        .delete()
        .whenComplete(() => print("$studentName deleted"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CURD",
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 30.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.green[50],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.cyan,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (String name) {
                    getStudentName(name);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Student ID",
                    fillColor: Colors.green[50],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.cyan,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (String id) {
                    getStudentID(id);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Study program",
                    fillColor: Colors.green[50],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.cyan,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (String study) {
                    getStudentStudy(study);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "GPA",
                    fillColor: Colors.green[50],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.cyan,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (String gpa) {
                    getStudentGpa(gpa);
                  },
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Create",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          createData();
                        },
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Read",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          readData();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          updateData();
                        },
                      ),
                      RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          deleteData();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Student ID",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Study",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "GPA",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Mystudents")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.documents[index];
                        return Row(
                          children: [
                            Expanded(
                              child: Text(documentSnapshot["studentName"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["studentId"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["study"]),
                            ),
                            Expanded(
                              child: Text(
                                  documentSnapshot["studentGPA"].toString()),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
