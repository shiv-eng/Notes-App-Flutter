import 'package:flutter/material.dart';
import 'package:my_notes/core/view_model/note_view_model.dart';
import 'package:provider/provider.dart';
import 'add_note_screen.dart';
import 'edit_note_screen.dart';
import '../widgets/note_card.dart';

class NotesScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const NotesScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context);

  
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (noteViewModel.notes.isEmpty) {
        noteViewModel.fetchNotes();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: Icon(
              noteViewModel.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              noteViewModel.toggleTheme();
              onThemeChanged(noteViewModel.isDarkMode);
            },
          ),
        ],
      ),
      body: noteViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
               padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: noteViewModel.notes.length,
                itemBuilder: (context, index) {
                  final note = noteViewModel.notes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EditNoteScreen(note: note),
                        ),
                      );
                    },
                    child: NoteCard(
                      note: note,
                      onDelete: () {
                        noteViewModel.deleteNoteById(note.id!);
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddNoteScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
