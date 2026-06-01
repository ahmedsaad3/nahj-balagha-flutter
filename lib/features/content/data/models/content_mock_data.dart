import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/grammar_model_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/reciter_audio_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/reference_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/scholar_explanation_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/sermon_sentence_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/vocabulary_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/word_grammar_Entity.dart';

class ContentMockData {
  static final ContentDetailsEntity mockSermon79 = ContentDetailsEntity(
    id: 'sermon_79',
    title: 'الخطبة 79',
    category: 'الخطبة',
    description:
        'ومن كلام له (عليه السلام) بعد فراغه من حرب الجمل، في ذم النساء [1]:',
    mainText:
        'مَعَاشِرَ النَّاسِ، إِنَّ النِّسَاءَ نَوَاقِصُ الْإِيمَانِ، نَوَاقِصُ الْحُظُوظِ، نَوَاقِصُ الْعُقُولِ. فَأَمَّا نُقْصَانُ إِيمَانِهِنَّ فَفُعُودُهُنَّ عَنِ الصَّلَاةِ وَالصِّيَامِ فِي أَيَّامِ حَيْضِهِنَّ. وَأَمَّا نُقْصَانُ عُقُولِهِنَّ فَشَهَادَةُ امْرَأَتَيْنِ مِنْهُنَّ كَشَهَادَةِ الرَّجُلِ الْوَاحِدِ. وَأَمَّا نُقْصَانُ حُظُوظِهِنَّ فَمَوَارِيثُهُنَّ عَلَى النِّصْفِ مِنْ مَوَارِيثِ الرِّجَالِ. فَاتَّقُوا شِرَارَ النِّسَاءِ، وَكُونُوا مِنْ خِيَارِهِنَّ عَلَى حَذَرٍ. وَلَا تُطِيعُوهُنَّ فِي الْمَعْرُوفِ حَتَّى لَا يَطْمَعْنَ فِي الْمُنْكَرِ.',
    audioPath: 'assets/audio/khutba_79.mp3',
    audios: const [
      ReciterAudioEntity(
        reciterName: 'الشيخ عبد الحميد المهاجر',
        audioPath: 'assets/audio/khutba_79_muhajir.mp3',
        duration: Duration(minutes: 2, seconds: 46),
      ),
      ReciterAudioEntity(
        reciterName: 'الشيخ ميثم التمار',
        audioPath: 'assets/audio/khutba_79_tamar.mp3',
        duration: Duration(minutes: 3, seconds: 15),
      ),
    ],
    sentences: const [
      SermonSentenceEntity(
        id: 's1',
        text:
            'مَعَاشِرَ النَّاسِ، إِنَّ النِّسَاءَ نَوَاقِصُ الْإِيمَانِ، نَوَاقِصُ الْحُظُوظِ، نَوَاقِصُ الْعُقُولِ.',
        audioStart: Duration(seconds: 0),
        audioEnd: Duration(seconds: 15),
      ),
      SermonSentenceEntity(
        id: 's2',
        text:
            'فَأَمَّا نُقْصَانُ إِيمَانِهِنَّ فَفُعُودُهُنَّ عَنِ الصَّلَاةِ وَالصِّيَامِ فِي أَيَّامِ حَيْضِهِنَّ.',
        audioStart: Duration(seconds: 15),
        audioEnd: Duration(seconds: 35),
      ),
      SermonSentenceEntity(
        id: 's3',
        text:
            'وَأَمَّا نُقْصَانُ عُقُولِهِنَّ فَشَهَادَةُ امْرَأَتَيْنِ مِنْهُنَّ كَشَهَادَةِ الرَّجُلِ الْوَاحِدِ.',
        audioStart: Duration(seconds: 35),
        audioEnd: Duration(seconds: 55),
      ),
      SermonSentenceEntity(
        id: 's4',
        text:
            'وَأَمَّا نُقْصَانُ حُظُوظِهِنَّ فَمَوَارِيثُهُنَّ عَلَى النِّصْفِ مِنْ مَوَارِيثِ الرِّجَالِ.',
        audioStart: Duration(seconds: 55),
        audioEnd: Duration(seconds: 75),
      ),
      SermonSentenceEntity(
        id: 's5',
        text:
            'فَاتَّقُوا شِرَارَ النِّسَاءِ، وَكُونُوا مِنْ خِيَارِهِنَّ عَلَى حَذَرٍ.',
        audioStart: Duration(seconds: 75),
        audioEnd: Duration(seconds: 95),
      ),
      SermonSentenceEntity(
        id: 's6',
        text:
            'وَلَا تُطِيعُوهُنَّ فِي الْمَعْرُوفِ حَتَّى لَا يَطْمَعْنَ فِي الْمُنْكَرِ.',
        audioStart: Duration(seconds: 95),
        audioEnd: Duration(seconds: 115),
      ),
    ],
    explanations: const [
      ScholarExplanationEntity(
        id: 'exp_hadid',
        scholarName: 'ابن أبي الحديد',
        excerpt:
            'يرى ابن أبي الحديد أن هذا الكلام يندرج تحت التحذير الاجتماعي العام ومحاسبة الأفعال لا الأجناس ...',
        fullText:
            'يرى ابن أبي الحديد في شرحه لنهج البلاغة أن هذا الكلام خرج مخرج التذكير والوعظ في ظروف تاريخية معينة تلت حرب الجمل، مشيرًا إلى الجوانب النفسية والاجتماعية التي سادت المجتمع آنذاك، مؤكدًا أن الإسلام وضع ضوابط للمحافظة على أركان الأسرة وتماسكها.',
      ),
      ScholarExplanationEntity(
        id: 'exp_mughniya',
        scholarName: 'الشيخ محمد جواد مغنية',
        excerpt:
            'يوضح الشيخ مغنية في ظلال نهج البلاغة أن الأحكام الإرشادية هنا تتصل بظواهر وحالات خاصة ...',
        fullText:
            'يوضح الشيخ مغنية في شرحه "في ظلال نهج البلاغة" أن الخطاب النبوي والعلوي يرمي لتهذيب السلوكيات، وأن التمايز في بعض الفروض مثل الميراث أو الشهادة أو العبادات يعكس تكاملاً وظيفياً وتقسيماً للمسؤوليات بين الجنسين في الشريعة الإسلامية ولا ينتقص من الكرامة الإنسانية أو الإيمان القلبي.',
      ),
      ScholarExplanationEntity(
        id: 'exp_majlesi',
        scholarName: 'العلامة المجلسي',
        excerpt:
            'يفسر العلامة المجلسي في بحار الأنوار التفاوت في الواجبات التكليفية والمسؤوليات الشرعية ...',
        fullText:
            'يفسر العلامة المجلسي في شروحاته أن النقصان المذكور في الحديث يراد به النقص التكليفي أو الوظيفي (كفترة الحيض التي تسقط فيها الصلاة)، وليس ذمًا لذات المرأة، بل هو توجيه للرجال والنساء للالتزام بحدود التكليف ومراعاة الفطرة والواجبات المتبادلة.',
      ),
    ],
    grammars: const [
      GrammarEntity(
        id: 'g1',
        sentence:
            'مَعَاشِرَ النَّاسِ، إِنَّ النِّسَاءَ نَوَاقِصُ الْإِيمَانِ، نَوَاقِصُ الْحُظُوظِ، نَوَاقِصُ الْعُقُولِ.',
        analysis: [
          WordGrammarEntity(
            word: 'معاشر',
            analysisText:
                'منادى بحرف نداء محذوف (تقديره: يا معاشر)، منصوب وعلامة نصبه الفتحة الظاهرة على آخره، وهو مضاف.',
          ),
          WordGrammarEntity(
            word: 'الناس',
            analysisText: 'مضاف إليه مجرور وعلامة جره الكسرة الظاهرة تحت آخره.',
          ),
          WordGrammarEntity(
            word: 'النساء',
            analysisText: 'اسم (إن) منصوب وعلامة نصبه الفتحة الظاهرة على آخره.',
          ),
          WordGrammarEntity(
            word: 'نواقص (الأولى)',
            analysisText:
                'خبر (إن) مرفوع وعلامة رفعه الضمة الظاهرة على آخره، وهو مضاف.',
          ),
          WordGrammarEntity(
            word: 'الايمان',
            analysisText: 'مضاف إليه مجرور وعلامة جره الكسرة الظاهرة تحت آخره.',
          ),
          WordGrammarEntity(
            word: 'نواقص (الثانية)',
            analysisText:
                'خبر ثان لـ (إن) مرفوع وعلامة رفعه الضمة الظاهرة على آخره، وهو مضاف.',
          ),
          WordGrammarEntity(
            word: 'الحظوظ',
            analysisText: 'مضاف إليه مجرور وعلامة جره الكسرة الظاهرة.',
          ),
        ],
      ),
      GrammarEntity(
        id: 'g2',
        sentence:
            'فَأَمَّا نُقْصَانُ إِيمَانِهِنَّ فَفُعُودُهُنَّ عَنِ الصَّلَاةِ وَالصِّيَامِ فِي أَيَّامِ حَيْضِهِنَّ.',
        analysis: [
          WordGrammarEntity(
            word: 'فأما',
            analysisText: 'الفاء استئنافية، أما حرف شرط وتفصيل.',
          ),
          WordGrammarEntity(
            word: 'نقصان',
            analysisText:
                'مبتدأ مرفوع وعلامة رفعه الضمة الظاهرة على آخره وهو مضاف.',
          ),
          WordGrammarEntity(
            word: 'إيمانهن',
            analysisText:
                'إيمان مضاف إليه مجرور، والهاء ضمير متصل مبني في محل جر بالإضافة، والنون علامة جمع الإناث.',
          ),
          WordGrammarEntity(
            word: 'فقعودهن',
            analysisText:
                'الفاء واقعة في جواب أما، قعود خبر المبتدأ مرفوع وهو مضاف، وهن ضمير في محل جر مضاف إليه.',
          ),
        ],
      ),
    ],
    vocabularies: const [
      VocabularyEntity(
        id: 'v1',
        word: 'مَعَاشِرَ',
        definition:
            'جمع معشر، وهم الجماعة أو الطائفة من الناس يجمعهم أمر واحد.',
      ),
      VocabularyEntity(
        id: 'v2',
        word: 'نَوَاقِصُ',
        definition: 'جمع ناقصة، وتعني عدم الاكتمال في جانب أو مقدار معيّن.',
      ),
      VocabularyEntity(
        id: 'v3',
        word: 'الْحُظُوظُ',
        definition:
            'جمع حظ، وهو النصيب أو القسمة، والمقصود هنا النصيب المالي من الميراث.',
      ),
      VocabularyEntity(
        id: 'v4',
        word: 'فَفُعُودُهُنَّ',
        definition:
            'توقفهن أو امتناعهن، والمقصود هنا التوقف المؤقت عن أداء العبادات المفروضة.',
      ),
      VocabularyEntity(
        id: 'v5',
        word: 'شِرَارَ',
        definition:
            'جمع "شرّ" أو "شِرِّيرة"، والمقصود بهن أسوأ النساء أو اللواتي يملن إلى الفساد والأذى.',
      ),
      VocabularyEntity(
        id: 'v6',
        word: 'خِيَارِهِنَّ',
        definition: 'جمع "خَيِّرة"، وهنّ أفضل النساء، الصالحات والفاضلات.',
      ),
      VocabularyEntity(
        id: 'v7',
        word: 'حَذَرٍ',
        definition: 'الاحْتراس، والانتباه، واليقظة.',
      ),
      VocabularyEntity(
        id: 'v8',
        word: 'الْمَعْرُوفِ',
        definition: 'كل عمل حسَن أو أمر طيِّب يقرّه العقل والدين.',
      ),
      VocabularyEntity(
        id: 'v9',
        word: 'يَطْمَعْنَ',
        definition:
            'من الطمع وهو الرغبة الشديدة، والمقصود هنا: يتجرّأن ويطلبن المزيد بحيث يتدخلن في ما لا يصح.',
      ),
      VocabularyEntity(
        id: 'v10',
        word: 'الْمُنْكَرِ',
        definition: 'كل عمل قبيح أو أمر سيء يرفضه العقل والدين والمجتمع.',
      ),
    ],
    references: const [
      ReferenceEntity(
        id: 'ref_1',
        source: 'كتاب المسترشد في إمامة أمير المؤمنين',
        details:
            'لمحمد بن جرير الطبري الإمامي (من علماء القرن الرابع الهجري قبل الشريف الرضي). وقد رواها بسند متصل عن الشعبي، عن شريح بن هانئ قال: "خطب علي بن أبي طالب (عليه السلام) بعدما افتتحت البصرة" (وذكر الخطبة).',
      ),
      ReferenceEntity(
        id: 'ref_2',
        source: 'كتاب خصائص الأئمة',
        details:
            'وهو كتاب للشريف الرضي نفسه (جامع نهج البلاغة)، وقد أورد في هذا الكتاب (ص 100) مقاطع من الخطبة بسند متصل.',
      ),
      ReferenceEntity(
        id: 'ref_3',
        source: 'كتاب الاختصاص',
        details: 'للشيخ المفيد (أستاذ الشريف الرضي).',
      ),
    ],
  );
}
