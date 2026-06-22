import 'package:flutter/material.dart';

import '../data/cart_data.dart';
import '../screens/cart_screen.dart';

class CartActionButton extends StatelessWidget {
  const CartActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: cartStore,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              IconButton(
                tooltip: 'Sepetim',
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (cartStore.itemCount > 0)
                Positioned(
                  right: 4,
                  top: 6,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      cartStore.itemCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
