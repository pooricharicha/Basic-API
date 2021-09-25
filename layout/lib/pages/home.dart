import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ความรู้พื้นฐานเกี่ยวกับคอมพิวเตอร์"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
          padding: const EdgeInsets.all(5),
          child: FutureBuilder(
            builder: (context, snapshot) {
              //snapshot = ข้อมูล 1 ก้อนจาก future [{},{}]
              var data = json.decode(snapshot.data.toString()); // =[{},{},{}]
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return myBox(data[index]['title'], data[index]['subtitle'],
                      data[index]['image_url'], data[index]['detail']);
                },
                itemCount: data.length,
              ); //มีข้อมูล list ชุดนึง ทำการ repeat แยกข้อมูลเป็นชุดๆ
            },
            future: DefaultAssetBundle.of(context).loadString(
                'assets/data.json'), //ก้อนข้อมูลจาก json เป็นที่มาของข้อมูล
          )),
    );
  }

  Widget myBox(String title, String subtitle, String image_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;

    return Container(
      decoration: BoxDecoration(
          //color: Colors.blue[50],
          image: DecorationImage(
              image: NetworkImage(image_url),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.25), BlendMode.darken)),
          borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      //color : Colors.blue[50],
      height: 175,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                print("Next Page >>>>>");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(v1, v2, v3, v4)));
              },
              child: Text('เข้าสู่เนื้อหา'))
        ],
      ),
    );
  }
}
