import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot> getNotesStream() {
    return FirebaseFirestore.instance.collection('notes').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNoteDialog(context, isEdit: false);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: getNotesStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            var data = snapshot.data!.docs;
            return GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                var note = data[index];
                return InkWell(
                  onTap: () {
                    _title.text = note['title'];
                    _description.text = note['description'];
                    _showNoteDialog(context, isEdit: true, noteId: note.id);
                  },
                  onLongPress: () {
                    _showDeleteDialog(context, note.id);
                  },
                  child: NoteCard(note: note),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showNoteDialog(BuildContext context,
      {required bool isEdit, String? noteId}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Note' : 'Create New Note'),
          actions: [
            TextButton(
              onPressed: () async {
                if (isEdit) {

                  await FirebaseFirestore.instance
                      .collection('notes')
                      .doc(noteId)
                      .set({
                    'title': _title.text,
                    'description': _description.text,
                  });
                } else {
                  await FirebaseFirestore.instance.collection('notes').add({
                    'title': _title.text,
                    'description': _description.text,
                  });
                }
                _title.clear();
                _description.clear();
                Navigator.pop(context);
              },
              child: Text(isEdit ? 'Update' : 'Add'),
            ),
            TextButton(
              onPressed: () {
                _title.clear();
                _description.clear();
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _description,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to delete this?'),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('notes')
                  .doc(noteId)
                  .delete();
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final QueryDocumentSnapshot note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "images/imge1.jpg",
              width: 300,
              height: 100,
              fit: BoxFit.fill,
            ),
            const Spacer(),
            Text(
              note['title'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              note['description'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
