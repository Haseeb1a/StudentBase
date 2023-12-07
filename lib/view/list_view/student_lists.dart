import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/controller/home_controller.dart';
import 'package:studentapp/helpers/app_colors.dart';
import 'package:studentapp/model/student_model.dart';
import 'package:studentapp/view/list_view/add_student.dart';
import 'package:studentapp/view/list_view/update_page.dart';
import 'package:studentapp/view/widget/appbar_title.dart';

class UsersList extends StatelessWidget {
  UsersList({super.key});
  @override
  Widget build(BuildContext context) {
    Provider.of<Homecontroller>(context,listen: false).fecthDonorDatas();
    final homecontroller = Provider.of<Homecontroller>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: 
        AppBarTitile(firstName: 'Stud', secondName: 'ents ')
      ),
      body: Consumer<Homecontroller>(builder: (context, value, index) {
        if (value.studentDatas.isEmpty) {
          return Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.people_sharp,
                    color: AppColors().primarytheme,
                    size: 40,
                  )),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'ADD student',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ));
        }
        return Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: ListView.builder(
            itemCount: value.studentDatas.length,
            itemBuilder: (context, index) {
              final StudentModel donorSnap = value.studentDatas[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 10),
                            color: AppColors().darkshade.withOpacity(0.09),
        
                            //  .withOpacity(0.09),
                            blurRadius: 10.0,
                            spreadRadius: 4.0)
                      ]),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 37,
                        backgroundImage: NetworkImage(donorSnap.image.toString()),
                        backgroundColor: Colors.black,
                      ),
                      title: Row(
                        children: [
                           BorderedText(
                                strokeWidth: 4.0,
                                strokeColor: AppColors().darkshade,
                                child: Text(
                                  donorSnap.name.toString(),
                                  
                                  style: TextStyle(color: AppColors().whitetheme,fontWeight: FontWeight.bold),
                                ),
                              ),
                          const Spacer(),
                          Expanded(child: Text(donorSnap.stand.toString(),style: TextStyle(color:AppColors().geryshade,fontWeight:FontWeight.bold)))
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(donorSnap.roll.toString(),style: TextStyle(color:AppColors().primarytheme,fontWeight:FontWeight.bold),),
                          const Spacer(),
                          // Expanded(child: Text(donorSnap.place.toString()))
                        ],
                      ),
                      // trailing: Row(),//
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdataUser(
                                              name: donorSnap.name.toString(),
                                              roll: donorSnap.roll.toString(),
                                              stand: donorSnap.stand.toString(),
                                              image: donorSnap.image.toString(),
                                              id: donorSnap.id,
                                            )));
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () {
                                homecontroller.deleteSudent(donorSnap.id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              );
            },
          ),
        );
      }),
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
                  builder: (context) => const AddPage(),
                ));
          }),
    );
  }
}