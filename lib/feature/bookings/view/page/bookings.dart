import 'package:door_care/feature/bookings/view/tabs/committed_tab.dart';
import 'package:door_care/feature/bookings/view/tabs/completed_tab.dart';
import 'package:door_care/feature/bookings/view/tabs/pending_tab.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/opacity_container.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        automaticallyImplyLeading: false,
        leading: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const OpacityContainer(),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Bookings',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColor.secondary,
                    fontSize: 28,
                  ),
            ),
          ],
        ),
        backgroundColor: AppColor.background,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: AppColor.background,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              tabs: [
                _buildSegment('Pending', 0),
                _buildSegment('Committed', 1),
                _buildSegment('Completed', 2),
                
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TabScreenOne(),
          TabScreenTwo(),
          TabScreenThree(),
        ],
      ),
    );
  }

  Widget _buildSegment(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          _tabController.animateTo(index);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _selectedIndex == index
              ? AppColor.primary.withOpacity(0.1)
              : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            color:
                _selectedIndex == index ? AppColor.primary : AppColor.toneThree,
            fontWeight: FontWeight.bold,fontSize: 10,
          ),
        ),
      ),
    );
  }
}
