import 'package:ad_anlam/isimler2.dart';
import 'package:flutter/material.dart';

import 'package:searchbar_animation/searchbar_animation.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      title: 'AdAnlam',
      home: const MyScaffold(),
    );
  }
}

class MyScaffold extends StatefulWidget {
  const MyScaffold({
    super.key,
  });

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  TextEditingController textController = TextEditingController();
  var yeniIsimler = <String>[];
  @override
  void initState() {
    super.initState();
    yeniIsimler.addAll(isimler);
  }

  void arananFiltresi(String yeni) {
    List<String> searchList = <String>[];
    searchList.addAll(isimler);
    if (yeni.isNotEmpty) {
      List<String> yeni2 = <String>[];
      searchList.forEach((element) {
        if (element.toLowerCase().contains(yeni)) {
          yeni2.add(element);
        }
      });
      setState(() {
        yeniIsimler.clear();
        yeniIsimler.addAll(yeni2);
      });
      return;
    } else {
      setState(() {
        yeniIsimler.clear();
        yeniIsimler.addAll(isimler);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 15, 95, 160),
            title: const Text('AdAnlam Uygulaması'),
          ),
          bottomNavigationBar: BottomAppBar(
            color: const Color.fromARGB(255, 15, 95, 160),
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SearchBarAnimation(
                  isSearchBoxOnRightSide: false,
                  hintText: 'Aramak istediğiniz ismi giriniz',
                  textEditingController: textController,
                  isOriginalAnimation: true,
                  enableKeyboardFocus: true,
                  trailingWidget: const SizedBox(),
                  secondaryButtonWidget: const Icon(Icons.close_outlined),
                  buttonWidget: const Icon(Icons.search_outlined,),
                  onSaved: () {},
                  onFieldSubmitted: () {},
                  onChanged: (value) {
                    arananFiltresi(value);
                  }),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 137, 198, 248),
          body: ListView.builder(
             scrollDirection: Axis.vertical,
            itemCount: yeniIsimler.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(10),
                height: 70,
                margin: const EdgeInsets.all(20),
                //   color: Colors.white,
                child: Center(
                  child: Text(
                    '${yeniIsimler[index]}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                  ),
                ),
              );

            },
          )),
    );
  }
}
