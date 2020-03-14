import 'package:flutter/material.dart';

class FaqCard extends StatefulWidget{

  String listItems;
  String headerTitle;

  FaqCard({this.headerTitle,this.listItems});

  @override
  State<StatefulWidget>createState()
  {
    return FaqCardState();
  }
}
class FaqCardState extends State<FaqCard>
{
  bool isExpand=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isExpand=false;
  }
  @override
  Widget build(BuildContext context) {
    String listItem=this.widget.listItems;
    return  Padding(
      padding: (isExpand==true)?const EdgeInsets.all(8.0):const EdgeInsets.all(12.0),
      child: Container(
        decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: (isExpand!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(22)),
            border: Border.all(color: Colors.blue)
        ),
        child: ExpansionTile(
          key: PageStorageKey<String>(this.widget.headerTitle),
          title: Container(
              width: double.infinity,

              child: Text(this.widget.headerTitle,style: TextStyle(fontSize: (isExpand!=true)?18:22),)),
          trailing: (isExpand==true)?Icon(Icons.arrow_drop_up,size: 32,color: Colors.blue,):Icon(Icons.arrow_drop_down,size: 32,color: Colors.blue),
          onExpansionChanged: (value){
            setState(() {
              isExpand=value;
            });
          },
          children:[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Text(this.widget.listItems, style: TextStyle(fontSize: 16),),
              ),
            )

          ],
        ),
      ),
    );
  }
}
