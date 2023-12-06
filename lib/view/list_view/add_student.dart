import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/controller/add_controller.dart';
import 'package:studentapp/helpers/app_colors.dart';
import 'package:studentapp/view/widget/bottombar.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final addData = Provider.of<AddController>(context);
    // final profileProvider = Provider.of<>(context);

    return Scaffold(
      // backgroundColor: AppColors().g,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Student ',
              style: TextStyle(
                color: AppColors().primarytheme,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'ADD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SizedBox(
              width: 100,
              
              child: _showImage(context)),
            const SizedBox(height: 20.0),
            addData.imageFile == null
                ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black), // Set your desired color
                    ),
                    onPressed: () async {
                      await addData.pickImage();
                    },
                    child: const Text('PICK IMAGE'))
                : Text('tap to change image '),
            const SizedBox(height: 15),
            TextField(
              controller: addData.nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: addData.rollController,
              keyboardType: TextInputType.number,
              maxLength: 2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Roll',
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Select Standard'),
              items: addData.divisions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                addData.selectedDivision = val as String?;
              },
            ),
            const SizedBox(height: 15),
            MaterialButton(
              minWidth: double.infinity,
              color: AppColors().darkshade,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: AppColors().primarytheme)),
              onPressed: () {
                addData.uploadImage();
                // await profileProvider.uploadData();
                //  addData.addDonor();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomBar(),
                    ));
                // addData.imageUrl = '';
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showImage(BuildContext context) {
    var controller = Provider.of<AddController>(context);

    if (controller.imageFile == null) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200, shape: BoxShape.circle),
          alignment: Alignment.center,
          width: 10,
          height: 150,
          child: const Text('Image not found!'));
    } else {
      return InkWell(
        onTap: () async {
          await controller.pickImage();
        },
        child: controller.imageUrl == ''
            ? SizedBox(
              width: 40,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                      color: const Color.fromARGB(255, 0, 0, 0),
                      //  shape: BoxShape.circle
                       ),
                  alignment: Alignment.center,
                  width: 50,
                  height: 190,
                  child: Image.file(controller.imageFile!, fit: BoxFit.cover),
                ),
            )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200, shape: BoxShape.circle),
                alignment: Alignment.center,
                width: 100,
                height: 150,
                child: Image.network(controller.imageUrl, fit: BoxFit.fitWidth),
              ),
      );
    }
  }
}
