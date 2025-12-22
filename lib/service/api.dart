import 'package:mobile_mikufans/service/impl/aafun.dart';
import 'package:mobile_mikufans/service/impl/bangumi.dart';
import 'package:mobile_mikufans/service/source_service.dart';
import 'package:mobile_mikufans/service/util/dio_timing_extension.dart';
import 'package:mobile_mikufans/service/util/http_util.dart';

class Api {
  static Bangumi bangumi = Bangumi();
  static AAfun aafun = AAfun();
  static final List<SourceService> _sources = [AAfun()];
  static List<SourceService> getSources() {
    _sources.sort((a, b) => a.delay.compareTo(b.delay));
    return _sources;
  }

  static Future<void> delayTest() async {
    final futures = _sources.map((source) async {
      try {
        final response = await HttpUtil.createDio().getWithTiming(
          source.getBaseUrl(),
        );
        final duration = response.extra['request_duration'] as int?;
        source.delay = duration ?? 9999;
      } catch (e) {
        source.delay = 9999;
      }
    }).toList();
    await Future.wait(futures);
  }
}
