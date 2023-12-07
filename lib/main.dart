import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:movie_review/api/movie_review.dart';
import 'package:movie_review/models/movie_review.dart';
import 'package:movie_review/widgets/table_row_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Review',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Movie Review'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _movieData = [];
  final _formKey = GlobalKey<FormBuilderState>();
  Future<void> _fetchData() async {
    final data = await getMovieReview();
    setState(() {
      _movieData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _addNewData() {
    if (_movieData.last.id != null) {
      setState(() {
        _movieData.add(MovieData(movieTitle: '', userName: '', review: ''));
      });
    }
  }

  void _deleteData(int index) {
    setState(() {
      _movieData.removeAt(index);
    });
  }

  void updateRow(int index, String key, String value) {
    print(_movieData[index].update);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FormBuilder(
                key: _formKey,
                child: Table(
                  border: TableBorder(
                    horizontalInside:
                        BorderSide(width: 1, color: Colors.grey.shade500),
                    verticalInside:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                  children: [
                    const TableRow(
                      children: [
                        TableCell(child: Text('Movie Title')),
                        TableCell(child: Text('Movie Title')),
                        TableCell(child: Text('Review')),
                        TableCell(child: SizedBox())
                      ],
                    ),
                    for (var i = 0; i < _movieData.length; i++)
                      TableRowForm(
                        _movieData[i],
                        i,
                        context,
                        () {
                          _deleteData(i);
                        },
                      )
                  ],
                )),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
