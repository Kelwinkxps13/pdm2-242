import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  // Substitua pelos seus dados
  String username = 'email_example@gmail.com'; // Seu e-mail
  String password = ''; // Sua senha ou app password (para Gmail)

  // Configura o servidor SMTP (exemplo com Gmail)
  final smtpServer = gmail(username, password);

  // Criação do e-mail
  final message = Message()
    ..from = Address(username, 'Kelwin Jhackson') // Remetente
    ..recipients.add('kelwin.jhackson63@aluno.ifce.edu.br') // Destinatário
    ..subject = 'Teste de Envio de Email com Dart'
    ..text = 'Este é um e-mail enviado automaticamente pelo programa Dart.'
    ..html = "<h1>Olá!</h1>\n<p>Este e-mail foi enviado utilizando o Dart!</p>";

  try {
    // Envio do e-mail
    final sendReport = await send(message, smtpServer);
    print('E-mail enviado com sucesso: ${sendReport.toString()}');
  } catch (e) {
    print('Falha ao enviar o e-mail: $e');
  }
}