import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/data/properties.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/animated_labels.dart';
import 'package:stare/widgets/list_picker.dart';
import 'package:stare/widgets/utils.dart';

class ExerciseOptionsPage extends StatefulWidget {
  final String exercise;

  const ExerciseOptionsPage({Key? key, required this.exercise})
      : super(key: key);

  @override
  State<ExerciseOptionsPage> createState() => _ExerciseOptionsPageState();
}

class _ExerciseOptionsPageState extends State<ExerciseOptionsPage> {
  late final GlobalKey<ListPickerState> _bodyListPickerKey;
  late final List<Map<String, String>> _exerciseData;

  int _focusedElementIndex = 0;

  @override
  void initState() {
    super.initState();
    _bodyListPickerKey = GlobalKey<ListPickerState>();
    _exerciseData = exerciseSubOptions[widget.exercise]!;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        const NavBar(
          child: BackArrow(),
        ),
        SizedBox(
          height: 256,
          child: ListPicker(
            width: width,
            itemExtent: 288,
            itemCount: _exerciseData.length,
            itemBuilder: (index, focusedElementIndex) => const _SubActionCard(),
            onChanged: (index) {
              setState(() => _focusedElementIndex = index);
              _bodyListPickerKey.currentState?.animateTo(
                index,
                durationMillis: 600,
              );
            },
          ),
        ),
        const ColumnGap(),
        _Indicator(
          itemCount: _exerciseData.length,
          selectItem: _focusedElementIndex,
        ),
        Expanded(
          child: ListPicker(
            key: _bodyListPickerKey,
            width: width,
            itemExtent: width,
            itemCount: _exerciseData.length,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            itemBuilder: (index, focusedElementIndex) {
              return AnimatedOpacity(
                duration: defaultTransitionDuration,
                opacity: index == focusedElementIndex ? 1 : 0,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const Spacer(),
                    SizedBox(
                      width: 196,
                      child: Text(
                        _exerciseData[index]["title"]!,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SmallColumnGap(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          // TODO: replace with svg icon
                          Icons.timer_outlined,
                        ),
                        const SmallRowGap(),
                        Text(
                          _exerciseData[index]["duration"]!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SmallColumnGap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Text(
                        _exerciseData[index]["description"]!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),
        ),
        const NextButton(),
        const ColumnGap(),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  final int itemCount;
  final int selectItem;

  const _Indicator({
    Key? key,
    required this.itemCount,
    required this.selectItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, (index) {
        final bool selected = selectItem == index;
        return AnimatedContainer(
          duration: defaultTransitionDuration,
          curve: Curves.easeOutExpo,
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 4),
          width: selected ? 32 : 16,
          height: 8,
          decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(3),
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //     offset: Offset(0, defaultPadding / 4),
            //     blurRadius: defaultPadding,
            //     color: selected
            //         ? Theme.of(context).colorScheme.secondary
            //         : Theme.of(context).colorScheme.background,
            //   ),
            // ],
          ),
        );
      }),
    );
  }
}

class _SubActionCard extends StatelessWidget {
  const _SubActionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
          height: 192,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(defaultPadding * 2),
          ),
        ),
        SizedBox(
          height: 224,
          width: 224,
          child: SvgPicture.asset(
            "assets/images/illustration.svg",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
