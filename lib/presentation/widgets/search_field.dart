import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final Function(String value) onSubmit;

  const SearchField({super.key, required this.onSubmit});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'e.g. terrified',
              counterStyle: TextStyle(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        IconButton.outlined(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onSubmit(_controller.text);
            }
          },
          icon: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(Icons.send),
          ),
        ),
      ],
    );
  }
}
