import 'dart:ui';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:node_crud/src/views/cart.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../app_provider.dart';
import '../backend/models.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.shoe, required this.palette});

  @override
  State<ProductPage> createState() => _ProductPageState();
  final ShoeModel shoe;
  final PaletteGenerator palette;
}

class _ProductPageState extends State<ProductPage> {
  bool showDetails = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(const Duration(milliseconds: 250)).then(
          (value) => setState(
            () {
              showDetails = true;
            },
          ),
        );
      },
    );
  }

  addToCartAnim() async {
    totalItem++;
    await runAddToCartAnimation(imageKey);
    await cartKey.currentState!.runCartAnimation((totalItem).toString());
  }

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;
  final GlobalKey imageKey = GlobalKey();
  int itemCount = 0;
  int totalItem = 0;

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      jumpAnimation: const JumpAnimationOptions(active: false),
      dragAnimation: const DragToCartAnimationOptions(
          // rotation: true,
          ),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.shoe.name),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        floatingActionButton: showDetails
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductCart(),
                      ));
                },
                child: AddToCartIcon(
                  key: cartKey,
                  icon: const Icon(Icons.shopping_cart),
                  badgeOptions: const BadgeOptions(
                    active: false,
                    backgroundColor: Colors.red,
                  ),
                ),
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                height: 300,
                child: ZoomIn(
                  animate: showDetails,
                  child: Center(
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        color:
                            widget.palette.dominantColor?.color.withOpacity(.2),
                        borderRadius: BorderRadius.circular(333),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                height: 300,
                child: Center(
                  child: Container(
                    key: imageKey,
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(),
                    child: Hero(
                        tag: Key(widget.shoe.id),
                        child: Image.asset(widget.shoe.img)),
                  ),
                ),
              ),
              Positioned(
                top: 346,
                left: 20,
                right: 20,
                bottom: 320,
                child: FlipInX(
                  animate: showDetails,
                  // duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: Text(
                      widget.shoe.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FlipInY(
                  animate: showDetails,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Container(
                      width: 300,
                      height: 250,
                      padding: const EdgeInsets.all(35),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: SizedBox(
                          height: 250 - 70,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Price ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const Text(
                                    ":",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "\$${widget.shoe.price}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "Count ",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  const Text(":"),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (itemCount > 0) {
                                              setState(() {
                                                itemCount--;
                                              });
                                            }
                                          },
                                          child: const Icon(
                                            Icons.remove_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "  $itemCount  ",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              itemCount++;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 35),
                              const Spacer(),
                              Text(
                                "Total = \$${widget.shoe.price * itemCount}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 16),
                              ContainerButton(
                                onClick: () async {
                                  for (int i = 0; i < itemCount; i++) {
                                    totalItem++;
                                    addToCartAnim();
                                    setState(() {});
                                    await Future.delayed(
                                        const Duration(milliseconds: 100));
                                    if (context.mounted) {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .addProduct(widget.shoe);
                                    }
                                  }
                                  setState(() {
                                    itemCount = 0;
                                  });
                                },
                                isDisabled: itemCount <= 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerButton extends StatefulWidget {
  const ContainerButton({
    super.key,
    required this.onClick,
    this.isDisabled = false,
  });

  @override
  State<ContainerButton> createState() => _ContainerButtonState();

  final VoidCallback onClick;
  final bool isDisabled;
}

class _ContainerButtonState extends State<ContainerButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClick();
      },
      onTapDown: (det) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (det) {
        setState(() {
          isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: AnimatedScale(
        scale: isPressed ? .95 : 1,
        duration: const Duration(milliseconds: 50),
        child: AnimatedOpacity(
          opacity: widget.isDisabled || isPressed ? .7 : 1,
          duration: const Duration(milliseconds: 50),
          child: Container(
            width: 150,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                "Add to cart",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
