// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.displayLarge),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;
    // Obtém o estado atual do CartModel e instrui o Flutter
    // a reconstruir este widget quando o CartModel notifica os listeners.
    var cart = context.watch<CartModel>();

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.done),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            cart.remove(cart.items[index]);
          },
        ),
        title: Text(
          cart.items[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
              builder: (context, cart, child) =>
                  Text('\$${cart.totalPrice}', style: hugeStyle),
            ),
            const SizedBox(width: 24),
            Consumer<CartModel>(
              builder: (context, cart, child) {
                return FilledButton(
                  onPressed: () {
                    // Nome completo do aluno
                    final studentName = "Kelwin Jhackson Gonçalves de Moura";
                    
                    // Cria uma string com os itens e seus preços, separados por " + "
                    final itemsText = cart.items
                        .map((item) => '${item.name} - \$ ${item.price}')
                        .join(' + ');
                    
                    // Formata a mensagem final com o nome completo do aluno
                    final message =
                        '$studentName: $itemsText = Total \$ ${cart.totalPrice}';

                    // Exibe o SnackBar com a mensagem gerada
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Text('BUY'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
