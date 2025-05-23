part of "report_form.dart";

class _FormSubsectionWidget extends StatelessWidget {
  final int _sectionIndex;
  final FormSubsection _subsection;

  const _FormSubsectionWidget({
    required FormSubsection subsection,
    required int sectionIndex,
  }) : _subsection = subsection,
       _sectionIndex = sectionIndex;

  @override
  Widget build(BuildContext context) {
    List<Widget> categories = [];
    String parentRefKey = "${_sectionIndex}_${_subsection.subsectionIndex}";
    for (final category in _subsection.categories.entries) {
      categories.add(
        _FormCategoryWidget(
          category: category.value,
          parentRefKey: parentRefKey,
        ),
      );
    }
    final typography = context.theme.typography;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: padding_2xl,
        horizontal: padding_2xl,
      ),
      child: PageListSection(
        label: Text(
          _subsection.label,
          style: typography.lg.copyWith(fontWeight: FontWeight.w600),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories,
        ),
      ),
    );
  }
}
