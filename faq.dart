import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {"question": "What are the early signs of pregnancy?", "answer": "Early signs include missed periods, nausea, vomiting, fatigue, and frequent urination."},
    {"question": "How much weight should I gain during pregnancy?", "answer": "It depends on your pre-pregnancy weight, but generally 25-35 pounds for a normal BMI."},
    {"question": "What foods should I avoid during pregnancy?", "answer": "Avoid raw seafood, unpasteurized dairy, high-mercury fish, and excessive caffeine."},
    {"question": "Is it safe to exercise during pregnancy?", "answer": "Yes, but stick to low-impact exercises like walking, swimming, and prenatal yoga."},
    {"question": "What are the common pregnancy complications?", "answer": "Complications include gestational diabetes, preeclampsia, and preterm labor."},
    {"question": "What is morning sickness and how can I manage it?", "answer": "Morning sickness is nausea during pregnancy. Eating small meals and ginger tea may help."},
    {"question": "How often should I visit the doctor during pregnancy?", "answer": "Regular checkups are recommended: every 4 weeks until 28 weeks, then more frequently."},
    {"question": "Can I travel during pregnancy?", "answer": "Yes, but avoid long-distance travel after 36 weeks and consult your doctor before flying."},
    {"question": "What are Braxton Hicks contractions?", "answer": "They are practice contractions that help prepare your body for labor."},
    {"question": "How can I prevent stretch marks?", "answer": "Keeping your skin moisturized and maintaining a healthy weight gain may help reduce stretch marks."},
    {"question": "What is gestational diabetes?", "answer": "It is high blood sugar during pregnancy that requires monitoring and dietary management."},
    {"question": "What are the warning signs of preterm labor?", "answer": "Signs include regular contractions, lower back pain, and vaginal discharge changes before 37 weeks."},
    {"question": "Can I dye my hair during pregnancy?", "answer": "Most doctors recommend waiting until the second trimester and using ammonia-free dyes."},
    {"question": "How much sleep do I need during pregnancy?", "answer": "At least 7-9 hours per night is recommended for optimal health."},
    {"question": "What should I do if I experience bleeding during pregnancy?", "answer": "Contact your doctor immediately as bleeding could indicate a potential complication."},
    {"question": "How can I reduce back pain during pregnancy?", "answer": "Practice good posture, wear supportive shoes, and try prenatal yoga or massages."},
    {"question": "What are the risks of high blood pressure during pregnancy?", "answer": "It can lead to preeclampsia, premature birth, or complications for the baby."},
    {"question": "Can I have sex during pregnancy?", "answer": "Yes, unless your doctor advises against it due to complications."},
    {"question": "What should I pack in my hospital bag?", "answer": "Pack essentials like clothes, toiletries, baby supplies, and important documents."},
    {"question": "What are the benefits of breastfeeding?", "answer": "It provides essential nutrients, boosts immunity, and promotes bonding with the baby."},
    {"question": "What pain relief options are available during labor?", "answer": "Options include epidurals, breathing techniques, warm baths, and natural pain management."},
    {"question": "How long does postpartum recovery take?", "answer": "Recovery varies but generally takes 6 weeks for vaginal birth and longer for C-sections."},
    {"question": "What are postpartum depression symptoms?", "answer": "Symptoms include sadness, anxiety, irritability, and difficulty bonding with the baby."},
    {"question": "How soon can I start exercising after giving birth?", "answer": "It depends on your delivery type, but gentle activities can start after a few weeks."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pregnancy FAQs"),
        backgroundColor: Colors.pink.shade900,
      ),
      backgroundColor: Colors.pink.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(
                faqs[index]['question']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    faqs[index]['answer']!,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
