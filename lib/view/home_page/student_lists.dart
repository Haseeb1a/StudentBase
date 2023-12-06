import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/controller/home_controller.dart';
import 'package:studentapp/helpers/app_colors.dart';
import 'package:studentapp/model/donor_model.dart';
import 'package:studentapp/view/list_view/add_student.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors().darkshade,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Student ',
                style: TextStyle(
                    color: AppColors().primarytheme,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'DB',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: Consumer<Homecontroller>(
          builder: (context, value, index) {
            if (value.donorDatas.isEmpty) {
              return Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 35,
                      backgroundColor: AppColors().darkshade,
                      child: Icon(
                        Icons.people_sharp,
                        color: AppColors().primarytheme,
                        size: 40,
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Empty DB!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ));
            }
            return Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Column(
                children: [
               
                  Card(
                    elevation: 10,
                    shadowColor: AppColors().primarytheme,
                    color: AppColors().darkshade,
                    child: SizedBox(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.school_rounded,
                              size: 60,
                              color: AppColors().whitetheme,
                            ),
                            radius: 60,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Total Studerts',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors().primarytheme,
                                    fontSize: 20),
                              ),
                              Text(value.donorDatas.length.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors().whitetheme,
                                      fontSize: 25)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: value.donorDatas.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 4 / 5,
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        final StudentModel donorSnap = value.donorDatas[index];
                        return Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      color: AppColors()
                                          .darkshade
                                          .withOpacity(0.09),
                                      blurRadius: 10.0,
                                      spreadRadius: 4.0)
                                ],
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(donorSnap.image!),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: BorderedText(
                                  strokeWidth: 4.0,
                                  strokeColor: AppColors().darktheme,
                                  child: Text(
                                    donorSnap.name.toString(),
                                    style: TextStyle(
                                        color: AppColors().primarytheme,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.5),
                                  child: BorderedText(
                                    strokeWidth: 4.0,
                                    strokeColor: AppColors().whitetheme,
                                    child: Text(
                                      donorSnap.stand.toString(),
                                      style: TextStyle(
                                          color: AppColors().darktheme),
                                    ),
                                  ),
                                )),
                          )
                        ]);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors().darkshade,
          label: Icon(
            Icons.add, color: AppColors().primarytheme,
            // child:Icon(Icons.add,color: AppColors().primarytheme,),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(),
                ));
          }),
        );
  }
}
