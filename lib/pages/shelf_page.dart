import 'package:flutter/material.dart';

import '../data/style.dart';
import '../widgets/utils.dart';
import '../models/journal.dart';
import '../widgets/journal_view.dart';

final List<Journal> journals = [
  Journal(
    title: "Damien's Journal",
    year: "2022",
    entries: <JournalEntry>[
      for (int index = 1; index < 7; index++)
        JournalEntry(
          entryNumber: index,
          date: index + 10,
          month: "Aug",
          mood: "null",
          content:
              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Necessitatibus fuga facilis atque repellat itaque officiis id quasi dolore cum aperiam!\n\nVeniam architecto laudantium dignissimos mollitia quas repellat aspernatur pariatur rerum!\n\nLorem ipsum dolor sit amet consectetur adipisicing elit. Necessitatibus fuga facilis atque repellat itaque officiis id quasi dolore cum aperiam!",
        ),
    ],
  ),
  Journal(
    title: "John's Journal",
    year: "2019",
    entries: <JournalEntry>[
      for (int index = 1; index < 4; index++)
        JournalEntry(
          entryNumber: index,
          date: index + 4,
          month: "Oct",
          mood: "null",
          content:
              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Necessitatibus fuga facilis atque repellat itaque officiis id quasi dolore cum aperiam!\n\nVeniam architecto laudantium dignissimos mollitia quas repellat aspernatur pariatur rerum!\n\nLorem ipsum dolor sit amet consectetur adipisicing elit. Necessitatibus fuga facilis atque repellat itaque officiis id quasi dolore cum aperiam!",
        ),
    ],
  ),
  Journal(
    title: "Milo's Journal",
    entries: <JournalEntry>[
      for (int index = 1; index < 20; index++)
        JournalEntry(
          entryNumber: index,
          date: index,
          month: "Feb",
          mood: "null",
          content:
              "Lorem ipsum dolor sit amet consectetur adipisicing elit.\n\nNecessitatibus fuga facilis atque repellat itaque officiis id quasi dolore cum aperiam!\n\nVeniam architecto laudantium dignissimos mollitia quas repellat aspernatur pariatur rerum!\n\nLorem ipsum dolor sit amet consectetur adipisicing elit. Necessitatibus fuga facilis atque repellat itaque officiis id quasi dolore cum aperiam!",
        ),
    ],
  ),
];

class ShelfPage extends StatefulWidget {
  const ShelfPage({Key? key}) : super(key: key);

  @override
  State<ShelfPage> createState() => _ShelfPageState();
}

class _ShelfPageState extends State<ShelfPage> {
  int _focusedJournalIndex = 0;
  bool _reading = false;

  @override
  Widget build(BuildContext context) {
    final List<JournalEntry> focusedJournalEntries =
        journals[_focusedJournalIndex].entries;

    return Column(
      children: <Widget>[
        const NavBar(child: NavWheel()),
        const Spacer(),
        SizedBox(
          height: 460,
          child: PageView.builder(
            clipBehavior: Clip.none,
            itemCount: journals.length,
            physics: _reading
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            onPageChanged: (int index) => setState(
              () => _focusedJournalIndex = index,
            ),
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.center,
                child: AnimatedScale(
                  duration: defaultTransitionDuration,
                  curve: Curves.easeOutExpo,
                  scale: _reading ? 1 : 0.75,
                  child: _reading
                      ? SizedBox(
                          width: 299, // 460 * 0.65
                          child: JournalView(
                            // key: GlobalKey<JournalViewState>()
                            //   ..currentState?.animateTo(2),
                            initalPage: 2,

                            coverBackSide: _Cover.backSide(context),
                            pageBackSide: _Page.blank(context),
                            children: <Widget>[
                              _Cover(
                                title: journals[index].title,
                                year: journals[index].year,
                              ),
                              _Page.blank(context),
                              for (final JournalEntry entry
                                  in focusedJournalEntries)
                                _Page(entry),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            setState(
                              () => _reading = true,
                            );
                            await Future.delayed(Duration(milliseconds: 40));
                          },
                          child: _Cover(
                            // height: 345.0, // 460 * 0.75
                            title: journals[index].title,
                            year: journals[index].year,
                          ),
                        ),
                ),
              );
            },
          ),
        ),
        const Spacer(),
        Text(
          "Last Updated ${focusedJournalEntries.last.date} ${focusedJournalEntries.last.month} "
          "● Total Entries ${focusedJournalEntries.length}",
        ),
        const Spacer(),
      ],
    );
  }
}

class _Cover extends StatelessWidget {
  final String title;
  final String? year;

  final double height;

  const _Cover({
    Key? key,
    required this.title,
    this.year,
    this.height = 460,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height * 0.65,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: const <double>[0, 0.15],
          colors: [
            Theme.of(context).colorScheme.tertiary,
            Theme.of(context).colorScheme.primary,
          ],
        ),
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(defaultPadding),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(defaultPadding / 2, defaultPadding / 2),
            color: Theme.of(context).colorScheme.tertiary,
            blurRadius: defaultPadding * 2,
          ),
        ],
      ),
      // alignment: Alignment.bottomRight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (year != null)
            Positioned(
              top: -defaultPadding / 2,
              right: defaultPadding,
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  year!,
                  style: TextStyle(
                    fontSize: height / 5,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          _getTitle(Theme.of(context).colorScheme.onPrimary),
        ],
      ),
    );
  }

  Widget _getTitle(Color textColor) => Positioned(
        right: defaultPadding * 2,
        bottom: defaultPadding * 2,
        child: SizedBox(
          width: height * 0.45,
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: height / 15,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      );

  static Widget backSide(
    BuildContext context, {
    double height = 460,
  }) {
    return Container(
      width: height * 0.65,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(defaultPadding),
        ),
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

class _Page extends StatelessWidget {
  final double width;
  final double height;

  final JournalEntry entry;

  const _Page(
    this.entry, {
    this.width = 288,
    this.height = 444,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding * 2,
        vertical: defaultPadding * 2,
      ),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        gradient: LinearGradient(
          stops: const <double>[0, 0.075],
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
                  border: Border.all(color: colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(defaultPadding / 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(height: 2),
                    Text(
                      entry.month,
                      style: textTheme.bodySmall?.copyWith(height: 1.25),
                    ),
                    Text(
                      entry.date.toString(),
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
                      "Entry no. ${entry.entryNumber}",
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
            entry.content,
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  static Widget blank(
    BuildContext context, {
    double width = 288,
    double height = 444,
  }) {
    return Container(
      width: 288,
      height: 444,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: const <double>[0, 0.06],
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.onPrimary,
          ],
        ),
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(defaultPadding),
          left: Radius.circular(defaultPadding / 4),
        ),
      ),
    );
  }
}
