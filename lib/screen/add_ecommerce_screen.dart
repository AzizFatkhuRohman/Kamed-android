import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kamed/providers/user_provider.dart';
import 'package:kamed/resource/firestore_methods.dart';
import 'package:kamed/utils/colors.dart';
import 'package:kamed/utils/utils.dart';
import 'package:kamed/widgets/text_field_input.dart';
import 'package:provider/provider.dart';

class AddEcommerceScreen extends StatefulWidget {
  const AddEcommerceScreen({Key? key}) : super(key: key);

  @override
  _AddEcommerceScreenState createState() => _AddEcommerceScreenState();
}

class _AddEcommerceScreenState extends State<AddEcommerceScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _hargaBarangController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Buat postingan jualan'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Ambil dari kamera'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Pilih dari galeri'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Batal"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().addBarang(
        _deskripsiController.text,
        _namaBarangController.text,
        _hargaBarangController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Berhasil di kirim!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _deskripsiController.dispose();
    _namaBarangController.dispose();
    _hargaBarangController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(
                Icons.upload, color: Colors.black,
              ),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black,),
                onPressed: clearImage,
              ),
              title: const Text(
                'Posting jualan', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              actions: <Widget>[
                TextButton(
                  onPressed: () => postImage(
                    userProvider.getUser.uid,
                    userProvider.getUser.username,
                    userProvider.getUser.photoUrl,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.black,
                ),
                )
              ],
            ),
            // POST FORM
             body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                            image: MemoryImage(_file!),
                          )),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Masukkan nama barang',
                textInputType: TextInputType.text,
                textEditingController: _namaBarangController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Masukkan harga',
                textInputType: TextInputType.text,
                textEditingController: _hargaBarangController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Masukkan keterangan',
                textInputType: TextInputType.text,
                textEditingController: _deskripsiController
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
          );
  }
}