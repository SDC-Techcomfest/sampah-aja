import 'package:flutter/material.dart';

import '../components/commons/button.dart';
import '../components/notification_item.dart';
import '../models/notification_model.dart';


final dummyNotification = [
  NotificationModel(
      title: 'Budi Raharjo',
      address: 'Kwarengan, Mulyodadi, Kec. Wonoayu, Kabupaten Sidoarjo, Jawa Timur 61261',
      time: '19:00'
  )
];

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: const Text('Notification'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: dummyNotification.length,
        itemBuilder: (context, index) {
          return NotificationItem(
              title: dummyNotification[index].title,
              subtitle: dummyNotification[index].address,
              time: dummyNotification[index].time,
              onTap: () {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return const _NotificationDetailSheet();
                    });
              }
          );
        },
      ),
    );
  }
}

class _NotificationDetailSheet extends StatelessWidget {
  const _NotificationDetailSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Detail Notification'),
        SizedBox(height: 24),
        Text('Nama'),
        SizedBox(height: 10),
        Text('Budi Raharjo'),
        SizedBox(height: 10),
        Divider(
          height: 1,
          color: Color(0xFFF1F2F9),
        ),

        SizedBox(height: 16),
        Text('Nama'),
        SizedBox(height: 10),
        Text('Budi Raharjo'),
        SizedBox(height: 10),
        Divider(
          height: 1,
          color: Color(0xFFF1F2F9),
        ),

        SizedBox(height: 32),
        CommonButton(
          title: 'Tandai telah diterima',
          onTap: () {},
        ),
        SizedBox(height: 10),
        OutlinedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Buka di Maps'),
                Icon(Icons.gps_fixed)
              ],
            )
        )
      ],
    );
  }
}

