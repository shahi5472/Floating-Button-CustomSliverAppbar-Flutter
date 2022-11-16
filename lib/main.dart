import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // const SliverAppBar(
          //   backgroundColor: Colors.amber,
          //   expandedHeight: 300,
          //   pinned: true,
          //   title: Text('Test Project'),
          //   leading: Icon(Icons.arrow_back),
          //   actions: [Icon(Icons.settings)],
          // ),
          const SliverPersistentHeader(
            delegate: CustomSliverAppbarDelegate(expandedHeight: 300),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: List.generate(20, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  child: Text('Index :: $index'),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSliverAppbarDelegate extends SliverPersistentHeaderDelegate {
  const CustomSliverAppbarDelegate({required this.expandedHeight});

  final double expandedHeight;

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    const size = 60;
    final top = (expandedHeight - shrinkOffset - size / 2);
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Opacity(
          opacity: disappear(shrinkOffset),
          child: Image.network(
            'https://picsum.photos/200/300?random=2',
            fit: BoxFit.cover,
          ),
        ),
        Opacity(
          opacity: appear(shrinkOffset),
          child: AppBar(
            title: const Text('Test Title'),
          ),
        ),
        Positioned(
          top: top,
          right: 20,
          child: Opacity(
            opacity: disappear(shrinkOffset),
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(oldDelegate) => true;

  double appear(double shrinkOffset) => (shrinkOffset / expandedHeight);

  double disappear(double shrinkOffset) => (1 - shrinkOffset / expandedHeight);
}
