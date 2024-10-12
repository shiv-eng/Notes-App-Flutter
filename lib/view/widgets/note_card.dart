import 'package:flutter/material.dart';
import 'package:my_notes/core/view_model/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const NoteCard({Key? key, required this.note, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    Color cardColor = Colors.primaries[note.id! % Colors.primaries.length].withOpacity(0.7);

    return Card(
      color: cardColor, 
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            Text(
              note.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20), 
            ),
            const SizedBox(height: 5),
            Text(
              note.content,
              maxLines: 3, 
              overflow: TextOverflow.ellipsis, 
              style: const TextStyle(fontSize: 16), 
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red), 
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
