
import 'package:plan_q/src/core/services/snackbar_service.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  final SnackBarService _snackBarService;

  UrlLauncherService(this._snackBarService);

  web(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      _snackBarService.show("Could not launch url");
    }
  }
}
