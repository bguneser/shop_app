import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
/*
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);
*/

  @override
  Widget build(BuildContext context) {
   final product=Provider.of<Product>(context,listen: false);
   final cart = Provider.of<Cart>(context,listen: false);
   print('product rebuilds');
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName,
                  arguments: product.id
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx,product,_) => IconButton(
                  icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    product.toggleFavoritesStatus();
                  },
                  color: Theme.of(context).accentColor
              ),
              child: Text('Never changes'),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      );
  }
}
