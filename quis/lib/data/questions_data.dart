import '../models/question.dart';

/// Semua soal disimpan di satu list (data dummy lokal).
/// Menambah soal cukup menambah satu objek Question di sini.
const List<Question> quizQuestions = [
  Question(
    text: 'Bahasa pemrograman yang digunakan untuk membuat aplikasi Flutter adalah?',
    options: ['Kotlin', 'Dart', 'Swift', 'JavaScript'],
    correctIndex: 1,
  ),
  Question(
    text: 'Widget yang tidak memiliki state internal disebut?',
    options: ['StatefulWidget', 'InheritedWidget', 'StatelessWidget', 'Scaffold'],
    correctIndex: 2,
  ),
  Question(
    text: 'Method yang dipanggil untuk memberi tahu Flutter agar membangun ulang UI pada StatefulWidget adalah?',
    options: ['build()', 'setState()', 'initState()', 'dispose()'],
    correctIndex: 1,
  ),
  Question(
    text: 'File yang digunakan untuk mendaftarkan aset dan font di Flutter adalah?',
    options: ['main.dart', 'AndroidManifest.xml', 'pubspec.yaml', 'analysis_options.yaml'],
    correctIndex: 2,
  ),
  Question(
    text: 'Widget yang digunakan untuk menyusun anak-anaknya secara vertikal adalah?',
    options: ['Row', 'Stack', 'Column', 'ListTile'],
    correctIndex: 2,
  ),
  Question(
    text: 'Class yang dapat digunakan untuk mengambil ukuran layar perangkat adalah?',
    options: ['MediaQuery', 'Navigator', 'Theme', 'Padding'],
    correctIndex: 0,
  ),
  Question(
    text: 'Method yang digunakan untuk berpindah ke halaman baru adalah?',
    options: ['Navigator.pop()', 'Navigator.push()', 'Navigator.dispose()', 'Navigator.reset()'],
    correctIndex: 1,
  ),
  Question(
    text: 'Pada package Provider, class yang memanggil notifyListeners() adalah?',
    options: ['ChangeNotifier', 'MaterialApp', 'StatelessWidget', 'BuildContext'],
    correctIndex: 0,
  ),
  Question(
    text: 'Widget yang berguna agar konten bisa di-scroll dan mencegah overflow adalah?',
    options: ['SizedBox', 'SingleChildScrollView', 'Container', 'Center'],
    correctIndex: 1,
  ),
  Question(
    text: 'Fitur hot reload pada Flutter berfungsi untuk?',
    options: [
      'Menginstal ulang aplikasi dari awal',
      'Menghapus seluruh cache proyek',
      'Menerapkan perubahan kode tanpa memulai ulang aplikasi',
      'Membuat file APK',
    ],
    correctIndex: 2,
  ),
];
