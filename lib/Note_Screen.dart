import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/model/noteModel.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'database/dbhelper.dart';

class editNote_Screen extends StatefulWidget {
  late Note notedata;

  editNote_Screen({required this.notedata});

  @override
  State<editNote_Screen> createState() => _editNote_ScreenState();
}

class _editNote_ScreenState extends State<editNote_Screen> {
  late TextEditingController titleTextController;
  late TextEditingController descriptionTextController;
  Color noteColor = Colors.blue;
  Color classicwhite = Color(0xffFFFFFF);
  Color lightpink = Color(0xffF28B81);
  Color yellow = Color(0xffF7BD02);
  Color lightyellow = Color(0xffFBF476);
  Color lightgreen = Color(0xffCDFF90);
  Color turquoise = Color(0xffA7FEEB);
  Color lightcyan = Color(0xffCBF0F8);
  Color lightblue = Color(0xffAFCBFA);
  Color plum = Color(0xffD7AEFC);
  Color mistyrose = Color(0xffFBCFE9);
  Color lightbrown = Color(0xffE6C9A9);
  Color lightgray = Color(0xffE9EAEE);

  bool whiteCheck = false;
  bool lightpinkCheck = false;
  bool yellowCheck = false;
  bool lightyellowCheck = false;
  bool lightgreenCheck = false;
  bool turquoiseCheck = false;
  bool lightcyanCheck = false;
  bool lightblueCheck = false;
  bool plumCheck = false;
  bool mistyroseCheck = false;
  bool lightbrownCheck = false;
  bool lightgrayCheck = false;
  String Shared = '';
  shareDta() {
    Shared =
        '${titleTextController.text} \n \n  ${descriptionTextController.text}  ';

    // print(x);
  }

  void restart() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    titleTextController = TextEditingController(text: widget.notedata.title);
    descriptionTextController =
        TextEditingController(text: widget.notedata.description);
    noteColor = Color(widget.notedata.color);
  }

  @override
  void dispose() {
    titleTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: whiteCheck ? Colors.white : Colors.black),
        title: Row(
          children: [
            Text('Edit Note',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  color: whiteCheck ? Colors.white : Colors.black,
                )),
            Spacer(),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              height: 360,
                              decoration: BoxDecoration(
                                color: noteColor,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ListTile(
                                    onTap: () {
                                      shareDta();
                                      Share.share(Shared);
                                    },
                                    leading: SizedBox(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      Color(lightgray.value)),
                                              child: Icon(Icons.share)),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text('Share with your friends',
                                              style: TextStyle(
                                                  color: whiteCheck
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Open Sans')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Provider.of<AccountChangeNotifier>(
                                              context,
                                              listen: false)
                                          .delete(widget.notedata.id);
                                      clear();

                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    leading: SizedBox(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      Color(lightgray.value)),
                                              child: Icon(Icons.delete)),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text('Delete',
                                              style: TextStyle(
                                                  color: whiteCheck
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Open Sans')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListTile(
                                    onTap: () async {
                                      if (titleTextController.text.isNotEmpty &&
                                          descriptionTextController
                                              .text.isNotEmpty) {
                                        await saveAccount();

                                        Note duplicatednote = Note();
                                        duplicatednote.title =
                                            titleTextController.text;
                                        duplicatednote.description =
                                            descriptionTextController.text;
                                        duplicatednote.color = noteColor.value;
                                        bool inserted = await Provider.of<
                                                    AccountChangeNotifier>(
                                                context,
                                                listen: false)
                                            .create(duplicatednote);

                                        Navigator.pop(context);
                                      }
                                    },
                                    leading: SizedBox(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      Color(lightgray.value)),
                                              child: Icon(Icons.copy_rounded)),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text('Duplicate',
                                              style: TextStyle(
                                                  color: whiteCheck
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Open Sans')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = classicwhite;
                                              whiteCheck = true;

                                              lightpinkCheck = false;
                                              yellowCheck = false;
                                              lightyellowCheck = false;
                                              lightgreenCheck = false;
                                              turquoiseCheck = false;
                                              lightcyanCheck = false;
                                              lightblueCheck = false;
                                              plumCheck = false;
                                              mistyroseCheck = false;
                                              lightbrownCheck = false;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: whiteCheck
                                                        ? Colors.black45
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: classicwhite,
                                              ),
                                              child: whiteCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.black45)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = lightpink;

                                              whiteCheck = false;

                                              lightpinkCheck = true;
                                              yellowCheck = false;
                                              lightyellowCheck = false;
                                              lightgreenCheck = false;
                                              turquoiseCheck = false;
                                              lightcyanCheck = false;
                                              lightblueCheck = false;
                                              plumCheck = false;
                                              mistyroseCheck = false;
                                              lightbrownCheck = false;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: lightpinkCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: lightpink,
                                              ),
                                              child: lightpinkCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = yellow;

                                              whiteCheck = false;

                                              lightpinkCheck = false;
                                              yellowCheck = true;
                                              lightyellowCheck = false;
                                              lightgreenCheck = false;
                                              turquoiseCheck = false;
                                              lightcyanCheck = false;
                                              lightblueCheck = false;
                                              plumCheck = false;
                                              mistyroseCheck = false;
                                              lightbrownCheck = false;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: yellowCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: yellow,
                                              ),
                                              child: yellowCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = lightyellow;

                                              whiteCheck = false;

                                              lightpinkCheck = false;
                                              yellowCheck = false;
                                              lightyellowCheck = true;
                                              lightgreenCheck = false;
                                              turquoiseCheck = false;
                                              lightcyanCheck = false;
                                              lightblueCheck = false;
                                              plumCheck = false;
                                              mistyroseCheck = false;
                                              lightbrownCheck = false;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: lightyellowCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: lightyellow,
                                              ),
                                              child: lightyellowCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = lightgreen;

                                              whiteCheck = false;

                                              lightpinkCheck = false;
                                              yellowCheck = false;
                                              lightyellowCheck = false;
                                              lightgreenCheck = true;
                                              turquoiseCheck = false;
                                              lightcyanCheck = false;
                                              lightblueCheck = false;
                                              plumCheck = false;
                                              mistyroseCheck = false;
                                              lightbrownCheck = false;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: lightgreenCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: lightgreen,
                                              ),
                                              child: lightgreenCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = turquoise;

                                              whiteCheck = false;

                                              lightpinkCheck = false;
                                              yellowCheck = false;
                                              lightyellowCheck = false;
                                              lightgreenCheck = false;
                                              turquoiseCheck = true;
                                              lightcyanCheck = false;
                                              lightblueCheck = false;
                                              plumCheck = false;
                                              mistyroseCheck = false;
                                              lightbrownCheck = false;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: turquoiseCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: turquoise,
                                              ),
                                              child: turquoiseCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = lightcyan;

                                              whiteCheck = false;

                                              lightpinkCheck = false;
                                              yellowCheck = false;
                                              lightyellowCheck = false;
                                              lightgreenCheck = false;
                                              turquoiseCheck = false;
                                              lightcyanCheck = true;
                                              lightblueCheck = false;
                                              plumCheck = false;
                                              mistyroseCheck = false;
                                              lightbrownCheck = false;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: lightcyanCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: lightcyan,
                                              ),
                                              child: lightcyanCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = lightblue;

                                              whiteCheck = false;

                                              lightpinkCheck = false;
                                              yellowCheck = false;
                                              lightyellowCheck = false;
                                              lightgreenCheck = false;
                                              turquoiseCheck = false;
                                              lightcyanCheck = false;
                                              lightblueCheck = true;
                                              plumCheck = false;
                                              mistyroseCheck = false;
                                              lightbrownCheck = false;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: lightblueCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: lightblue,
                                              ),
                                              child: lightblueCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = plum;

                                              whiteCheck = false;

                                              lightpinkCheck = false;
                                              yellowCheck = false;
                                              lightyellowCheck = false;
                                              lightgreenCheck = false;
                                              turquoiseCheck = false;
                                              lightcyanCheck = false;
                                              lightblueCheck = false;
                                              plumCheck = true;
                                              mistyroseCheck = false;
                                              lightbrownCheck = false;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: plumCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: plum,
                                              ),
                                              child: plumCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = mistyrose;

                                              whiteCheck = false;

                                              lightpinkCheck = false;
                                              yellowCheck = false;
                                              lightyellowCheck = false;
                                              lightgreenCheck = false;
                                              turquoiseCheck = false;
                                              lightcyanCheck = false;
                                              lightblueCheck = false;
                                              plumCheck = false;
                                              mistyroseCheck = true;
                                              lightbrownCheck = false;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: mistyroseCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: mistyrose,
                                              ),
                                              child: mistyroseCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = lightbrown;

                                              whiteCheck = false;

                                              lightpinkCheck = false;
                                              yellowCheck = false;
                                              lightyellowCheck = false;
                                              lightgreenCheck = false;
                                              turquoiseCheck = false;
                                              lightcyanCheck = false;
                                              lightblueCheck = false;
                                              plumCheck = false;
                                              mistyroseCheck = false;
                                              lightbrownCheck = true;
                                              lightgrayCheck = false;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: lightbrownCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: lightbrown,
                                              ),
                                              child: lightbrownCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              noteColor = lightgray;

                                              whiteCheck = false;

                                              lightpinkCheck = false;
                                              yellowCheck = false;
                                              lightyellowCheck = false;
                                              lightgreenCheck = false;
                                              turquoiseCheck = false;
                                              lightcyanCheck = false;
                                              lightblueCheck = false;
                                              plumCheck = false;
                                              mistyroseCheck = false;
                                              lightbrownCheck = false;
                                              lightgrayCheck = true;
                                              setState(() {});
                                              restart();
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: lightgrayCheck
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: lightgray,
                                              ),
                                              child: lightgrayCheck
                                                  ? Icon(Icons.check,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }));
                  setState(() {});
                },
                icon: Icon(
                  Icons.more_vert,
                  color: whiteCheck ? Colors.white : Colors.black,
                ),
                constraints: BoxConstraints()),
            IconButton(
                onPressed: () async {
                  if (titleTextController.text.isNotEmpty &&
                      descriptionTextController.text.isNotEmpty) {
                    await saveAccount();
                  }
                },
                icon: Icon(
                  Icons.check,
                  color: whiteCheck ? Colors.white : Colors.black,
                ),
                constraints: BoxConstraints()),
          ],
        ),
        backgroundColor: noteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(
              color: Colors.transparent,
            ),
            TextField(
              controller: titleTextController,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
              decoration: InputDecoration(
                hintText: 'Type Something....',
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                contentPadding: EdgeInsets.all(15),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              width: 350,
              height: 250,
              child: TextField(
                controller: descriptionTextController,
                expands: true,
                maxLines: null,
                minLines: null,
                decoration: InputDecoration(
                  hintText: 'Type Something....',
                  hintStyle: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.withOpacity(0.6)),
                  contentPadding: EdgeInsets.all(15),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future saveAccount() async {
    bool inserted =
        await Provider.of<AccountChangeNotifier>(context, listen: false)
            .update(note);
    if (inserted) {
      Navigator.pop(context);
    } else {}
  }

  Note get note {
    Note note = Note();
    note.id = widget.notedata.id;
    note.title = titleTextController.text;
    note.description = descriptionTextController.text;
    note.color = noteColor.value;

    return note;
  }

  void clear() {
    titleTextController.text = '';
    descriptionTextController.text = '';
  }
}
