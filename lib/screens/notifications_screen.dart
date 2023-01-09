import 'package:flutter/material.dart';
import 'package:woo_store/widgets/appbar_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
          title: 'Notificaciones', backgroundColor: Colors.pinkAccent),
      body: Column(
        children: const [
          Expanded(
            child: Center(
              child: Text('Notificaciones'),
            ),
          ),
        ],
      ),
    );
  }
}
