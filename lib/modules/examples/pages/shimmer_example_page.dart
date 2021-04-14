import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerExamplePage extends StatefulWidget {
  @override
  _ShimmerExamplePageState createState() => _ShimmerExamplePageState();
}

class _ShimmerExamplePageState extends State<ShimmerExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildLoader(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48.0,
                        height: 48.0,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
