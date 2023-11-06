import 'package:flutter/material.dart';
import 'package:node_crud/src/backend/api.dart';
import 'package:node_crud/src/backend/models.dart';
import 'package:palette_generator/palette_generator.dart';

import 'product_page.dart';

class TestAnimationPage extends StatefulWidget {
  const TestAnimationPage({super.key});

  @override
  State<TestAnimationPage> createState() => _TestAnimationPageState();
}

class _TestAnimationPageState extends State<TestAnimationPage> {
  PageController controller = PageController(viewportFraction: .5);

  Map<String, PaletteGenerator> gen = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select any shoe"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 12,
              ),
              child: Text("Trending products"),
            ),
            SizedBox(
              height: 205,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: CallApi().data1.length,
                itemBuilder: (context, index) {
                  var item = CallApi().data1.elementAt(index);
                  return ShoeCard(gen: gen, item: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShoeCard extends StatelessWidget {
  const ShoeCard({
    super.key,
    required this.gen,
    required this.item,
  });

  final Map<String, PaletteGenerator> gen;
  final ShoeModel item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      width: 205,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          child: MaterialButton(
            onPressed: () async {
              PaletteGenerator p;
              if (gen[item.id] != null) {
                p = gen[item.id]!;
              } else {
                p = await PaletteGenerator.fromImageProvider(
                  AssetImage(item.img),
                );
                gen[item.id] = p;
              }
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductPage(shoe: item, palette: p),
                  ),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Hero(
                    tag: Key(item.id),
                    child: Image.asset(
                      item.img,
                    ),
                  ),
                ),
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
