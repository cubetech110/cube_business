// import 'package:cloud_firestore/cloud_firestore.dart';

// class Visit {
//   String id;
//   String storeId;
//   String userId;
//   DateTime timestamp;

//   Visit({
//     required this.id,
//     required this.storeId,
//     required this.userId,
//     required this.timestamp,
//   });

//   factory Visit.fromFirestore(Map<String, dynamic> data, String id) {
//     return Visit(
//       id: id,
//       storeId: data['storeId'],
//       userId: data['userId'],
//       timestamp: (data['timestamp'] as Timestamp).toDate(),
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       'storeId': storeId,
//       'userId': userId,
//       'timestamp': timestamp,
//     };
//   }
// }
