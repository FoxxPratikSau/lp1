import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/remote_config_provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Provider.of<RemoteConfigProvider>(context);

    double discountedPrice =
        product.price * (1 - (product.discountPercentage) / 100);

    double discountPercentage = product.discountPercentage;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child:
                    product.thumbnail != null && product.thumbnail!.isNotEmpty
                        ? Image.network(
                            product.thumbnail!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          )
                        : const Icon(Icons.image_not_supported),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // Product title
            Text(
              product.title ?? 'No Title',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
            // Product description
            Text(
              product.description ?? 'No Description Available',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // Price section
            Consumer<RemoteConfigProvider>(
              builder: (context, remoteConfigProvider, child) {
                if (!remoteConfigProvider.isInitialized) {
                  return const CircularProgressIndicator();
                }
                return remoteConfigProvider.showDiscountedPrice
                    ? Wrap(
                        spacing: 8.0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            '\$${discountedPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            '${discountPercentage.toStringAsFixed(2)}% off',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
