import 'package:flutter/material.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/utils.dart';
import 'package:vector_math/vector_math.dart' show radians;

class ShelfPage extends StatelessWidget {
  const ShelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        NavBar(child: NavWheel()),
        Spacer(),
        JournalPagesView(),
        Spacer(),
        // Text("Last Updated 17 Aug ● Total Entries 18"),
        // Spacer(),
      ],
    );
  }
}

class JournalCoverPage extends StatelessWidget {
  final String title;
  final String? year;

  const JournalCoverPage({
    Key? key,
    required this.title,
    this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 328,
      width: 212,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: const <double>[0, 0.2],
          colors: [
            colorScheme.tertiary,
            colorScheme.primary,
          ],
        ),
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(defaultPadding),
          left: Radius.circular(defaultPadding / 4),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(defaultPadding / 2, defaultPadding / 2),
            color: colorScheme.tertiary,
            blurRadius: defaultPadding * 2,
          ),
        ],
      ),
      child: year == null
          ? _getTitle(colorScheme)
          : Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: -defaultPadding / 2,
                  right: defaultPadding,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      year.toString(),
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w800,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                _getTitle(colorScheme),
              ],
            ),
    );
  }

  Widget _getTitle(ColorScheme colorScheme) => Positioned(
        right: defaultPadding * 2,
        bottom: defaultPadding * 2,
        child: Text(
          "Damien's\nJournal",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
      );
}

class JournalPagesView extends StatelessWidget {
  const JournalPagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: <Widget>[
        // ? front cover
        Positioned(
          left: -296,
          child: Transform(
            alignment: Alignment.centerRight,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(radians(-30)),
            child: _JournalCover(roundedCorner: false),
          ),
        ),
        // ? back cover
        _JournalCover(),
        // ? page
        _JournalPage(),
        // _FlipViewBuilder(
        //   frontSide: Container(
        //     height: 220,
        //     width: 220,
        //     color: Colors.purple,
        //   ),
        //   backSide: Container(
        //     height: 220,
        //     width: 220,
        //     color: Colors.yellow,
        //   ),
        // ),
      ],
    );
  }
}

class _FlipViewBuilder extends StatefulWidget {
  final Widget frontSide;
  final Widget backSide;

  const _FlipViewBuilder(
      {Key? key, required this.frontSide, required this.backSide})
      : super(key: key);

  @override
  State<_FlipViewBuilder> createState() => _FlipViewBuilderState();
}

class _FlipViewBuilderState extends State<_FlipViewBuilder> {
  final double width = 220;
  bool flipped = false;
  double pos = 0;

  @override
  Widget build(BuildContext context) {
    print(pos * 180);
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(
          () => pos = 1 - (details.localPosition.dx / width),
        );
      },
      child: Transform(
        alignment: Alignment.centerLeft,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(radians(180 * pos)),
        child: flipped ? widget.backSide : widget.frontSide,
      ),
    );
  }
}

class _JournalCover extends StatelessWidget {
  final bool roundedCorner;

  const _JournalCover({Key? key, this.roundedCorner = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 296,
      height: 460,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: roundedCorner
            ? const BorderRadius.horizontal(
                right: Radius.circular(defaultPadding),
              )
            : BorderRadius.zero,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(defaultPadding / 2, defaultPadding / 2),
            color: Theme.of(context).colorScheme.background,
            blurRadius: defaultPadding,
          ),
        ],
      ),
    );
  }
}

class _JournalPage extends StatelessWidget {
  const _JournalPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: 288, // width(296) - padding(8)
      height: 444, // height(460) - padding(16)
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding * 2,
        vertical: defaultPadding * 2,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.surface,
            colorScheme.onPrimary,
          ],
        ),
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(defaultPadding),
          left: Radius.circular(defaultPadding / 4),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.primary),
                  borderRadius: BorderRadius.circular(defaultPadding / 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(height: 2),
                    Text(
                      "Aug",
                      style: textTheme.bodySmall?.copyWith(height: 1.25),
                    ),
                    Text(
                      "7",
                      style: textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Entry no. 27",
                      style: textTheme.bodySmall?.copyWith(height: 1.25),
                    ),
                    const Placeholder(
                      // ? mood
                      fallbackHeight: 32,
                      fallbackWidth: 32,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const ColumnGap(),
          Text(
            "Today was chest exercise day so I did  the PULL workout today and then when I checked on the humus in the fridge it got spoiled and I had to throw all of it  away!\n\nSo I decided I will use fresh instead for  today onwards",
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
