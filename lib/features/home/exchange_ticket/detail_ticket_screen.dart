import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/typography.dart';
import '../../../model/exchange_ticket_model.dart';
import 'cubit/exchange_ticket_cubit.dart';
import 'cubit/exchange_ticket_state.dart';

class DetailTicketScreen extends StatefulWidget {
  final String bookingCode;

  const DetailTicketScreen({
    super.key,
    required this.bookingCode,
  });

  @override
  State<DetailTicketScreen> createState() => _DetailTicketScreenState();
}

class _DetailTicketScreenState extends State<DetailTicketScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExchangeTicketCubit>().checkBookingCode(widget.bookingCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: AppBar(
        backgroundColor: black00,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: black950),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Tiket',
          style: xlBold,
        ),
      ),
      body: BlocConsumer<ExchangeTicketCubit, ExchangeTicketState>(
        listener: (context, state) {
          if (state is ExchangeTicketExchanged) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
          } else if (state is ExchangeTicketError) {
          }
        },
        builder: (context, state) {
          if (state is ExchangeTicketLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ExchangeTicketError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: red600,
                  ),
                  SizedBox(height: spacing5),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: smMedium,
                  ),
                  SizedBox(height: space600),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Kembali'),
                  ),
                ],
              ),
            );
          }

          if (state is ExchangeTicketSuccess) {
            final orderData = state.order;
            final isExchanging = false;

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(padding20),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: orderData.order.chairs.length,
                      itemBuilder: (context, index) {
                        final chair = orderData.order.chairs[index];
                        return _buildTicketCard(chair);
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(padding20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isExchanging
                          ? null
                          : () {
                        context.read<ExchangeTicketCubit>().confirmExchange(
                          orderId: orderData.order.id,
                          codeOrder: orderData.order.codeOrder,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(vertical: padding20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius300),
                        ),
                        elevation: 0,
                        disabledBackgroundColor: black700_70,
                      ),
                      child: isExchanging
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: black00,
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        'Konfirmasi Tiket',
                        style: smMedium.copyWith(color: black00),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text('Tidak ada data'),
          );
        },
      ),
    );
  }

  Widget _buildTicketCard(Chair chair) {
    return Container(
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.circular(borderRadius500),
        boxShadow: [
          BoxShadow(
            color: black950.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(padding16),
            alignment: Alignment.centerRight,
            child: Text(
              'Detail',
              style:smMedium.copyWith(color: navy400),
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                'Kursi ${chair.chairName ?? '-'}',
                style: xlSemiBold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius400),
                bottomRight: Radius.circular(borderRadius400),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: padding16, horizontal: padding16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: paddingXS,
                    ),
                    child: Text(
                      'Cetak Tiket',
                      textAlign: TextAlign.center,
                      style: smMedium.copyWith(color: black00),
                    ),
                  ),
                ),

                SizedBox(height: space150),

                GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: paddingXS,
                    ),
                    child: Text(
                      'Cetak Kupon',
                      textAlign: TextAlign.center,
                      style:smMedium.copyWith(color: black00),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}