import 'package:flutter/material.dart';
import 'package:node_crud/src/backend/api.dart';
import 'package:node_crud/src/backend/models.dart';
import 'package:node_crud/src/backend/token.dart';
import 'package:node_crud/src/views/auth/login.dart';
import 'package:node_crud/src/views/test_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            onPressed: () async {
              await AccessToken().removeToken();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () async {
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TestAnimationPage(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.next_plan),
          ),
        ],
      ),
      body: FutureBuilder(
        future: CallApi().getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ProductModel m = snapshot.data!.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(m.productName),
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: Badge.count(
                          count: index + 1,
                          backgroundColor: Colors.indigo,
                          smallSize: 50,
                          largeSize: 50,
                          textStyle: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            );
          }
        },
      ),
    );
  }
}
