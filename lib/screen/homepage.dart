import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:t2p/main.dart';
import 'package:t2p/screen/api.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<ApiData> futureApiData;
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  Widget slideIndexIndicator(bool isCurrentPage) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? reddish : Colors.black54,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      if(currentIndex < 10 ){
        currentIndex ++;
      }else currentIndex = 0;

      pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 450),
          curve: Curves.easeIn);
    });
    futureApiData = getData();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<ApiData>(
            future: futureApiData,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Container(
                    width: size.width,
                    height: 70,
                    color: reddish,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.search_outlined),
                            SizedBox(width: 10),
                            Text(
                              'Search',
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 35,
                    color: Colors.yellow[600],
                    child: Row(
                      children: [
                        SizedBox(width: 14),
                        Icon(Icons.location_on_outlined, size: 15),
                        SizedBox(width: 10),
                        Text(
                          "Select Delivery Location",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.city == null
                          ? 0
                          : snapshot.data!.city.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 2),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    snapshot.data!.city[index].file),
                              ),
                            ),
                            Text(
                              snapshot.data!.city[index].name,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 145,
                    child: Stack(children: [
                      PageView.builder(
                        controller: pageController,
                        onPageChanged: (val) {
                          setState(() {
                            currentIndex = val;
                          });
                        },
                        itemCount: snapshot.data!.slider == null
                            ? 0
                            : snapshot.data!.slider.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            snapshot.data!.slider[index].file,
                            filterQuality: FilterQuality.low,
                            height: 145,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 20,
                        left: 115,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < snapshot.data!.slider.length; i++)
                              currentIndex == i
                                  ? slideIndexIndicator(true)
                                  : slideIndexIndicator(false)
                          ],
                        ),
                      )
                    ]),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: reddish,
                      borderRadius: BorderRadius.circular(8),
                    ),
                      child: Text("DEALS", style: TextStyle(color: Colors.white, fontSize: 15),)
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(20.0),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.featured == null ? 0 : snapshot.data!.featured.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10
                      ),
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            Text(snapshot.data!.featured[index].name),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('₹ ' + snapshot.data!.featured[index].price, style: TextStyle(color: reddish,fontSize: 13, fontWeight: FontWeight.bold),),
                            )
                          ],
                        );
                      }
                  )
                ],
              );
            }),
      ),
    );
  }
}
