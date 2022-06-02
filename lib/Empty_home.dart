// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notesapp/NewNote_Screen.dart';
import 'package:provider/provider.dart';

import 'database/dbhelper.dart';
import 'Note_Screen.dart';
import 'model/noteModel.dart';

class home_Screen extends StatefulWidget {
  const home_Screen({Key? key}) : super(key: key);

  @override
  State<home_Screen> createState() => _home_ScreenState();
}

class _home_ScreenState extends State<home_Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //   fit: BoxFit.cover,
        //   // image: NetworkImage(
        //   //   'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpngtree.com%2Ffreepng%2Fnote-icon_5196474.html&psig=AOvVaw2BKsucfVLXe2c6OCVsUL-6&ust=1653772287874000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCMCYy4LMgPgCFQAAAAAdAAAAABAD',
        //   // ),
        // )),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'My Notes',
                style: TextStyle(fontSize: 30, fontFamily: 'Open Sans'),
              ),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 19, 33, 224),
            ),
            floatingActionButton: FloatingActionButton(
              child: Container(
                width: 60,
                height: 60,
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 19, 33, 224),
                      Colors.purple
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/newNote');
              },
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Consumer<AccountChangeNotifier>(builder: (
                BuildContext context,
                AccountChangeNotifier value,
                Widget? child,
              ) {
                if (value.note.isEmpty) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            'images/Note.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Column(
                              children: const [
                                Text(
                                  'No Notes :(',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'Open Sans',
                                      color: Colors.deepPurple),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'you have no task to do',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Open Sans',
                                      color: Colors.grey),
                                ),
                              ],
                            ))
                      ],
                    ),
                  );
                }
                return ListView.separated(
                    itemCount: value.note.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (context, index) {
                      Note note = value.note[index];

                      return GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => editNote_Screen(
                                notedata: note,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.06),
                                spreadRadius: 5,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 5,
                                decoration: BoxDecoration(
                                  // color: Colors.yellow,
                                  color: Color(int.parse('${note.color}')),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        note.title,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        note.description,
                                        maxLines: 2,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 12,
                                          fontFamily: 'Open Sans',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }),
            )));
  }
}
