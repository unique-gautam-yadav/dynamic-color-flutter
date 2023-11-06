import 'package:flutter/material.dart';
import 'package:node_crud/src/app_provider.dart';
import 'package:node_crud/src/backend/models.dart';
import 'package:provider/provider.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text("App Cart"),
      ),
      body: ListView.builder(
        itemCount: context.watch<AppProvider>().products.length,
        itemBuilder: (context, index) {
          ShoeModel m = context.watch<AppProvider>().products.elementAt(index);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ListTile(
              onTap: () {},
              tileColor: Colors.grey.shade800,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(
                m.name,
                style: const TextStyle(fontSize: 20),
              ),
              leading: Container(
                height: 75,
                width: 75,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(m.img),
              ),
              subtitle: Column(
                children: [
                  Text(m.description),
                  ButtonBar(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueAccent),
                        ),
                        onPressed: () {},
                        child: const Text("Buy"),
                      ),
                      const SizedBox(width: 2),
                      ElevatedButton(
                        style: const ButtonStyle(
                            // backgroundColor:
                            //     MaterialStateProperty.all(Colors.red),
                            ),
                        onPressed: () {
                          Provider.of<AppProvider>(context, listen: false)
                              .removeProduct(m);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Item removed"),
                            ),
                          );
                        },
                        // child: const Text("Remove"),
                        child: const Icon(Icons.delete),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
