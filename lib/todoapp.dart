import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    // TODO: implement initState
    getText();
  }
  var textController=TextEditingController();
  var list=[];

  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body: SingleChildScrollView(scrollDirection: Axis.vertical,
      child: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'Enter Your text',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            controller: textController,),
            ElevatedButton(onPressed: (){Savetext();}, child: Text("Submit"),),
            Column(children: [
             ListView.builder(
               physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,

                 itemCount: list.length,itemBuilder: (BuildContext context,int index ){
               return Card(
                 child: ListTile(
                   title: Text(list[index]),
                 ),
               );


             })

           ],)
          ],
        ),
      ),
    ),
    );
  }
  Future<void>Savetext()async{

    list.add(textController.text);

    SharedPreferences Pref =await SharedPreferences.getInstance();
    final text = await Pref.setString('text',textController.text);
    setState(() {

    });
  }
  Future<void>getText()async {
    SharedPreferences Pref = await SharedPreferences.getInstance();
    textController.text = await Pref.getString('text') ?? '';
    setState(() {

    });
  }
}
