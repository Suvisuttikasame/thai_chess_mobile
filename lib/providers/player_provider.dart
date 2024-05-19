import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerProvider = Provider<Map<String, dynamic>>((ref) {
  return {
    'id': DateTime.now().toString(),
    'side': null,
  };
});
