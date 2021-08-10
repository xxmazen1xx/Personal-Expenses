import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/transaction.dart';


class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.removeTrans,
  }) : super(key: key);

  final Transaction transaction;
  final removeTrans;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.fromLTRB(10, 6, 10, 6),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
                child: Text('\$${transaction.price}')),
          ),
        ),
        title: Text(
          '${transaction.name}',
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          '${DateFormat.yMMMd().format(transaction.dateTime)}',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: () => removeTrans(transaction.id),
        ),
      ),
    );
  }
}

//////////////////////////////////////////
// THE SAME WIDGET BUILT IN ANOTHER WAY //
//////////////////////////////////////////

// return Card(
//   child: Row(
//     children: [
//       Container(
//           margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
//           decoration: BoxDecoration(
//               border: Border.all(
//             // color: Colors.purple.shade300,
//             color: Theme.of(context).primaryColor,
//             width: 2,
//           )),
//           padding: EdgeInsets.all(10),
//           child: Text(
//             "\$" + transactions[index].price.toStringAsFixed(2),
//             style: TextStyle(
//               // color: Colors.purple,
//               color: Theme.of(context).primaryColor,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           )),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             transactions[index].name,
//             style: Theme.of(context).textTheme.title,
//           ),
//           Text(
//             DateFormat.yMMMd()
//                 .format(transactions[index].dateTime),
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       )
//     ],
//   ),
// );