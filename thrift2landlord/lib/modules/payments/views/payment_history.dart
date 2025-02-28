// class TransactionHistoryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Transaction History'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'By Land'),
//               Tab(text: 'By Payment'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // Tab 1: By Land
//             ListView.builder(
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network('https://via.placeholder.com/50'),
//                   ),
//                   title: Text('Old Amusement Park', style: Theme.of(context).textTheme.headline6),
//                   subtitle: Text('Payment: Mrs Tosin'),
//                   trailing: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text('₦5M', style: Theme.of(context).textTheme.bodyText1),
//                       Text('Dec 27, 2025', style: Theme.of(context).textTheme.bodyText2),
//                     ],
//                   ),
//                 );
//               },
//             ),

//             // Tab 2: By Payment
//             ListView.builder(
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network('https://via.placeholder.com/50'),
//                   ),
//                   title: Text('Payment Ref #${index + 1}', style: Theme.of(context).textTheme.headline6),
//                   subtitle: Text('Old Amusement Park'),
//                   trailing: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text('₦5M', style: Theme.of(context).textTheme.bodyText1),
//                       Text('Dec 27, 2025', style: Theme.of(context).textTheme.bodyText2),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
