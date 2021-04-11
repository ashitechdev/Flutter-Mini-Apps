import 'package:url_launcher/url_launcher.dart';

class WhatsAppAPIService {
  //WhatsApp api sending message via urlLauncher
  sendMessage(int countryCode, int number, String message) async {

    /// url is modified as i have added a new Widget for Country code so no more manually '+' sign in the api

    String url =
        'https://api.whatsapp.com/send?phone=$countryCode$number&text=$message';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
