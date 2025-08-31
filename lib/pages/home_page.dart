import 'package:flutter/material.dart';
import 'package:flutter_catatan_app/data/database_local.dart';
import 'package:flutter_catatan_app/data/note.dart';
import 'package:flutter_catatan_app/data/pin_service.dart';
import 'package:flutter_catatan_app/pages/pin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  void getAllNotes() async {
    notes = await DatabaseLocal().getNotes();
    setState(() {});
  }

  void addNote() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Catatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Isi'),
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final newNote = Note(
                  id: DateTime.now().toString(),
                  title: titleController.text,
                  content: contentController.text,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                setState(() {
                  DatabaseLocal().insertNote(newNote);
                  getAllNotes();
                });
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void deleteNote(String id) {
    //yes no dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Catatan'),
          content: Text('Apakah Anda yakin ingin menghapus catatan ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  DatabaseLocal().deleteNote(id);
                  getAllNotes();
                });
                Navigator.of(context).pop();
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void editNote(Note note) {
    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Catatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Isi'),
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedNote = note.copyWith(
                  title: titleController.text,
                  content: contentController.text,
                  updatedAt: DateTime.now(),
                );
                setState(() {
                  final index = notes.indexWhere((n) => n.id == note.id);
                  if (index != -1) {
                    notes[index] = updatedNote;
                    DatabaseLocal().updateNote(updatedNote);
                    getAllNotes();
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    getAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Harianku'),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () {
              //yes no dialog
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Logout'),
                    content: Text('Apakah Anda yakin ingin logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Batal'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await PinService().saveIsLoggedIn(false);
                          //logout
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const PinPage(),
                            ),
                          );
                        },
                        child: Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.logout),
          ),

          // await
        ],
      ),
      body: notes.isEmpty
          ? Center(
              child: Text(
                'Belum ada catatan. Tambah catatan baru!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: notes.length,

              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(
                      '${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year} - ${note.title}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        deleteNote(note.id);
                      },
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                    ),
                    onTap: () {
                      editNote(note);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addNote();
        },
        label: const Text('Tambah Catatan'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
