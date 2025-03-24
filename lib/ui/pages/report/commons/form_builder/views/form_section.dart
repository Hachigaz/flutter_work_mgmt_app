part of "report_form.dart";

class _FormSectionWidget extends StatelessWidget {
  final FormSection _section;
  const _FormSectionWidget({required FormSection section}) : _section = section;
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    List<Widget> subsections = [];

    for (final subsection in _section.subsections.entries) {
      subsections.add(
        _FormSubsectionWidget(
          subsection: subsection.value,
          sectionIndex: _section.sectionIndex,
        ),
      );
    }

    return ListView(
      children: [
        Text(
          style: typography.xl2.copyWith(fontWeight: FontWeight.w600),
          "Section ${_section.label}",
        ),
        ...subsections,
        // IntrinsicHeight(child: Column(children: subsections)),
      ],
    );
  }
}
