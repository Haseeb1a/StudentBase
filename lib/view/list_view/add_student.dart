import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/controller/add_controller.dart';
import 'package:studentapp/helpers/app_colors.dart';
import 'package:studentapp/view/widget/appbar_title.dart';
import 'package:studentapp/view/widget/bottombar.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final addData = Provider.of<AddController>(context, listen: false);
    // final profileProvider = Provider.of<>(context);

    return Scaffold(
      backgroundColor: AppColors().darktheme,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: AppBarTitile(firstName: 'Add', secondName: 'Student')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Consumer<AddController>(
                builder: (context, controller, child) {
                  if (controller.imageFile == null) {
                    return Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 300,
                        color: Colors.grey.shade200,
                        child: const Text('Image not found!'));
                  } else {
                    return InkWell(
                      onTap: () async {
                        await controller.pickImage();
                      },
                      child: controller.imageFile != null
                          ? Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 300,
                              color: Colors.grey.shade100,
                              child: Image.file(controller.imageFile!,
                                  fit: BoxFit.fitWidth),
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 300,
                              color: Colors.grey.shade100,
                              child: Image.network(controller.imageUrl,
                                  fit: BoxFit.fitWidth),
                            ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20.0),
              addData.imageFile == null
                  ? Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors()
                                    .darkshade), // Set your desired color
                          ),
                          onPressed: () async {
                            await addData.pickImage();
                          },
                          child: Text(
                            'PICK IMAGE',
                            style: TextStyle(color: AppColors().primarytheme),
                          )),
                    )
                  : const Text('tap to change image '),
              const SizedBox(height: 15),
              TextFormField(
                controller: addData.nameController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: addData.rollController,
                keyboardType: TextInputType.number,
                maxLength: 2,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'roll no'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Roll number is required';
                  }
                  // Add more validation logic for the roll number if needed
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Container(
                height: 60,
                width: 290,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButtonFormField(
                  focusColor: Colors.white,
                  decoration: const InputDecoration(
                    label: Text(
                      'Select Standard',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  items: addData.divisions
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )))
                      .toList(),
                  onChanged: (val) {
                    addData.selectedDivision = val as String?;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a division';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().darkshade,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors().primarytheme),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      addData.uploadImage();
                      // await profileProvider.uploadData();
                      //  addData.addDonor();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomBar(),
                          ));
                      // addData.imageUrl = '';
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
