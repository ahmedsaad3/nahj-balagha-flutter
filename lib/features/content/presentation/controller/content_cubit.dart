import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/content/data/models/content_mock_data.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  Timer? _audioTimer;

  ContentCubit() : super(const ContentState());

  void loadContentDetails(String id) {
    emit(state.copyWith(requestState: RequestState.loading));
    try {
      // Mock loading of sermon 79
      final details = ContentMockData.mockSermon79;
      final initialDuration = details.audios.isNotEmpty
          ? details.audios.first.duration
          : const Duration(minutes: 2, seconds: 46);
      emit(state.copyWith(
        contentDetails: details,
        requestState: RequestState.loaded,
        selectedAudioIndex: 0,
        audioDuration: initialDuration,
        playbackProgress: Duration.zero,
        isPlaying: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        requestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void selectReciter(int index) {
    if (state.contentDetails == null) return;
    final audios = state.contentDetails!.audios;
    if (index < 0 || index >= audios.length) return;

    _audioTimer?.cancel();
    emit(state.copyWith(
      selectedAudioIndex: index,
      isPlaying: false,
      playbackProgress: Duration.zero,
      audioDuration: audios[index].duration,
    ));
  }

  void stopAudio() {
    _audioTimer?.cancel();
    emit(state.copyWith(
      isPlaying: false,
      playbackProgress: Duration.zero,
    ));
  }

  void selectTab(int tabIndex) {
    emit(state.copyWith(activeTab: tabIndex));
  }

  void selectSentence(String? sentenceId) {
    if (state.selectedSentenceId == sentenceId) {
      emit(state.copyWith(selectedSentenceId: '')); // Clear if same
    } else {
      emit(state.copyWith(selectedSentenceId: sentenceId ?? ''));
    }
  }

  void togglePlayerVisibility() {
    emit(state.copyWith(isPlayerVisible: !state.isPlayerVisible));
  }

  void togglePlayPause() {
    final playing = !state.isPlaying;
    emit(state.copyWith(isPlaying: playing));

    _audioTimer?.cancel();

    if (playing) {
      _audioTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.playbackProgress >= state.audioDuration) {
          timer.cancel();
          emit(state.copyWith(isPlaying: false, playbackProgress: Duration.zero));
        } else {
          final increment = (1 * state.audioSpeed).toInt();
          emit(state.copyWith(
            playbackProgress: state.playbackProgress + Duration(seconds: increment),
          ));
        }
      });
    }
  }

  void seekAudio(Duration progress) {
    emit(state.copyWith(playbackProgress: progress));
  }

  void setSpeed(double speed) {
    emit(state.copyWith(audioSpeed: speed));
  }

  void toggleScholarSelection(String scholarId) {
    final updated = List<String>.from(state.selectedScholars);
    if (updated.contains(scholarId)) {
      updated.remove(scholarId);
    } else {
      updated.add(scholarId);
    }
    emit(state.copyWith(selectedScholars: updated));
  }

  void setComparisonMode(bool compare) {
    emit(state.copyWith(isComparing: compare));
    if (!compare) {
      // Clear selections if leaving comparison
      emit(state.copyWith(selectedScholars: []));
    }
  }

  void clearScholarsSelection() {
    emit(state.copyWith(selectedScholars: []));
  }

  void setSelectedScholars(List<String> scholarIds) {
    emit(state.copyWith(selectedScholars: scholarIds));
  }

  @override
  Future<void> close() {
    _audioTimer?.cancel();
    return super.close();
  }
}
