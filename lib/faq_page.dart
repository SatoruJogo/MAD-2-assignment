import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            FAQItem(question: 'What is Prepo?', answer: 'Prepo is a meal preparation app offering pre-made and customizable meals.'),
            FAQItem(question: 'How do I order a meal?', answer: 'Simply browse meals, add them to the cart, and proceed to checkout.'),
            FAQItem(question: 'Can I customize my meal?', answer: 'Yes! Use our Build Meal feature to create a meal that suits your dietary needs.'),
            FAQItem(question: 'What payment methods do you accept?', answer: 'We accept credit/debit cards and online payment methods.'),
            FAQItem(question: 'Do you offer delivery?', answer: 'Yes, we deliver to all major locations within our service area.'),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(answer),
        ),
      ],
    );
  }
}
