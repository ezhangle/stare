import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: defaultPadding * 2,
            left: defaultPadding,
          ),
          child: Row(
            children: const <Widget>[
              NavWheel(),
              Spacer(),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(
            "Let's see what can be done!",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const ColumnGap(),
        SizedBox(
          height: 320,
          child: ActionsListView(
            width: MediaQuery.of(context).size.width,
          ),
        ),
        const ColumnGap(),
        ElevatedButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/arrow-right.svg",
            width: 32.0,
            color: Colors.white,
          ),
        ),
        const ColumnGap()
      ],
    );
  }
}

class ActionsListView extends StatefulWidget {
  final double width;

  const ActionsListView({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<ActionsListView> createState() => _ActionsListViewState();
}

class _ActionsListViewState extends State<ActionsListView> {
  int curEle = 1;
  final double itemExtent = 278;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: itemExtent * 1.55 - (widget.width / 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
      child: ListView.builder(
        itemCount: 4,
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        padding: EdgeInsets.symmetric(horizontal: itemExtent),
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: GestureDetector(
              onTap: () {
                _scrollController.animateTo(
                  itemExtent * 0.8 + index * itemExtent,
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.elasticOut,
                );
              },
              child: ActionCard(
                index: index + 1,
                curEle: curEle,
              ),
            ),
          );
        },
      ),
    );
  }

  int _offsetToMiddleIndex(double offset) =>
      (offset + widget.width / 2) ~/ itemExtent;

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      setState(
          () => curEle = _offsetToMiddleIndex(notification.metrics.pixels));
    }
    return true;
  }
}

class ActionCard extends StatelessWidget {
  final int index;
  final int curEle;

  const ActionCard({
    Key? key,
    required this.index,
    required this.curEle,
  }) : super(key: key);

  double _rotation() {
    if (index < curEle) {
      return -0.20;
    } else if (index == curEle) {
      return 0;
    } else {
      return 0.20;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1200),
      curve: Curves.elasticOut,
      width: 246,
      height: 294,
      transform: Matrix4.identity()
        ..rotateZ(_rotation())
        ..translate(0.0, index == curEle ? 0.0 : 32.0),
      transformAlignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(defaultPadding * 2),
      ),
      child: Stack(
        children: [
          Positioned(
            top: defaultPadding * 2,
            left: defaultPadding * 2,
            child: Text(
              "Eye",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 240,
              width: 240,
              child: SvgPicture.asset(
                "assets/images/illustration.svg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 121,
          //   child: Container(
          //     height: 294,
          //     width: 4,
          //     color: Colors.black,
          //   ),
          // ),
        ],
      ),
    );
  }
}
