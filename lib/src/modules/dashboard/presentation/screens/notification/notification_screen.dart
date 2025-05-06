import 'package:flutter/material.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/dashboard/presentation/screens/notification/widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.background,
      appBar: const CustomAppBar(
        title: 'Notifications',
        centerTitle: false,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            NotificationCard(
              title: 'Appointment Reminder',
              subtitle:
                  'Your appointment with Dr. Smith is scheduled for tomorrow at 10:00 AM.',
              icon: Icons.calendar_today,
              color: Colors.orange.shade100,
              iconColor: Colors.orange,
              time: DateTime.now().subtract(
                const Duration(minutes: 5),
              ), // 5 minutes ago
            ),
            NotificationCard(
              title: 'Drink Water Reminder',
              subtitle: 'It\'s time to drink water. Stay hydrated!',
              icon: Icons.local_drink,
              color: Colors.blue.shade100,
              iconColor: Colors.blue,
              time: DateTime.now().subtract(
                const Duration(hours: 1),
              ), // 1 hour ago
            ),
            NotificationCard(
              title: 'Medicine Reminder',
              subtitle: 'Don\'t forget to take your medicine at 3:00 PM.',
              icon: Icons.medical_services,
              color: Colors.red.shade100,
              iconColor: Colors.red,
              time: DateTime.now().subtract(
                const Duration(hours: 3),
              ), // 3 hours ago
            ),
            const SizedBox(height: 24),
            Text(
              'Yesterday',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            NotificationCard(
              title: 'Appointment Reminder',
              subtitle:
                  'Your appointment with Dr. Jones is scheduled for today at 2:30 PM.',
              icon: Icons.calendar_today,
              color: Colors.orange.shade100,
              iconColor: Colors.orange,
              time: DateTime.now().subtract(
                const Duration(hours: 5),
              ), // Example: 5 hours ago
            ),
            // Add more past notifications here
          ],
        ),
      ),
    );
  }
}
