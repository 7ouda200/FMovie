
import 'package:flutter/material.dart';

import '../../shared/app_theme.dart';


class SearchFiled extends StatefulWidget {
  final Function(String) onChanged;

  const SearchFiled(this.onChanged,);

  @override
  State<SearchFiled> createState() => _SearchFiledState();
}

class _SearchFiledState extends State<SearchFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:widget.onChanged,
      decoration: InputDecoration(
        fillColor: Color(0xFF514F4F),
        filled: true,
        border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(30),

        ),
           focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(color: AppTheme.gold),
             borderRadius: BorderRadius.circular(30)
           ),
            focusColor: AppTheme.gold,
            prefixIcon: Icon(Icons.search,color: Colors.white,),
            hintText:'Search',
           hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey),
      ),
    );
  }
}
