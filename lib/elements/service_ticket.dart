import 'package:flutter/material.dart';
import 'package:m_softer_test_project/data/services/model.dart';

import '../themes/themes.dart';
import 'show_additional_services.dart';

class ServiceTicket extends StatefulWidget {
  const ServiceTicket({super.key, required this.service});
  final Services service;

  @override
  State<ServiceTicket> createState() => _ServiceTicketState();
}

class _ServiceTicketState extends State<ServiceTicket> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return ShowAdditionalServices();
              });
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: AppColors.white,
            border: Border.all(
              color: AppColors.inputWhite,
            ),
            boxShadow: [shadow],
          ),
          height: 91,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.service.name.toString(),
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //widget.service.icon
                  Image.asset('$pathForImagehairdryer.png'),
                  Text(
                    widget.service.price.toString(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
