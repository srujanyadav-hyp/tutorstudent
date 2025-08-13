import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../core/providers/supabase_provider.dart';
import '../../../core/services/payment_service.dart';
import '../providers/student_provider.dart';
import '../widgets/tutor_list_item.dart';
import '../widgets/student_scaffold.dart';

class TutorListScreen extends ConsumerStatefulWidget {
  const TutorListScreen({super.key});

  @override
  ConsumerState<TutorListScreen> createState() => _TutorListScreenState();
}

class _TutorListScreenState extends ConsumerState<TutorListScreen> {
  late PaymentService _paymentService;

  @override
  void initState() {
    super.initState();
    _paymentService = ref.read(paymentServiceProvider);
    _paymentService.onPaymentSuccess = _handlePaymentSuccess;
    _paymentService.onPaymentError = _handlePaymentError;
    _paymentService.onExternalWallet = _handleExternalWallet;
  }

  @override
  void dispose() {
    _paymentService.dispose();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment Successful: ${response.paymentId}'),
          backgroundColor: Colors.green,
        ),
      );
    }
    // You can also trigger the connectWithTutor here if payment is successful
    // _connectWithTutor();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment Failed: ${response.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('External Wallet: ${response.walletName}'),
          backgroundColor: Colors.blueAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final tutorsAsync = ref.watch(availableTutorsFilteredProvider);

    return StudentScaffold(
      title: 'Find Tutors',
      currentIndex: 1,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            final query = await showSearch<String>(
              context: context,
              delegate: _TutorSearchDelegate(),
            );
            if (query != null) {
              ref.read(tutorSearchQueryProvider.notifier).state = query;
            }
          },
        ),
      ],
      body: tutorsAsync.when(
        data: (tutors) {
          if (tutors.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No tutors available'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(availableTutorsProvider.future),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tutors.length,
              itemBuilder: (context, index) {
                final tutor = tutors[index];
                return TutorListItem(
                  tutor: tutor,
                  onConnect: () async {
                    try {
                      // Get the tutor's hourly rate from their subjects
                      final tutorSubjects = tutor['tutor_subjects'] as List?;
                      double hourlyRate = 500.0; // Default rate

                      if (tutorSubjects != null && tutorSubjects.isNotEmpty) {
                        // Use the first available subject's hourly rate, or average if multiple
                        final rates = tutorSubjects
                            .where((subject) => subject['hourly_rate'] != null)
                            .map(
                              (subject) =>
                                  (subject['hourly_rate'] as num).toDouble(),
                            )
                            .toList();

                        if (rates.isNotEmpty) {
                          hourlyRate =
                              rates.reduce((a, b) => a + b) / rates.length;
                        }
                      }

                      // Convert hourly rate to connection fee (e.g., 1 hour worth)
                      final int amount = (hourlyRate * 100)
                          .round(); // Convert to paisa

                      _paymentService.openCheckout(
                        amount: amount,
                        name: 'TutorConnect',
                        description:
                            'Connect with Tutor: ${tutor['full_name']} (₹${hourlyRate.toStringAsFixed(0)}/hr)',
                        contact: user.phone,
                        email: user.email,
                      );
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error initiating payment: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(availableTutorsProvider),
                child: const Text('RETRY'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TutorSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, query),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text('Search tutors for "$query"'),
    );
  }
}
