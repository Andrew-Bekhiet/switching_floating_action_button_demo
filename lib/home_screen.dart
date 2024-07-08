import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:switching_floating_action_button/switching_floating_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<int> counters = [0, 0, 0];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Symbols.bolt), text: 'Tab 1'),
            Tab(icon: Icon(Symbols.flutter), text: 'Tab 2'),
            Tab(icon: Icon(Symbols.favorite), text: 'Tab 3'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final int c in counters)
            Center(
              child: Text(
                'You pressed the button $c times in this tab',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
        ],
      ),
      floatingActionButton: SwitchingFloatingActionButton(
        animation: _tabController.animation!,
        builder: (context, i, child) => FloatingActionButton(
          onPressed: () => setState(() => counters[i]++),
          child: switch (i) {
            0 => const Icon(Symbols.add),
            1 => const Icon(Symbols.add_home),
            2 => const Icon(Symbols.add_diamond),
            _ => throw UnimplementedError(),
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
