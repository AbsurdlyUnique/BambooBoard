// controller/health_controller.dart
import 'package:conduit_core/conduit_core.dart';

class HealthController extends ResourceController {
  @Operation.get()
  Future<Response> getHealth() async {
    return Response.ok({"status": "healthy"});
  }
}
