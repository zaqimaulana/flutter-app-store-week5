import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../products/presentation/providers/product_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),

      body: switch (product.status) {

        ProductStatus.loading || ProductStatus.initial =>
          const Center(
            child: CircularProgressIndicator(),
          ),

        ProductStatus.error => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(product.error ?? 'Error'),
              ElevatedButton(
                onPressed: () => product.fetchProducts(),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),

        ProductStatus.loaded => GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: product.products.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: .75,
          ),
          itemBuilder: (_, i) =>
              _ProductCard(product: product.products[i]),
        ),
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final dynamic product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Rp ${product.price}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}