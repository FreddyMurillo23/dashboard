// import 'package:admin/Repository/Facultades_repository.dart';
// import 'package:admin/models/Facultades.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';

// class FacultadesController extends ControllerMVC {
//   List<Facultades>? facu;

//   void listenForFacultad(
//       {String? productId, String? message, String? fromSlide}) async {
//     final Stream<Facultades> stream = await getFacultad(productId);
//     stream.listen((Facultades _product) {
//       setState(() {
//         facu!.add(_product);
//       });
//     }, onError: (a) {
//       // showSnackBar(S.of(context).verify_your_internet_connection);
//     }, onDone: () {
//       // listenerProducts.pause();
//       // listenerProducts.cancel();
//       // if (message != null) showSnackBar(message);
//     });
//   }
// }
