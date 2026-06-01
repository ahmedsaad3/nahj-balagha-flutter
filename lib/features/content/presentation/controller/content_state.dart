import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';

class ContentState extends Equatable {
  final RequestState requestState;
  final ContentDetailsEntity? contentDetails;
  final int activeTab;
  final String? selectedSentenceId;
  final List<String> selectedScholars;
  final bool isComparing;
  final bool isPlaying;
  final Duration playbackProgress;
  final Duration audioDuration;
  final double audioSpeed;
  final String errorMessage;
  final int selectedAudioIndex;
  final bool isPlayerVisible;

  const ContentState({
    this.requestState = RequestState.idle,
    this.contentDetails,
    this.activeTab = 0,
    this.selectedSentenceId,
    this.selectedScholars = const [],
    this.isComparing = false,
    this.isPlaying = false,
    this.playbackProgress = Duration.zero,
    this.audioDuration = const Duration(minutes: 2, seconds: 46),
    this.audioSpeed = 1.0,
    this.errorMessage = '',
    this.selectedAudioIndex = 0,
    this.isPlayerVisible = true,
  });

  ContentState copyWith({
    RequestState? requestState,
    ContentDetailsEntity? contentDetails,
    int? activeTab,
    String? selectedSentenceId,
    List<String>? selectedScholars,
    bool? isComparing,
    bool? isPlaying,
    Duration? playbackProgress,
    Duration? audioDuration,
    double? audioSpeed,
    String? errorMessage,
    int? selectedAudioIndex,
    bool? isPlayerVisible,
  }) {
    return ContentState(
      requestState: requestState ?? this.requestState,
      contentDetails: contentDetails ?? this.contentDetails,
      activeTab: activeTab ?? this.activeTab,
      selectedSentenceId: selectedSentenceId == null ? this.selectedSentenceId : (selectedSentenceId.isEmpty ? null : selectedSentenceId),
      selectedScholars: selectedScholars ?? this.selectedScholars,
      isComparing: isComparing ?? this.isComparing,
      isPlaying: isPlaying ?? this.isPlaying,
      playbackProgress: playbackProgress ?? this.playbackProgress,
      audioDuration: audioDuration ?? this.audioDuration,
      audioSpeed: audioSpeed ?? this.audioSpeed,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedAudioIndex: selectedAudioIndex ?? this.selectedAudioIndex,
      isPlayerVisible: isPlayerVisible ?? this.isPlayerVisible,
    );
  }

  @override
  List<Object?> get props => [
        requestState,
        contentDetails,
        activeTab,
        selectedSentenceId,
        selectedScholars,
        isComparing,
        isPlaying,
        playbackProgress,
        audioDuration,
        audioSpeed,
        errorMessage,
        selectedAudioIndex,
        isPlayerVisible,
      ];
}
