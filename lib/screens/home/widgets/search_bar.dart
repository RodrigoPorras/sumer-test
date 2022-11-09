import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  final void Function()? onClear;

  const SearchBar({Key? key, this.onSubmitted, this.controller, this.onClear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasText = controller != null && controller!.text.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search by name',
          fillColor: const Color.fromARGB(255, 102, 100, 100),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: hasText
              ? InkWell(onTap: onClear, child: const Icon(Icons.clear))
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
