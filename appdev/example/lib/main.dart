/// import as ferramentas do flutter que iremos usar
import 'package:flutter/material.dart';

/// função principal onde o dart começa a correr
void main() {
  runApp(const MyApp());
}

/// Primeiro Widget:
/// O widget MaterialApp indica ao flutter as bases da aplicação e de como deve
/// montá-lo. A ideia por trás deste widget é para definições mais gerais da
/// aplicação
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Função build é a função que constrói o UI que lhe for retornado, sendo
  /// neste caso a MaterialApp e, posteriormente, esta mostra o que lhe for dado
  /// no home
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Este `title` pode ser diferente daquele dado no MyHomePage, sendo que
      /// este parâmetro é mais usado nos separadores dos web browsers
      title: 'Workshop de AppDev',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Workshop de AppDev'),
    );
  }
}

/// Segundo Widget:
/// Um widget criado por nós - neste caso já feito pelo comando
/// `flutter create` - em que gere a pagina principal da aplicação e respetivo
/// conteúdo. Sendo por isso, a variável `title` foi uma escolha de quem criou
/// esta classe , mas poderia uma abordagem diferente.
///
/// Este widget em si está dividido entre o próprio StatefulWidget e a classe  que
/// gere o estado deste widget e quando deve atualizá-lo.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// classe  que gere o estado do widget MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  /// contador das vezes que o botão foi carregado
  int contadorBotao = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// Usa-se o `widget` para representar/trocar dados da classe parente
        /// - o MyHomePage
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),

        /// Centrar os elementos na página, sendo que não garante vertical,
        /// devido ao Widget Column ocupar verticalmente o espaço e não ser
        /// possível aplicar o efeito de central a menos do uso do
        /// `MainAxisAlignment`, como se tem aqui mostrado
        child: Center(
          child: Column(
            /// para garantir que os elementos estão centrados na coluna
            /// (verticalmente)
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWithPadding(
                'Botão foi carregado $contadorBotao vezes',
                padding: 12.0,
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint("butão carregado");
                  setState(() => contadorBotao++);
                },
                child: const TextWithPadding("Isto é um botão"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /// Incrementa o valor do contador e, a fim de se mostrar na UI, usa-se
        /// a função `setState`, podendo estar ou não estar presente a operação de incremento, não é necessário para a o update na UI
        onPressed: () => setState(() => contadorBotao = 0),

        /// se o valor for maior que 0, então retorna o valor contrário; se não
        /// for, retorna 0
        child: Text("${contadorBotao > 0 ? -contadorBotao : 0}"),
      ),
    );
  }
}

/// Terceiro widget:
/// Widget que mostra o texto com certo padding à volta
///
/// Dado que não precisa de alterar o seu conteúdo internamente - mesmo input
/// resulta mesmo output - significa que este Widget é stateless. Neste caso,
/// temos o padding que se mantém constante ao longo do uso da app e definido no
/// input, se necessário pelo parâmetro opcional, e temos o texto que também é
/// definido pelos parâmetros, mas desta vez obrigatório para gerar o texto em si
class TextWithPadding extends StatelessWidget {
  const TextWithPadding(
    this.texto, {
    this.padding = 8.0,
    Key? key,
  }) : super(key: key);

  /// os parâmetros são final para garantir o estado constante ao longo do uso,
  /// mas não era necessário para o bom funcionamento do widget

  /// Texto para mostrar
  final String texto;

  /// Padding usado à volta do texto para ser mostrado
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(texto),
    );
  }
}
