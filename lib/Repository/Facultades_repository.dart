// import 'dart:convert';
// // import 'dart:io';
// import 'package:admin/Repository/custom_trace.dart';
// import 'package:admin/helpers/Helper.dart';
// import 'package:admin/models/Facultades.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async' show Future;
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter/services.dart';


// Future<Stream<Facultades>> getFacultad(String? productId) async {
//   Uri uri = Helper.getUri('api/foods/$productId');
//   // User _user = userRepo.currentUser.value;
//   // if (_user.apiToken == null) {
//   //   uri = uri.replace(queryParameters: {
//   //     'with':
//   //         'media;nutrition;restaurant;categories;extras;foodReviews;productVariations;attributes;attributes.options;productVariations.variationAttributeOptions;foodReviews.user',
//   //     'appends': 'gallery,productWithouttax'
//   //   });
//   // } else {
//   //   uri = uri.replace(queryParameters: {
//   //     'with':
//   //         'media;nutrition;restaurant;categories;extras;foodReviews;productVariations;attributes;attributes.options;productVariations.variationAttributeOptions;foodReviews.user',
//   //     'api_token': userRepo.currentUser.value.apiToken,
//   //     'appends': 'gallery,productWithouttax'
//   //   });
//   // }

// var jsonText = await rootBundle.loadString('assets/data/Listar_Facultades.json');
// print(jsonText);

// //! AQUI HAY QUE CAMBIAR !!!!!
//   print(uri);
//   try {
//     final client = new http.Client();
//     final streamedRest = await client.send(http.Request('get', uri));
//     return streamedRest.stream
//         .transform(utf8.decoder)
//         .transform(json.decoder)
//         .map((data) => Helper.getData(data))
//         .map((data) {
//       return Facultades.fromJSON(data);
//     });
//   } catch (e) {
//     print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
//     return new Stream.value(new Facultades.fromJSON({}));
//   }
// }