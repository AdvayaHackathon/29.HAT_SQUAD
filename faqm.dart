import 'package:flutter/material.dart';

class FAQPagem extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {"question": "गर्भधारणेच्या सुरुवातीच्या लक्षणे कोणती आहेत?", "answer": "यामध्ये मासिक पाळी बंद होणे, उलट्या, थकवा, वारंवार लघवीला जाणे आणि स्तनांमध्ये कोमलता यांचा समावेश होतो."},
    {"question": "गर्भधारणेदरम्यान मला किती वजन वाढवावे?", "answer": "तुमच्या पूर्वीच्या वजनावर अवलंबून असते, परंतु सामान्यतः ११-१६ किलोग्रॅम वजन वाढवावे."},
    {"question": "गर्भधारणेदरम्यान कोणते पदार्थ टाळावेत?", "answer": "कच्चे समुद्री अन्न, न पाश्चराइज केलेले दुग्धजन्य पदार्थ, पारा जास्त असलेली मासळी आणि जास्त कॅफिन असलेले पदार्थ टाळावेत."},
    {"question": "गर्भधारणेदरम्यान व्यायाम करणे सुरक्षित आहे का?", "answer": "होय, पण चालणे, पोहणे आणि प्रेग्नंसी योगासारख्या सौम्य व्यायामांचा समावेश करावा."},
    {"question": "गर्भधारणेदरम्यान कोणत्या समस्या उद्भवू शकतात?", "answer": "यामध्ये गर्भधारणेतील मधुमेह, प्री-एक्लॅम्प्सिया आणि अकाली प्रसूती यांचा समावेश होतो."},
    {"question": "मॉर्निंग सिकनेस म्हणजे काय आणि त्यावर नियंत्रण कसे ठेवावे?", "answer": "गर्भधारणेदरम्यान मळमळ आणि उलटी होणे. लहान लहान आहार घेणे आणि आलेयुक्त चहा पिणे फायदेशीर ठरू शकते."},
    {"question": "गर्भधारणेदरम्यान मला डॉक्टरांकडे किती वेळा भेट द्यावी?", "answer": "२८ आठवड्यांपर्यंत दर ४ आठवड्यांनी आणि त्यानंतर अधिक वारंवार भेट द्यावी."},
    {"question": "मी गर्भधारणेदरम्यान प्रवास करू शकते का?", "answer": "होय, परंतु ३६ आठवड्यांनंतर लांबचा प्रवास टाळावा आणि प्रवास करण्यापूर्वी डॉक्टरांचा सल्ला घ्यावा."},
    {"question": "ब्रॅक्सटन हिक्स संकोचन म्हणजे काय?", "answer": "ही प्रसूतीपूर्व सराव संकुचनं असतात, जी शरीराला प्रसूतीसाठी तयार करतात."},
    {"question": "गर्भधारणेदरम्यान स्ट्रेच मार्क्स टाळण्यासाठी काय करावे?", "answer": "त्वचा मॉइश्चराइझ ठेवणे आणि संतुलित वजन वाढवणे फायदेशीर ठरू शकते."},
    {"question": "गर्भधारणेतील मधुमेह म्हणजे काय?", "answer": "हा गर्भधारणेदरम्यान वाढलेला रक्तातील साखरेचा स्तर आहे, ज्यावर नियंत्रण ठेवण्यासाठी आहार आणि नियमित तपासणी आवश्यक आहे."},
    {"question": "अकाली प्रसूतीची चेतावणी चिन्हे कोणती आहेत?", "answer": "नियमित संकोचन, पाठदुखी आणि योनीमधून असामान्य स्त्राव होणे हे चिन्हे असू शकतात."},
    {"question": "गर्भधारणेदरम्यान केसांना रंग देणे सुरक्षित आहे का?", "answer": "बहुतेक डॉक्टर दुसऱ्या तिमाहीपर्यंत प्रतीक्षा करण्याचा आणि अमोनिया मुक्त रंगांचा वापर करण्याचा सल्ला देतात."},
    {"question": "गर्भधारणेदरम्यान मला किती झोप घ्यावी?", "answer": "सर्वोत्तम आरोग्यासाठी दररोज ७-९ तास झोप आवश्यक आहे."},
    {"question": "गर्भधारणेदरम्यान रक्तस्त्राव झाल्यास काय करावे?", "answer": "ताबडतोब आपल्या डॉक्टरांचा सल्ला घ्या, कारण रक्तस्त्राव गंभीर समस्या दर्शवू शकतो."},
    {"question": "गर्भधारणेदरम्यान पाठदुखी कमी करण्यासाठी काय करावे?", "answer": "सरळ बसण्याची सवय लावा, आरामदायक चप्पल वापरा आणि प्रसूतीपूर्व योग किंवा मसाज करा."},
    {"question": "गर्भधारणेदरम्यान उच्च रक्तदाबाचे धोके कोणते आहेत?", "answer": "हे प्री-एक्लॅम्प्सिया, अकाली प्रसूती किंवा बाळाच्या आरोग्यासाठी समस्या निर्माण करू शकते."},
    {"question": "गर्भधारणेदरम्यान लैंगिक संबंध ठेवणे सुरक्षित आहे का?", "answer": "होय, जोपर्यंत डॉक्टरांनी टाळण्याचा सल्ला दिलेला नाही."},
    {"question": "माझ्या हॉस्पिटल बॅगमध्ये कोणत्या गोष्टी ठेवाव्यात?", "answer": "कपडे, टॉयलेटरीज, बाळासाठी आवश्यक वस्तू आणि महत्त्वाची कागदपत्रे ठेवावीत."},
    {"question": "स्तनपानाचे फायदे कोणते आहेत?", "answer": "हे बाळाला आवश्यक पोषण देते, रोगप्रतिकारक शक्ती वाढवते आणि आई-बाळामधील बंध मजबूत करते."},
    {"question": "प्रसूतीदरम्यान वेदना कमी करण्यासाठी कोणते पर्याय आहेत?", "answer": "एपिड्युरल, श्वासोच्छ्वास तंत्र, उबदार स्नान आणि नैसर्गिक वेदनाशामक उपायांचा समावेश आहे."},
    {"question": "प्रसूतीनंतर पुनर्प्राप्तीसाठी किती वेळ लागतो?", "answer": "सामान्यतः ६ आठवडे लागतात, परंतु सिझेरियन केल्यास अधिक वेळ लागू शकतो."},
    {"question": "प्रसूतीनंतर नैराश्याची लक्षणे कोणती आहेत?", "answer": "यामध्ये सतत दु:ख, चिंता, चिडचिड आणि बाळाशी जोडले जाण्यास अडचण येणे यांचा समावेश होतो."},
    {"question": "बाळ झाल्यानंतर व्यायाम कधी सुरू करू शकते?", "answer": "तुमच्या प्रसूतीच्या पद्धतीवर अवलंबून असते, परंतु सौम्य व्यायाम काही आठवड्यांनंतर सुरू करता येतो."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("गर्भधारणा प्रश्नोत्तर"),
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
