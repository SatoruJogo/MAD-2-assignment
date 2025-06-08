import 'package:flutter/material.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About Prepo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Prepo is your one-stop meal preparation app, offering customizable and pre-made meal options. '
                'We ensure healthy and convenient meals tailored to your needs. Our goal is to make meal planning '
                'effortless and enjoyable, whether you are looking for fitness-focused meals, balanced diet plans, or quick bites.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/about_image.jpeg', fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }
}
