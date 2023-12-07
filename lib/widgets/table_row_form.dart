import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:movie_review/api/movie_review.dart';
import 'package:movie_review/models/movie_review.dart';
import 'package:movie_review/widgets/table_cell.dart';

// ignore: non_constant_identifier_names
TableRow TableRowForm(MovieData movieData, int index, BuildContext context,
    void Function() deleteData) {
  final nameFieldKey = GlobalKey<FormBuilderFieldState>();
  final reviewFieldKey = GlobalKey<FormBuilderFieldState>();
  final titleFieldKey = GlobalKey<FormBuilderFieldState>();
  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<bool> showDialogMessage(String message) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmation'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No')),
            ],
          ),
        ) ??
        false;
  }

  Future<void> onUpdate() async {
    // try {
    await updateMovieReview(
        id: movieData.id!,
        titile: titleFieldKey.currentState!.value,
        name: nameFieldKey.currentState!.value,
        content: reviewFieldKey.currentState!.value);
    showSnackBarMessage('Data updated');

    // } catch (e) {
    //   showSnackBarMessage('Failed to update data');
    // }
  }

  Future<void> onDelete() async {
    if (movieData.id == null) {
      deleteData();
      return;
    }
    try {
      final isConfirmed =
          await showDialogMessage('Are you sure to delete this review?');
      if (!isConfirmed) {
        return;
      }
      await deleteMovieReview(movieData.id!);
      deleteData();
    } catch (e) {
      showSnackBarMessage('Failed to delete data');
    }
  }

  Future<void> onAdd() async {
    try {
      await addMovieReview(
          titile: titleFieldKey.currentState!.value,
          name: nameFieldKey.currentState!.value,
          content: reviewFieldKey.currentState!.value);

      showSnackBarMessage('Data added');
    } catch (e) {
      showSnackBarMessage('Failed to add data');
    }
  }

  return (TableRow(children: [
    TabelCell(
        child: FormBuilderTextField(
      decoration: const InputDecoration(border: InputBorder.none),
      key: nameFieldKey,
      name: "user[$nameFieldKey]",
      initialValue: movieData.userName,
    )),
    TabelCell(
        child: FormBuilderTextField(
      decoration: const InputDecoration(border: InputBorder.none),
      key: titleFieldKey,
      name: "title[$nameFieldKey]",
      initialValue: movieData.movieTitle,
    )),
    TabelCell(
        child: FormBuilderTextField(
      decoration: const InputDecoration(border: InputBorder.none),
      key: reviewFieldKey,
      name: "review[$index]",
      initialValue: movieData.review,
    )),
    TableCell(
      child: Row(children: [
        if (movieData.id != null)
          IconButton(onPressed: onUpdate, icon: const Icon(Icons.check))
        else
          IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
        IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete),
        ),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            nameFieldKey.currentState!.reset();
            titleFieldKey.currentState!.reset();
            reviewFieldKey.currentState!.reset();
          },
        ),
      ]),
    )
  ]));
}
