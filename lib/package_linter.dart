library package_linter;

import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:flutter/cupertino.dart';

PluginBase createPlugin() => PackageLinter();

class PackageLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        const PackageLintRule(),
      ];
}

class PackageLintRule extends DartLintRule {
  const PackageLintRule() : super(code: _code);

  static const _code =
      LintCode(name: 'disable_annotations', problemMessage: 'Description');

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter,
      CustomLintContext context) {
    context.registry.addAnnotation((node) {
      switch (node.name.name.toLowerCase()) {
        case 'experimental':
          debugPrint('experimental');
          reporter.reportErrorForNode(_code, node, []);
          break;
      }
    });
  }
}
