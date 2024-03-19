import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Resources',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResourcesTab(),
    );
  }
}

class ResourcesTab extends StatelessWidget {
  const ResourcesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Health Resources',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 11, 83, 81),
                Color.fromARGB(255, 0, 169, 165),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 7),
            CustomExpansionTile(
              label: 'Long Covid Help',
              icon: Icons.health_and_safety_outlined,
              content:
                  "If you're experiencing long COVID, you're likely dealing with a range of persistent symptoms following the acute phase of COVID-19. These symptoms may include fatigue, shortness of breath, chest pain, joint pain, cognitive difficulties, insomnia, and loss of taste or smell. It's important to seek medical attention to receive the care and management you need. \n\nAlongside medical treatment, there are steps you can take to manage your symptoms and support your recovery. Make sure to get plenty of rest, eat a balanced diet, stay hydrated, engage in gentle exercise as tolerated, and find strategies to manage stress and maintain your mental health. Connecting with others who are also experiencing long COVID through support groups or online communities can provide valuable resources and understanding. \n\nWhile recovery from long COVID varies from person to person, many individuals experience gradual improvement over time. Remember that it's okay to seek ongoing support and management for persistent symptoms, and don't hesitate to reach out for help when you need it. By raising awareness about long COVID, we can ensure that individuals like you receive the care and support necessary for their journey towards recovery.",
              backgroundColor: Color.fromARGB(255, 0, 169, 165),
              link: "https://www.youtube.com/watch?v=DwG04FDMc2Y&ab_channel=UTHealthAustin",
            ),
            SizedBox(height: 7),
            CustomExpansionTile(
              label: "Breathlessness support",
              icon: Icons.local_hospital_outlined,
              content:
                  "If you're experiencing breathlessness, it's crucial to seek medical assistance promptly to determine the cause and receive appropriate treatment. Alongside medical guidance, you can employ relaxation techniques such as deep breathing exercises to alleviate discomfort. Maintaining good posture and ensuring a well-ventilated environment can also help manage symptoms. Don't hesitate to reach out to friends, family, or support groups for emotional support and practical assistance. Remember, managing breathlessness is a journey, but with proactive steps and support, you can work towards improving your symptoms and overall well-being.",
              backgroundColor: Color.fromARGB(255, 0, 169, 165),
              link: "https://www.youtube.com/watch?v=XtQNReF1N6E&ab_channel=TopDoctorsUK",
            ),
            SizedBox(height: 7),
            SizedBox(height: 7),
            CustomExpansionTile(
              label: "Chest pains",
              icon: Icons.local_hotel_rounded,
              content:
                  "If you're coping with chest pains, it's essential to prioritize your health by seeking medical attention promptly to understand the underlying cause and receive appropriate care. While awaiting medical assessment, there are steps you can take to manage discomfort and promote well-being.\n\nFirstly, try to remain calm and avoid activities that exacerbate the pain. If the pain persists or worsens, do not hesitate to seek emergency medical assistance.\n\nIn addition to medical evaluation, practicing relaxation techniques such as deep breathing or meditation may help alleviate tension and discomfort. Maintaining good posture and avoiding strenuous activities can also reduce strain on your chest muscles and potentially alleviate pain.\n\nIt's essential to communicate openly with your healthcare provider about your symptoms and any concerns you may have. They can provide personalized guidance and treatment options tailored to your specific needs.\n\nRemember, chest pain can have various causes, ranging from minor issues to serious medical conditions. Therefore, seeking professional medical advice is crucial for accurate diagnosis and appropriate management. With proper care and support, you can take steps towards managing chest pain and promoting your overall health and well-being.",
              backgroundColor: Color.fromARGB(255, 0, 169, 165),
              link: "https://www.youtube.com/watch?v=I6pennFFsqc&ab_channel=TopDoctorsUK",
            ),
            SizedBox(height: 7),
            CustomExpansionTile(
              label: 'Drowsiness',
              icon: Icons.medical_information_outlined,
              content:
                  "If you're experiencing persistent drowsiness, it's important to address it proactively to ensure your well-being and daily functioning. While drowsiness can have various causes, seeking medical advice is essential to understand the underlying factors and receive appropriate treatment.\n\nIn the meantime, there are steps you can take to manage drowsiness and improve your alertness. Establishing a regular sleep schedule and ensuring you get adequate rest each night can help regulate your body's natural sleep-wake cycle and reduce daytime drowsiness. Additionally, practicing good sleep hygiene, such as creating a comfortable sleep environment and avoiding stimulants like caffeine close to bedtime, may promote better sleep quality.\n\nEngaging in regular physical activity and maintaining a balanced diet can also contribute to overall well-being and energy levels. Be mindful of any medications or substances that may contribute to drowsiness and consult with your healthcare provider if you have concerns.\n\nIf drowsiness persists despite these measures, don't hesitate to seek medical advice. Your healthcare provider can conduct a thorough evaluation to identify any underlying medical conditions contributing to your symptoms and recommend appropriate interventions.\n\nRemember, managing drowsiness is essential for your overall health and quality of life. By taking proactive steps and seeking professional guidance, you can address your symptoms effectively and improve your daily functioning and well-being.",
              backgroundColor: Color.fromARGB(255, 0, 169, 165),
              link: "https://www.youtube.com/watch?v=6NDlFADXIhc&ab_channel=MedicalCentric",
            ),
            SizedBox(height: 7),
            CustomExpansionTile(
              label: 'Loss of smell and taste',
              icon: Icons.food_bank_outlined,
              content:
                  "If you're experiencing a loss of smell and taste, it's important to address it promptly to understand the underlying cause and seek appropriate care. While loss of smell and taste can be distressing, there are steps you can take to manage the symptoms and improve your quality of life.\n\nFirst and foremost, consider seeking medical advice to determine the cause of your loss of smell and taste. Your healthcare provider can conduct an evaluation and recommend appropriate treatment options tailored to your specific situation.\n\nIn the meantime, there are strategies you can employ to cope with the loss of smell and taste. Experimenting with different flavors and textures in your meals can help enhance your eating experience despite the reduced sense of taste. Using aromatic herbs and spices can also add depth and flavor to your dishes.\n\nAdditionally, practicing good oral hygiene and maintaining a healthy diet can help support overall oral health and potentially improve your sense of taste over time.\n\nKeep in mind that loss of smell and taste can have various causes, including viral infections like COVID-19. Therefore, seeking professional medical advice is crucial for accurate diagnosis and appropriate management.\n\nWhile it can be challenging to cope with the loss of smell and taste, remember that you're not alone, and support is available. Connecting with others who are experiencing similar challenges through support groups or online communities can provide valuable resources and understanding.\n\nBy taking proactive steps and seeking professional guidance, you can address your symptoms effectively and work towards improving your sense of smell and taste.",
              backgroundColor: Color.fromARGB(255, 0, 169, 165),
              link: "https://www.youtube.com/watch?v=5rH7AekoHbs&ab_channel=Rehealthify",
            ),
            SizedBox(height: 7),
            CustomExpansionTile(
              label: 'Headaches',
              icon: Icons.medication_outlined,
              content:
                  "If you're dealing with persistent headaches, it's important to address them promptly to ensure your well-being and daily functioning. While headaches can have various causes, seeking medical advice is crucial to understand the underlying factors and receive appropriate treatment.\n\nIn the meantime, there are steps you can take to manage headaches and alleviate discomfort. Ensuring you stay hydrated, maintain regular sleep patterns, and practice relaxation techniques such as deep breathing or meditation may help reduce headache frequency and intensity. Additionally, managing stress levels and avoiding triggers such as loud noises or bright lights can also contribute to headache management.\n\nOver-the-counter pain medications, such as acetaminophen or ibuprofen, may provide temporary relief from mild to moderate headaches. However, it's essential to use these medications as directed and consult with a healthcare professional if headaches persist or worsen.\n\nIf headaches are accompanied by other concerning symptoms such as changes in vision, speech difficulties, or weakness in the limbs, seek immediate medical attention as these may indicate a more serious underlying condition.\n\nRemember that managing headaches is essential for your overall health and quality of life. By taking proactive steps and seeking professional guidance, you can address your symptoms effectively and improve your daily functioning and well-being.",
              backgroundColor: Color.fromARGB(255, 0, 169, 165),
              link: "https://www.youtube.com/watch?v=JMfmDAJo3qc&ab_channel=ArmandoHasudungan",
            ),
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final String content;
  final Color backgroundColor;
  final String? link;

  const CustomExpansionTile({
    required this.label,
    required this.icon,
    required this.content,
    required this.backgroundColor,
    this.link,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: Theme.of(context).textTheme.copyWith(
              subtitle1: TextStyle(color: Colors.white),
            ),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(icon),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black, // Set title color to black
              ),
            ),
          ],
        ),
        children: [
          Container(
            color: backgroundColor,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: TextStyle(color: Colors.white),
                ),
                if (link != null)
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      if (await canLaunch(link!)) {
                        await launch(link!);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                    child: Text(
                      'Click here for more information',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
        backgroundColor: backgroundColor,
      ),
    );
  }
}
