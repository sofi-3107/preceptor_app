import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

void enviarSMS(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}

launchMailto(destinatario, asunto, mensaje) async {
  final mailtoLink = Mailto(
    to: [destinatario],
    subject: asunto,
    body: mensaje,
  );
  // Convert the Mailto instance into a string.
  // Use either Dart's string interpolation
  // or the toString() method.
  await launch('$mailtoLink');
}

/* Future<void> isInstalled() async {
  final val =
      await WhatsappShare.isInstalled(package: Package.businessWhatsapp);
  print('Está instalado Whatsap?: $val');
}

Future<void> share(msg, numero) async {
  await WhatsappShare.share(
    text: msg,
    phone: numero,
  );
}
 */