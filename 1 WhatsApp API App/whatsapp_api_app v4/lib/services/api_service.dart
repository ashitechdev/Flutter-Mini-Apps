import 'package:url_launcher/url_launcher.dart';

class WhatsAppAPIService {
  //WhatsApp api sending message via urlLauncher
  sendMessage(String countryCode, int number, String message) async {
    String url =
        'https://api.whatsapp.com/send?phone=$countryCode$number&text=$message';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
