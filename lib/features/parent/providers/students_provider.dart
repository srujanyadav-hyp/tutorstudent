import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tutorconnect/features/parent/services/students_service.dart';

part 'students_provider.g.dart';

@riverpod
class Students extends _$Students {
  @override
  Future<List<Map<String, dynamic>>> build() async {
    return [];
  }

  Future<void> loadStudents() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(studentsServiceProvider).getLinkedStudents(),
    );
  }

  Future<void> linkStudent(String studentId) async {
    await ref.read(studentsServiceProvider).linkStudent(studentId);
    loadStudents();
  }

  Future<void> unlinkStudent(String studentId) async {
    await ref.read(studentsServiceProvider).unlinkStudent(studentId);
    loadStudents();
  }
}
