import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/sermon_sentence_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/components/audio_player_widget.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';

class SermonTabView extends StatelessWidget {
  const SermonTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocStateBuilderWidget<ContentCubit, ContentState, ContentDetailsEntity?>(
      stateSelector: (state) => state.requestState,
      dataSelector: (state) => state.contentDetails,
      isEmptyChecker: (content) => content == null || content.sentences.isEmpty,
      emptyMessage: "لا توجد خطبة متاحة",
      loadingBuilder: (context) => const Center(child: CircularProgressIndicator()),
      loadedBuilder: (context, state, content) {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 20,
                    height: 1.5,
                    color: AppColorsLight.textPrimary,
                  ),
                  children: content!.sentences.map((sentence) {
                    final isSelected = sentence.id == state.selectedSentenceId;
                    return TextSpan(
                      text: "${sentence.text} ",
                      style: TextStyle(
                        backgroundColor: isSelected
                            ? AppColorsLight.secondary.withValues(alpha: 0.25)
                            : Colors.transparent,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.read<ContentCubit>().selectSentence(sentence.id);
                          if (state.selectedSentenceId != sentence.id) {
                            _showSentenceActions(context, sentence);
                          }
                        },
                    );
                  }).toList(),
                ),
              ),
            ),

            // Premium Floating Audio Player
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: state.isPlayerVisible ? 16 : -150,
              left: 16,
              right: 16,
              child: const AudioPlayerWidget(),
            ),

            // FAB to show audio player when hidden
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: !state.isPlayerVisible ? 16 : -100,
              left: 16,
              child: FloatingActionButton(
                backgroundColor: AppColorsLight.primary,
                elevation: 4,
                child: const Icon(Icons.music_note_rounded, color: Colors.white),
                onPressed: () {
                  context.read<ContentCubit>().togglePlayerVisibility();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSentenceActions(BuildContext context, SermonSentenceEntity sentence) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.menu_book_rounded,
                    color: AppColorsLight.primary,
                  ),
                  title: const Text(
                    'إعراب هذه الجملة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    DefaultTabController.of(context).animateTo(2);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.g_translate_rounded,
                    color: AppColorsLight.primary,
                  ),
                  title: const Text(
                    'شرح المفردات غريبة اللفظ',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    DefaultTabController.of(context).animateTo(3);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.play_circle_outline_rounded,
                    color: AppColorsLight.primary,
                  ),
                  title: const Text(
                    'استماع إلى هذا المقطع المحدّد',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    final cubit = context.read<ContentCubit>();
                    if (!cubit.state.isPlaying) {
                      cubit.togglePlayPause();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
