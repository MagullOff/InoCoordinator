import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/components.dart';

class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('siurek'),
            TextButton(
              child: Text('sign out'),
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }
}
