import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/controller/home_controller.dart';
import 'package:studentapp/helpers/app_colors.dart';
import 'package:studentapp/model/donor_model.dart';
import 'package:studentapp/view/list_view/add_student.dart';
import 'package:studentapp/view/list_view/update_page.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Stud',
              style: TextStyle(
                  color: AppColors().primarytheme,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'ents ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Consumer<Homecontroller>(builder: (context, value, index) {
        if (value.donorDatas.isEmpty) {
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
            itemCount: value.donorDatas.length,
            itemBuilder: (context, index) {
              final StudentModel donorSnap = value.donorDatas[index];
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

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:studentapp/controller/add_controller.dart';

// class UsersList extends StatelessWidget {
//   UsersList({super.key});
//   @override
//   Widget build(BuildContext context) {
//         final size = MediaQuery.of(context).size.width;
//     final addData = Provider.of<AddController>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Donors List',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: StreamBuilder(
//         stream: addData.donor.orderBy('name').snapshots(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {


//               return GridView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 4 / 5,
//                     crossAxisCount: 2,
//                   ),
//                   itemBuilder: (context, index) {
//                          final DocumentSnapshot donorSnap = snapshot.data.docs[index];
//                     // MovieInfoModel data = searchProvider.searchResults[index];
//                     return Container(
//                       width: size * 0.45,
//                       height: size * 0.5,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage(
//                               donorSnap['image'] ),
//                           )),
//                     );
//                   },
//                 );


      
//           }
//           return Container();
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.red,
//           child: const Icon(
//             Icons.add,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //       builder: (context) => AddPage(),
//             //     ));
//           }),
//     );
//   }
// }