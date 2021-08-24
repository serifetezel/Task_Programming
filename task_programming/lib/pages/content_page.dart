import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Content extends StatefulWidget {
  const Content({Key? key, required this.task}) : super(key: key);

  // TEST
  final Map task; // DIŞARDAN BAŞKA BİR WİDGETTAN ÇAĞRILMA
  // TEST

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController tarihController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference taskRef = _firestore.collection('taskCollection');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Task Content',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: taskRef.snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot asyncSnapshot) {
                      if (asyncSnapshot.hasError) {
                        return Center(
                          child: Text('Bir Hata Oluştu, Tekrar Deneyiniz'),
                        );
                      } else {
                        if (asyncSnapshot.hasData) {
                          List<DocumentSnapshot> listOfDocumentSnap =
                              asyncSnapshot.data.docs;
                          return Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Text('Task Adı: ')),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  height: 60,
                                  margin: EdgeInsets.all(5),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        'Task adı:   ',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            widget.task['Title'],
                                            style: TextStyle(fontSize: 25),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  height: 60,
                                  margin: EdgeInsets.all(5),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text('Tarih:   ',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      Wrap(
                                        children: [
                                          Text(
                                            widget.task['Tarih'].toString(),
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  height: 100,
                                  margin: EdgeInsets.all(5),
                                  child: Wrap(
                                    children: [
                                      Text('İçerik: ',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      Wrap(
                                        children: [
                                          Text(
                                            widget.task['Content'],
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 80.0),
                                child: Form(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Güncellenecek olan Task'ın  ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: titleController,
                                        decoration: InputDecoration(
                                            hintText: 'Task adını giriniz: '),
                                      ),
                                      TextFormField(
                                        controller: tarihController,
                                        decoration: InputDecoration(
                                            hintText:
                                                'Task zamanını giriniz: '),
                                      ),
                                      TextFormField(
                                        controller: contentController,
                                        decoration: InputDecoration(
                                            hintText:
                                                'Task içeriğini giriniz: '),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.update),
          onPressed: () async {
            print(titleController.text);
            print(tarihController.text);
            print(contentController.text);

            Map<String, dynamic> taskData = {
              'Title': titleController.text,
              'Tarih': tarihController.text,
              'Content': contentController.text
            };
            await taskRef.doc(titleController.text).update(taskData);
          }),
    );
  }
}
