import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/reciter_audio_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _showReciterSelectionSheet(BuildContext context, List<ReciterAudioEntity> reciters, int selectedReciterIndex) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const Text(
                    'اختر القارئ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColorsLight.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: reciters.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final reciter = reciters[index];
                        final isSelected = index == selectedReciterIndex;
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          leading: CircleAvatar(
                            backgroundColor: isSelected
                                ? AppColorsLight.primary.withValues(alpha: 0.1)
                                : AppColorsLight.gray.withValues(alpha: 0.1),
                            child: Icon(
                              Icons.mic_none_rounded,
                              color: isSelected ? AppColorsLight.primary : AppColorsLight.gray,
                            ),
                          ),
                          title: Text(
                            reciter.reciterName,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 15,
                              color: isSelected ? AppColorsLight.primary : AppColorsLight.textPrimary,
                            ),
                          ),
                          subtitle: Text(
                            'المدة: ${_formatDuration(reciter.duration)}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle_rounded, color: AppColorsLight.secondary)
                              : null,
                          onTap: () {
                            context.read<ContentCubit>().selectReciter(index);
                            Navigator.pop(bottomSheetContext);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentCubit, ContentState>(
      builder: (context, state) {
        final content = state.contentDetails;
        if (content == null) return const SizedBox.shrink();

        final audioDuration = state.audioDuration;
        final playbackProgress = state.playbackProgress;
        final isPlaying = state.isPlaying;
        final title = content.title;
        final reciters = content.audios;
        final selectedReciterIndex = state.selectedAudioIndex;

        final progressValue = audioDuration.inSeconds > 0
            ? playbackProgress.inSeconds / audioDuration.inSeconds
            : 0.0;

        return Directionality(
          textDirection: TextDirection.rtl, // Forces proper RTL layout for audio controls
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColorsLight.primary,
              borderRadius: BorderRadius.circular(24), // Transforms it into a gorgeous capsule
              boxShadow: [
                BoxShadow(
                  color: AppColorsLight.primary.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                // Left Action: Play / Pause Accent Circle
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_filled_rounded
                        : Icons.play_circle_filled_rounded,
                  ),
                  color: AppColorsLight.white,
                  iconSize: 48, // Noticeably larger hit target
                  onPressed: () {
                    context.read<ContentCubit>().togglePlayPause();
                  },
                ),
                const SizedBox(width: 12),

                // Middle Column: Metadata Tracking & Reciter Selector
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColorsLight.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                if (reciters.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    reciters[selectedReciterIndex].reciterName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColorsLight.secondary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (reciters.length > 1)
                            InkWell(
                              onTap: () => _showReciterSelectionSheet(context, reciters, selectedReciterIndex),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.mic_rounded,
                                      color: AppColorsLight.secondary,
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'تغيير القارئ',
                                      style: TextStyle(
                                        color: AppColorsLight.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppColorsLight.white,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Progress indicator track
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: progressValue,
                          minHeight: 4,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          valueColor: const AlwaysStoppedAnimation(
                            AppColorsLight.secondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Timestamp row providing context for long audios
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(playbackProgress),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 11,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            _formatDuration(audioDuration),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 11,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Right Action: Stop and Hide Buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.stop_rounded),
                      color: Colors.white.withValues(alpha: 0.7),
                      iconSize: 28,
                      onPressed: () {
                        context.read<ContentCubit>().stopAudio();
                      },
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.close_rounded),
                      color: Colors.white.withValues(alpha: 0.7),
                      iconSize: 24,
                      onPressed: () {
                        context.read<ContentCubit>().togglePlayerVisibility();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
