import 'package:mobile_mikufans/entity/calendar.dart';
import 'package:mobile_mikufans/entity/character.dart';
import 'package:mobile_mikufans/entity/person.dart';
import 'package:mobile_mikufans/entity/subject.dart';
import 'package:mobile_mikufans/entity/subject_relation.dart';

abstract class MetaService {
  String get name;

  String get logoUrl;

  String get baseUrl;

  Future<Subject?> fetchSearchSync(
    String keyword,
    void Function(dynamic) exception,
  );

  Future<Subject?> fetchRecommendSync(
    int page,
    int size,
    void Function(dynamic) exception,
  );

  Future<List<Calendar>> fetchCalendarSync(void Function(dynamic) exception);

  Future<Data?> fetchSubjectSync(
    int subjectId,
    void Function(dynamic) exception,
  );

  Future<List<Person>> fetchPersonSync(
    int subjectId,
    void Function(dynamic) exception,
  );

  Future<List<Character>> fetchCharacterSync(
    int subjectId,
    void Function(dynamic) exception,
  );

  Future<List<SubjectRelation>> fetchSubjectRelationSync(
    int subjectId,
    void Function(dynamic) exception,
  );
}
