import 'package:flutter/material.dart';

class DialogUtils {
  static Future<void> showLoadingDialog(
    BuildContext context, {
    String message = 'Loading...',
    bool dismssible = false,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: dismssible,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text(message),
          ],
        ),
      ),
    );
  }

  static Future<void> buildDialog(
    BuildContext context, {
    String? title,
    String? content,
    String? posActionText,
    String? negActionText,
    VoidCallback? posaction,
    VoidCallback? negaction,
    dismssable = false,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        actions: [
          if (negActionText != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (negaction != null) negaction();
              },
              child: Text(negActionText),
            ),
          if (posActionText != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (posaction != null) posaction();
              },
              child: Text(posActionText),
            ),
        ],
        title: title != null ? Text(title) : null,
        content: content != null ? Row(children: [Text(content)]) : null,
      ),
    );
  }
}
