import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:newsee/AppData/newscollections.dart';
import 'package:newsee/AppSamples/ReactiveForms/forms.dart';
import 'package:newsee/AppSamples/ToolBarWidget/toolbar.dart';
import 'package:newsee/app.dart';
import 'package:newsee/widgets/counter.dart';
import 'package:newsee/widgets/news.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(MyApp()) // Default MyApp()
  // runApp(Counter()); // load CounterApp
  // runApp(App()); // timerApp
  // runApp(ToolBarSample()); // Toolbar App
  runApp(LoginApp()); // Login Form App
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    //return wordPair(theme, style);
    return NewsCard(news: news_collections.sublist(0, 7));
  }

  Widget wordPair(dynamic theme, TextStyle style) {
    return Center(
      child: Column(
        children: [
          Card(
            color: theme.colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(pair.asLowerCase, style: style),
            ),
          ),
        ],
      ),
    );
  }
}
