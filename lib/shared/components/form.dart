import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final List<Widget> children;

  const CustomForm({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: children.length,
          itemBuilder: (context, index) {
            return children[index];
          }),
    );
  }
}

class FormItem extends StatelessWidget {
  String? label;
  final Widget child;
  double verticalPadding;
  String errorMessage;
  double height;

  FormItem(
      {super.key,
      this.label,
      required this.child,
      this.errorMessage = '',
      this.height = 0.2,
      this.verticalPadding = 8.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: verticalPadding, left: 50.0, right: 50.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null) Text(label!),
                if (errorMessage != '')
                  Row(
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 18,
                        color: Colors.red,
                      ),
                      Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  )
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }
}
