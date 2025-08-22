import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/data/services/models/services.dart';
import 'package:m_softer_test_project/pages/services_page/bloc/services_bloc.dart';

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
    return Container(
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
      child: InkWell(
        onTap: () {
          if (widget.service.options != null) {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return BlocProvider.value(
                  value: context.read<ServicesBloc>(),
                  child: ShowAdditionalServices(
                    serviccesId: widget.service.id ?? 0,
                    options: widget.service.options!,
                  ),
                );
              },
            );
          } else {
            context
                .read<ServicesBloc>()
                .add(CreateOrder(servicesId: widget.service.id, options: []));
          }
        },
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
                Image.asset(
                  'assets/images/${widget.service.icon}',
                  width: 25,
                  height: 25,
                ),
                Text(
                  widget.service.price.toString(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
