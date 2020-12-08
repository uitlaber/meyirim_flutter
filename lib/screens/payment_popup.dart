import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/components/donate_modal.dart';

import 'package:meyirim/models/project.dart';



void displayPaymentForm(BuildContext context, Project project) {
  showModalBottomSheet(
      isScrollControlled: true,
      // Important: Makes content maxHeight = full device height
      context: context,
      builder: (context) {
        return DonateModal(project: project);
      });
}
