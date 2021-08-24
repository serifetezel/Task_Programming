import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_programming/pages/content_page.dart';



class Lists extends StatefulWidget {
  const Lists({Key? key}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<Lists> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController tarihController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference taskRef = _firestore.collection('taskCollection');
    var task1Ref = _firestore.collection('taskCollection').doc('Task 1');

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Task List',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
        ),
        body: Center(
          child: Container(
            //margin: EdgeInsets.all(10),
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
                          return Flexible(
                            child: ListView.builder(
                              itemCount: listOfDocumentSnap.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.purple[100],
                                  
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Content(task: listOfDocumentSnap[index].data() as Map,)),);
                                    },
                                    child: ListTile(
                                      title: Text(
                                          '${(listOfDocumentSnap[index].data() as Map)['Title']}',
                                          style: TextStyle(fontSize: 24)),
                                      
                                      trailing: IconButton(
                                        color: Colors.grey[800],
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          await listOfDocumentSnap[index]
                                              .reference
                                              .delete();
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                          
                        }
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30.0),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(hintText: 'Task adını giriniz: '),
                        ),
                        TextFormField(
                          controller: tarihController,
                          decoration: InputDecoration(hintText: 'Task zamanını giriniz: '),
                        ),
                        TextFormField(
                          controller: contentController,
                          decoration: InputDecoration(hintText: 'Task içeriğini giriniz: '),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('+', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),),
          onPressed: ()async{
            print(titleController.text);
            print(tarihController.text);
            print(contentController.text);

            Map<String, dynamic> taskData = {
            'Title':titleController.text,
            'Tarih': tarihController.text,
            'Content': contentController.text};
            await taskRef.doc(titleController.text).set(taskData);

          }
        ),
        );
  }
}
