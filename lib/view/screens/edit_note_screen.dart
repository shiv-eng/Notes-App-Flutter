import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/view_model/note.dart';
import '../../core/view_model/note_view_model.dart';

class EditNoteScreen extends StatelessWidget {
  final Note note;
  final TextEditingController titleController;
  final TextEditingController contentController;

  final _formKey = GlobalKey<FormState>();

  EditNoteScreen({super.key, required this.note})
      : titleController = TextEditingController(text: note.title),
        contentController = TextEditingController(text: note.content);

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: titleController,
                label: 'Title',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a title'
                    : null,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _buildTextField(
                  controller: contentController,
                  label: 'Content',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter content'
                      : null,
                  maxLines: null,
                  isFullScreen: true, 
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedNote = Note(
                      id: note.id,
                      title: titleController.text,
                      content: contentController.text,
                    );
                    noteViewModel.updateNote(updatedNote);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Note updated successfully')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    int? maxLines,
    bool isFullScreen = false, 
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), 
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none, 
          contentPadding: const EdgeInsets.all(16),
        ),
        maxLines: isFullScreen ? null : maxLines, 
        validator: validator,
        textAlignVertical: TextAlignVertical.top, 
      ),
    );
  }
}
