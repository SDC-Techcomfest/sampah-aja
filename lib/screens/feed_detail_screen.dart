import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/feed_detail_cubit.dart';
import '../components/commons/appbar.dart';
import '../components/commons/button.dart';
import '../utils/formz.dart';

class FeedDetailScreen extends StatelessWidget {
  const FeedDetailScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => FeedDetailCubit()..getFeedById(id),
      child: Scaffold(
        body: Column(
          children: [
            GradientAppbar(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        AppBarButton(
                            onTap: () => Navigator.pop(context),
                            icon: Icons.arrow_back
                        ),
                        const SizedBox(width: 24,),
                        Text('Feed', style: theme.textTheme.headline6,)
                      ],
                    ),
                  ),
                )
            ),

            const _FeedDetailView()
          ],
        ),
      ),
    );
  }
}

class _FeedDetailView extends StatelessWidget {
  const _FeedDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return BlocBuilder<FeedDetailCubit, FeedDetailState>(
      builder: (context, state) {
        if (state.status.isSubmissionSuccess) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  state.feedModel!.imageUrl!,
                  width: size.width,
                  height: 221,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.feedModel!.title!,
                        style: theme.textTheme.headline6,
                      ),
                      const SizedBox(height: 18,),
                      Text(
                        "Sumber: ${state.feedModel!.source}",
                        style: theme.textTheme.bodyText2,
                      ),
                      const SizedBox(height: 18,),
                      Text(
                        state.feedModel!.description!,
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}

