import 'package:flutter/material.dart';
import 'package:movie_review/api/movie_review.dart';
import 'package:movie_review/models/movie_review.dart';
import 'package:movie_review/widgets/table_header_cell.dart';
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

  Future<void> _fetchData() async {
    final data = await getMovieReview();
    setState(() {
      _movieData = data;
    });
  }

  void _addNewData() {
    if (_movieData.isEmpty || _movieData.last.id != null) {
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

  List<TableRow> _buildTableBody() {
    final body = <TableRow>[];

    for (var i = 0; i < _movieData.length; i++) {
      deleteRow() {
        _deleteData(i);
      }

      updateRow(String key, value) {
        _movieData[i].updateData(key, value);
        setState(() {});
      }

      body.add(TableRowForm(_movieData[i], i, context, deleteRow, updateRow));
    }
    return body;
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
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
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(4),
                3: FlexColumnWidth(4),
                4: FlexColumnWidth(2),
              },
              border: TableBorder(
                horizontalInside:
                    BorderSide(width: 1, color: Colors.grey.shade500),
                verticalInside:
                    BorderSide(width: 1, color: Colors.grey.shade300),
              ),
              children: [
                const TableRow(
                  children: [
                    TabelHeaderCell(text: 'Index'),
                    TabelHeaderCell(text: 'Movie Title'),
                    TabelHeaderCell(text: 'Movie Title'),
                    TabelHeaderCell(text: 'Review'),
                    TabelHeaderCell(text: ''),
                  ],
                ),
                ..._buildTableBody(),
              ],
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewData,
        tooltip: 'Add new data',
        child: const Icon(Icons.add),
      ),
    );
  }
}
