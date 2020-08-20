import 'package:last_fm_api/src/api_client.dart';
import 'package:meta/meta.dart';

abstract class ApiModule {
  const ApiModule(this.prefix, this.client)
      : assert(prefix != null),
        assert(client != null);

  @protected
  final String prefix;

  @protected
  final LastFM_API_Client client;
}
