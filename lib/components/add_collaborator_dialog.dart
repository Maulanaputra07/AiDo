import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'dart:developer';

class AddCollaboratorDialog extends StatefulWidget {
  const AddCollaboratorDialog({super.key});

  @override
  State<AddCollaboratorDialog> createState() => _AddCollaboratorDialogState();
}

class _AddCollaboratorDialogState extends State<AddCollaboratorDialog> {
  final _controller = TextEditingController();
  List<DocumentSnapshot> _result = [];
  bool _isLoading = false;

  Future<void> _searchUser(String query) async {
    setState(() => _isLoading = true);

    print("🔎 Mencari user dengan query: $query");

    final snapshot = await FirebaseFirestore.instance
    .collection('users')
    .where('username', isGreaterThanOrEqualTo: query)
    .where('username', isLessThanOrEqualTo: "$query\uf8ff")
    .get();

    print("Jumlah hasil ditemukan : ${snapshot.docs.length}");


    for(var doc in snapshot.docs){
      print("User ditemukan : ${doc['username']} (uid: ${doc.id})");
    }

    if(mounted) {
      setState(() {
        _result = snapshot.docs;
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Tambah Collaborator"),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Cari berdasarkan username",
                suffixIcon: IconButton(
                  onPressed: () => _searchUser(_controller.text.trim()), 
                  icon: const Icon(Icons.search)
                )
              )
            ), 
            const SizedBox(height: 15,),
            if(_isLoading) const CircularProgressIndicator(),
            if(!_isLoading && _result.isNotEmpty)
              Flexible(
                child: ListView.builder(
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: _result.length,
                  itemBuilder: (context, i){
                    final user = _result[i].data() as Map<String, dynamic>;
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(user['username'] ?? ''),
                      subtitle: Text(user['email'] ?? ''),
                      onTap: () {
                        print("klik user ${user['username']}");
                        Navigator.pop(context, user['username']);
                      },
                    );
                  }
                ),
              )
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context), 
        )
      ],
    );
  }
}