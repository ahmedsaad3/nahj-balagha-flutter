import 'package:nahj_balagha_flutter/core/services/multi_item_model.dart';

// List of languages
final List<MultiItem> itemsLanguages = [
  MultiItem(
    code: "system",
    names: {
      "ar": "لغة النظام",
      "en": "System Language",
      "fa": "زبان سیستم",
      "ur": "System Language",
      "tr": "System Language",
      "ru": "System Language",
    },
  ),
  MultiItem(
    code: "ar",
    names: {
      "ar": "العربية",
      "en": "العربية",
      "fa": "العربية",
      "ur": "العربية",
      "tr": "العربية",
      "ru": "العربية",
    },
  ),
  MultiItem(
    code: "fa",
    names: {
      "ar": "فارسى",
      "en": "فارسى",
      "fa": "فارسی",
      "ur": "فارسی",
      "tr": "فارسى",
      "ru": "فارسى",
    },
  ),
  MultiItem(
    code: "en",
    names: {
      "ar": "English",
      "en": "English",
      "fa": "English",
      "ur": "English",
      "tr": "English",
      "ru": "English",
    },
  ),
];

// List of genders
final List<MultiItem> itemsGender = [
  MultiItem(
    code: "1",
    names: {
      "ar": "ذكر",
      "en": "Male",
      "fa": "مرد",
      "ur": "مرد",
      "tr": "Erkek",
      "ru": "Мужчина",
    },
  ),
  MultiItem(
    code: "0",
    names: {
      "ar": "انثى",
      "en": "Female",
      "fa": "زن",
      "ur": "عورت",
      "tr": "Kadın",
      "ru": "Женщина",
    },
  ),
];

// List of organization types
final List<MultiItem> itemsOrganizationType = [
  MultiItem(
    code: "1",
    names: {
      "ar": "مركز",
      "en": "Center",
      "fa": "مرکز",
      "ur": "مرکز",
      "tr": "Merkez",
      "ru": "Центр",
    },
  ),
  MultiItem(
    code: "2",
    names: {
      "ar": "مؤسسة",
      "en": "Institution",
      "fa": "مؤسسه",
      "ur": "ادارہ",
      "tr": "Kurum",
      "ru": "Учреждение",
    },
  ),
  MultiItem(
    code: "3",
    names: {
      "ar": "جامعة",
      "en": "University",
      "fa": "دانشگاه",
      "ur": "یونیورسٹی",
      "tr": "Üniversite",
      "ru": "Университет",
    },
  ),
];

// List of countries
final List<MultiItem> itemsCountry = [
  MultiItem(
    code: "IQ",
    dialCode: "+964",
    flag: "🇮🇶",
    names: {
      "ar": "العراق",
      "en": "Iraq",
      "fa": "عراق",
      "ur": "عراق",
      "tr": "Irak",
      "ru": "Ирак",
    },
  ),
  MultiItem(
    code: "IR",
    dialCode: "+98",
    flag: "🇮🇷",
    names: {
      "ar": "إيران",
      "en": "Iran",
      "fa": "ایران",
      "ur": "ایران",
      "tr": "İran",
      "ru": "Иран",
    },
  ),
  MultiItem(
    code: "DZ",
    dialCode: "+213",
    flag: "🇩🇿",
    names: {
      "ar": "الجزائر",
      "en": "Algeria",
      "fa": "الجزایر",
      "ur": "الجزائر",
      "tr": "Cezayir",
      "ru": "Алжир",
    },
  ),
  MultiItem(
    code: "BH",
    dialCode: "+973",
    flag: "🇧🇭",
    names: {
      "ar": "البحرين",
      "en": "Bahrain",
      "fa": "بحرین",
      "ur": "بحرین",
      "tr": "Bahreyn",
      "ru": "Бахрейн",
    },
  ),
  MultiItem(
    code: "EG",
    dialCode: "+20",
    flag: "🇪🇬",
    names: {
      "ar": "مصر",
      "en": "Egypt",
      "fa": "مصر",
      "ur": "مصر",
      "tr": "Mısır",
      "ru": "Египет",
    },
  ),
  MultiItem(
    code: "JO",
    dialCode: "+962",
    flag: "🇯🇴",
    names: {
      "ar": "الأردن",
      "en": "Jordan",
      "fa": "اردن",
      "ur": "اردن",
      "tr": "Ürdün",
      "ru": "Иордания",
    },
  ),
  MultiItem(
    code: "AE",
    dialCode: "+971",
    flag: "🇦🇪",
    names: {
      "ar": "الإمارات العربية المتحدة",
      "en": "United Arab Emirates",
      "fa": "امارات متحده عربی",
      "ur": "متحدہ عرب امارات",
      "tr": "Birleşik Arap Emirlikleri",
      "ru": "ОАЭ",
    },
  ),
  MultiItem(
    code: "SA",
    dialCode: "+966",
    flag: "🇸🇦",
    names: {
      "ar": "السعودية",
      "en": "Saudi Arabia",
      "fa": "عربستان سعودی",
      "ur": "سعودی عرب",
      "tr": "Suudi Arabistan",
      "ru": "Саудовская Аравия",
    },
  ),
  MultiItem(
    code: "SD",
    dialCode: "+249",
    flag: "🇸🇩",
    names: {
      "ar": "السودان",
      "en": "Sudan",
      "fa": "سودان",
      "ur": "سوڈان",
      "tr": "Sudan",
      "ru": "Судан",
    },
  ),
  MultiItem(
    code: "SY",
    dialCode: "+963",
    flag: "🇸🇾",
    names: {
      "ar": "سوريا",
      "en": "Syria",
      "fa": "سوریه",
      "ur": "شام",
      "tr": "Suriye",
      "ru": "Сирия",
    },
  ),
  MultiItem(
    code: "OM",
    dialCode: "+968",
    flag: "🇴🇲",
    names: {
      "ar": "عمان",
      "en": "Oman",
      "fa": "عمان",
      "ur": "عمان",
      "tr": "Umman",
      "ru": "Оман",
    },
  ),
  MultiItem(
    code: "PS",
    dialCode: "+970",
    flag: "🇵🇸",
    names: {
      "ar": "فلسطين",
      "en": "Palestine",
      "fa": "فلسطین",
      "ur": "فلسطین",
      "tr": "Filistin",
      "ru": "Палестина",
    },
  ),
  MultiItem(
    code: "QA",
    dialCode: "+974",
    flag: "🇶🇦",
    names: {
      "ar": "قطر",
      "en": "Qatar",
      "fa": "قطر",
      "ur": "قطر",
      "tr": "Katar",
      "ru": "Катар",
    },
  ),
  MultiItem(
    code: "KW",
    dialCode: "+965",
    flag: "🇰🇼",
    names: {
      "ar": "الكويت",
      "en": "Kuwait",
      "fa": "کویت",
      "ur": "کویت",
      "tr": "Kuveyt",
      "ru": "Кувейт",
    },
  ),
  MultiItem(
    code: "LB",
    dialCode: "+961",
    flag: "🇱🇧",
    names: {
      "ar": "لبنان",
      "en": "Lebanon",
      "fa": "لبنان",
      "ur": "لبنان",
      "tr": "Lübnan",
      "ru": "Ливан",
    },
  ),
  MultiItem(
    code: "LY",
    dialCode: "+218",
    flag: "🇱🇾",
    names: {
      "ar": "ليبيا",
      "en": "Libya",
      "fa": "لیبی",
      "ur": "لیبیا",
      "tr": "Libya",
      "ru": "Ливия",
    },
  ),
  MultiItem(
    code: "MR",
    dialCode: "+222",
    flag: "🇲🇷",
    names: {
      "ar": "موريتانيا",
      "en": "Mauritania",
      "fa": "موریتانی",
      "ur": "موریتانیہ",
      "tr": "Moritanya",
      "ru": "Мавритания",
    },
  ),
  MultiItem(
    code: "MA",
    dialCode: "+212",
    flag: "🇲🇦",
    names: {
      "ar": "المغرب",
      "en": "Morocco",
      "fa": "مراکش",
      "ur": "مراکش",
      "tr": "Fas",
      "ru": "Марокко",
    },
  ),
  MultiItem(
    code: "YE",
    dialCode: "+967",
    flag: "🇾🇪",
    names: {
      "ar": "اليمن",
      "en": "Yemen",
      "fa": "یمن",
      "ur": "یمن",
      "tr": "Yemen",
      "ru": "Йемен",
    },
  ),
  MultiItem(
    code: "TN",
    dialCode: "+216",
    flag: "🇹🇳",
    names: {
      "ar": "تونس",
      "en": "Tunisia",
      "fa": "تونس",
      "ur": "تیونس",
      "tr": "Tunus",
      "ru": "Тунис",
    },
  ),
  MultiItem(
    code: "DJ",
    dialCode: "+253",
    flag: "🇩🇯",
    names: {
      "ar": "جيبوتي",
      "en": "Djibouti",
      "fa": "جیبوتی",
      "ur": "جبوتی",
      "tr": "Cibuti",
      "ru": "Джибути",
    },
  ),
  MultiItem(
    code: "SO",
    dialCode: "+252",
    flag: "🇸🇴",
    names: {
      "ar": "الصومال",
      "en": "Somalia",
      "fa": "سومالی",
      "ur": "صومالیہ",
      "tr": "Somali",
      "ru": "Сомали",
    },
  ),
  MultiItem(
    code: "KM",
    dialCode: "+269",
    flag: "🇰🇲",
    names: {
      "ar": "جزر القمر",
      "en": "Comoros",
      "fa": "کومور",
      "ur": "کوموروس",
      "tr": "Komorlar",
      "ru": "Коморы",
    },
  ),
  MultiItem(
    code: "AF",
    dialCode: "+93",
    flag: "🇦🇫",
    names: {
      "ar": "أفغانستان",
      "en": "Afghanistan",
      "fa": "افغانستان",
      "ur": "افغانستان",
      "tr": "Afganistan",
      "ru": "Афганистан",
    },
  ),
  MultiItem(
    code: "AL",
    dialCode: "+355",
    flag: "🇦🇱",
    names: {
      "ar": "ألبانيا",
      "en": "Albania",
      "fa": "آلبانی",
      "ur": "البانیا",
      "tr": "Arnavutluk",
      "ru": "Албания",
    },
  ),
  MultiItem(
    code: "AM",
    dialCode: "+374",
    flag: "🇦🇲",
    names: {
      "ar": "أرمينيا",
      "en": "Armenia",
      "fa": "ارمنستان",
      "ur": "آرمینیا",
      "tr": "Ermenistan",
      "ru": "Армения",
    },
  ),
  MultiItem(
    code: "AU",
    dialCode: "+61",
    flag: "🇦🇺",
    names: {
      "ar": "أستراليا",
      "en": "Australia",
      "fa": "استرالیا",
      "ur": "آسٹریلیا",
      "tr": "Avustralya",
      "ru": "Австралия",
    },
  ),
  MultiItem(
    code: "AT",
    dialCode: "+43",
    flag: "🇦🇹",
    names: {
      "ar": "النمسا",
      "en": "Austria",
      "fa": "اتریش",
      "ur": "آسٹریا",
      "tr": "Avusturya",
      "ru": "Австрия",
    },
  ),
  MultiItem(
    code: "AZ",
    dialCode: "+994",
    flag: "🇦🇿",
    names: {
      "ar": "أذربيجان",
      "en": "Azerbaijan",
      "fa": "آذربایجان",
      "ur": "آذربائیجان",
      "tr": "Azerbaycan",
      "ru": "Азербайджан",
    },
  ),
  MultiItem(
    code: "BR",
    dialCode: "+55",
    flag: "🇧🇷",
    names: {
      "ar": "البرازيل",
      "en": "Brazil",
      "fa": "برزیل",
      "ur": "برازیل",
      "tr": "Brezilya",
      "ru": "Бразилия",
    },
  ),
  MultiItem(
    code: "BG",
    dialCode: "+359",
    flag: "🇧🇬",
    names: {
      "ar": "بلغاريا",
      "en": "Bulgaria",
      "fa": "بلغارستان",
      "ur": "بلغاریہ",
      "tr": "Bulgaristan",
      "ru": "Болгария",
    },
  ),
  MultiItem(
    code: "CA",
    dialCode: "+1",
    flag: "🇨🇦",
    names: {
      "ar": "كندا",
      "en": "Canada",
      "fa": "کانادا",
      "ur": "کینیڈا",
      "tr": "Kanada",
      "ru": "Канада",
    },
  ),
  MultiItem(
    code: "CN",
    dialCode: "+86",
    flag: "🇨🇳",
    names: {
      "ar": "الصين",
      "en": "China",
      "fa": "چین",
      "ur": "چین",
      "tr": "Çin",
      "ru": "Китай",
    },
  ),
  MultiItem(
    code: "HR",
    dialCode: "+385",
    flag: "🇭🇷",
    names: {
      "ar": "كرواتيا",
      "en": "Croatia",
      "fa": "کرواسی",
      "ur": "کروشیا",
      "tr": "Hırvatistan",
      "ru": "Хорватия",
    },
  ),
  MultiItem(
    code: "CY",
    dialCode: "+357",
    flag: "🇨🇾",
    names: {
      "ar": "قبرص",
      "en": "Cyprus",
      "fa": "قبرس",
      "ur": "قبرص",
      "tr": "Kıbrıs",
      "ru": "Кипр",
    },
  ),
  MultiItem(
    code: "CZ",
    dialCode: "+420",
    flag: "🇨🇿",
    names: {
      "ar": "التشيك",
      "en": "Czech Republic",
      "fa": "جمهوری چک",
      "ur": "چیک ریپبلک",
      "tr": "Çek Cumhuriyeti",
      "ru": "Чехия",
    },
  ),
  MultiItem(
    code: "DK",
    dialCode: "+45",
    flag: "🇩🇰",
    names: {
      "ar": "الدنمارك",
      "en": "Denmark",
      "fa": "دانمارک",
      "ur": "ڈنمارک",
      "tr": "Danimarka",
      "ru": "Дания",
    },
  ),
  MultiItem(
    code: "EE",
    dialCode: "+372",
    flag: "🇪🇪",
    names: {
      "ar": "إستونيا",
      "en": "Estonia",
      "fa": "استونی",
      "ur": "ایسٹونیا",
      "tr": "Estonya",
      "ru": "Эстония",
    },
  ),
  MultiItem(
    code: "FI",
    dialCode: "+358",
    flag: "🇫🇮",
    names: {
      "ar": "فنلندا",
      "en": "Finland",
      "fa": "فنلاند",
      "ur": "فن لینڈ",
      "tr": "Finlandiya",
      "ru": "Финляндия",
    },
  ),
  MultiItem(
    code: "FR",
    dialCode: "+33",
    flag: "🇫🇷",
    names: {
      "ar": "فرنسا",
      "en": "France",
      "fa": "فرانسه",
      "ur": "فرانس",
      "tr": "Fransa",
      "ru": "Франция",
    },
  ),
  MultiItem(
    code: "GE",
    dialCode: "+995",
    flag: "🇬🇪",
    names: {
      "ar": "جورجيا",
      "en": "Georgia",
      "fa": "گرجستان",
      "ur": "جارجیا",
      "tr": "Gürcistan",
      "ru": "Грузия",
    },
  ),
  MultiItem(
    code: "DE",
    dialCode: "+49",
    flag: "🇩🇪",
    names: {
      "ar": "ألمانيا",
      "en": "Germany",
      "fa": "آلمان",
      "ur": "جرمنی",
      "tr": "Almanya",
      "ru": "Германия",
    },
  ),
  MultiItem(
    code: "GR",
    dialCode: "+30",
    flag: "🇬🇷",
    names: {
      "ar": "اليونان",
      "en": "Greece",
      "fa": "یونان",
      "ur": "یونان",
      "tr": "Yunanistan",
      "ru": "Греция",
    },
  ),
  MultiItem(
    code: "HU",
    dialCode: "+36",
    flag: "🇭🇺",
    names: {
      "ar": "المجر",
      "en": "Hungary",
      "fa": "مجارستان",
      "ur": "ہنگری",
      "tr": "Macaristan",
      "ru": "Венгрия",
    },
  ),
  MultiItem(
    code: "IS",
    dialCode: "+354",
    flag: "🇮🇸",
    names: {
      "ar": "أيسلندا",
      "en": "Iceland",
      "fa": "ایسلند",
      "ur": "آئس لینڈ",
      "tr": "İzlanda",
      "ru": "Исландия",
    },
  ),
  MultiItem(
    code: "IN",
    dialCode: "+91",
    flag: "🇮🇳",
    names: {
      "ar": "الهند",
      "en": "India",
      "fa": "هند",
      "ur": "بھارت",
      "tr": "Hindistan",
      "ru": "Индия",
    },
  ),
  MultiItem(
    code: "ID",
    dialCode: "+62",
    flag: "🇮🇩",
    names: {
      "ar": "إندونيسيا",
      "en": "Indonesia",
      "fa": "اندونزی",
      "ur": "انڈونیشیا",
      "tr": "Endonezya",
      "ru": "Индонезия",
    },
  ),
  MultiItem(
    code: "IT",
    dialCode: "+39",
    flag: "🇮🇹",
    names: {
      "ar": "إيطاليا",
      "en": "Italy",
      "fa": "ایتالیا",
      "ur": "اٹلی",
      "tr": "İtalya",
      "ru": "Италия",
    },
  ),
  MultiItem(
    code: "JP",
    dialCode: "+81",
    flag: "🇯🇵",
    names: {
      "ar": "اليابان",
      "en": "Japan",
      "fa": "ژاپن",
      "ur": "جاپان",
      "tr": "Japonya",
      "ru": "Япония",
    },
  ),
  MultiItem(
    code: "KZ",
    dialCode: "+7",
    flag: "🇰🇿",
    names: {
      "ar": "كازاخستان",
      "en": "Kazakhstan",
      "fa": "قزاقستان",
      "ur": "قازقستان",
      "tr": "Kazakistan",
      "ru": "Казахстан",
    },
  ),
  MultiItem(
    code: "KE",
    dialCode: "+254",
    flag: "🇰🇪",
    names: {
      "ar": "كينيا",
      "en": "Kenya",
      "fa": "کنیا",
      "ur": "کینیا",
      "tr": "Kenya",
      "ru": "Кения",
    },
  ),
  MultiItem(
    code: "KR",
    dialCode: "+82",
    flag: "🇰🇷",
    names: {
      "ar": "كوريا الجنوبية",
      "en": "South Korea",
      "fa": "کره جنوبی",
      "ur": "جنوبی کوریا",
      "tr": "Güney Kore",
      "ru": "Южная Корея",
    },
  ),
  MultiItem(
    code: "LU",
    dialCode: "+352",
    flag: "🇱🇺",
    names: {
      "ar": "لوكسمبورغ",
      "en": "Luxembourg",
      "fa": "لوکزامبورگ",
      "ur": "لکسمبرگ",
      "tr": "Lüksemburg",
      "ru": "Люксембург",
    },
  ),
  MultiItem(
    code: "MY",
    dialCode: "+60",
    flag: "🇲🇾",
    names: {
      "ar": "ماليزيا",
      "en": "Malaysia",
      "fa": "مالزی",
      "ur": "ملیشیا",
      "tr": "Malezya",
      "ru": "Малайзия",
    },
  ),
  MultiItem(
    code: "MW",
    dialCode: "+265",
    flag: "🇲🇼",
    names: {
      "ar": "مالاوي",
      "en": "Malawi",
      "fa": "مالاوی",
      "ur": "ملاوی",
      "tr": "Malavi",
      "ru": "Малави",
    },
  ),
  MultiItem(
    code: "MX",
    dialCode: "+52",
    flag: "🇲🇽",
    names: {
      "ar": "المكسيك",
      "en": "Mexico",
      "fa": "مکزیک",
      "ur": "میکسیکو",
      "tr": "Meksika",
      "ru": "Мексика",
    },
  ),
  MultiItem(
    code: "MD",
    dialCode: "+373",
    flag: "🇲🇩",
    names: {
      "ar": "مولدوفا",
      "en": "Moldova",
      "fa": "مولداوی",
      "ur": "مالدووا",
      "tr": "Moldova",
      "ru": "Молдова",
    },
  ),
  MultiItem(
    code: "MN",
    dialCode: "+976",
    flag: "🇲🇳",
    names: {
      "ar": "منغوليا",
      "en": "Mongolia",
      "fa": "مغولستان",
      "ur": "منگولیا",
      "tr": "Moğolistan",
      "ru": "Монголия",
    },
  ),
  MultiItem(
    code: "NO",
    dialCode: "+47",
    flag: "🇳🇴",
    names: {
      "ar": "النرويج",
      "en": "Norway",
      "fa": "نروژ",
      "ur": "ناروے",
      "tr": "Norveç",
      "ru": "Норвегия",
    },
  ),
  MultiItem(
    code: "PK",
    dialCode: "+92",
    flag: "🇵🇰",
    names: {
      "ar": "باكستان",
      "en": "Pakistan",
      "fa": "پاکستان",
      "ur": "پاکستان",
      "tr": "Pakistan",
      "ru": "Пакистан",
    },
  ),
  MultiItem(
    code: "PL",
    dialCode: "+48",
    flag: "🇵🇱",
    names: {
      "ar": "بولندا",
      "en": "Poland",
      "fa": "لهستان",
      "ur": "پولینڈ",
      "tr": "Polonya",
      "ru": "Польша",
    },
  ),
  MultiItem(
    code: "PT",
    dialCode: "+351",
    flag: "🇵🇹",
    names: {
      "ar": "البرتغال",
      "en": "Portugal",
      "fa": "پرتغال",
      "ur": "پرتگال",
      "tr": "Portekiz",
      "ru": "Португалия",
    },
  ),
  MultiItem(
    code: "RO",
    dialCode: "+40",
    flag: "🇷🇴",
    names: {
      "ar": "رومانيا",
      "en": "Romania",
      "fa": "رومانی",
      "ur": "رومانیہ",
      "tr": "Romanya",
      "ru": "Румыния",
    },
  ),
  MultiItem(
    code: "RU",
    dialCode: "+7",
    flag: "🇷🇺",
    names: {
      "ar": "روسيا",
      "en": "Russia",
      "fa": "روسیه",
      "ur": "روس",
      "tr": "Rusya",
      "ru": "Россия",
    },
  ),
  MultiItem(
    code: "SG",
    dialCode: "+65",
    flag: "🇸🇬",
    names: {
      "ar": "سنغافورة",
      "en": "Singapore",
      "fa": "سنگاپور",
      "ur": "سنگاپور",
      "tr": "Singapur",
      "ru": "Сингапур",
    },
  ),
  MultiItem(
    code: "SK",
    dialCode: "+421",
    flag: "🇸🇰",
    names: {
      "ar": "سلوفاكيا",
      "en": "Slovakia",
      "fa": "اسلواکی",
      "ur": "سلوواکیہ",
      "tr": "Slovakya",
      "ru": "Словакия",
    },
  ),
  MultiItem(
    code: "SI",
    dialCode: "+386",
    flag: "🇸🇮",
    names: {
      "ar": "سلوفينيا",
      "en": "Slovenia",
      "fa": "اسلونی",
      "ur": "سلووینیا",
      "tr": "Slovenya",
      "ru": "Словения",
    },
  ),
  MultiItem(
    code: "ZA",
    dialCode: "+27",
    flag: "🇿🇦",
    names: {
      "ar": "جنوب أفريقيا",
      "en": "South Africa",
      "fa": "آفریقای جنوبی",
      "ur": "جنوبی افریقہ",
      "tr": "Güney Afrika",
      "ru": "ЮАР",
    },
  ),
  MultiItem(
    code: "ES",
    dialCode: "+34",
    flag: "🇪🇸",
    names: {
      "ar": "إسبانيا",
      "en": "Spain",
      "fa": "اسپانیا",
      "ur": "سپین",
      "tr": "İspanya",
      "ru": "Испания",
    },
  ),
  MultiItem(
    code: "SE",
    dialCode: "+46",
    flag: "🇸🇪",
    names: {
      "ar": "السويد",
      "en": "Sweden",
      "fa": "سوئد",
      "ur": "سویڈن",
      "tr": "İsveç",
      "ru": "Швеция",
    },
  ),
  MultiItem(
    code: "CH",
    dialCode: "+41",
    flag: "🇨🇭",
    names: {
      "ar": "سويسرا",
      "en": "Switzerland",
      "fa": "سوئیس",
      "ur": "سوئٹزرلینڈ",
      "tr": "İsviçre",
      "ru": "Швейцария",
    },
  ),
  MultiItem(
    code: "TH",
    dialCode: "+66",
    flag: "🇹🇭",
    names: {
      "ar": "تايلاند",
      "en": "Thailand",
      "fa": "تایلند",
      "ur": "تھائی لینڈ",
      "tr": "Tayland",
      "ru": "Таиланд",
    },
  ),
  MultiItem(
    code: "TR",
    dialCode: "+90",
    flag: "🇹🇷",
    names: {
      "ar": "تركيا",
      "en": "Turkey",
      "fa": "ترکیه",
      "ur": "ترکی",
      "tr": "Türkiye",
      "ru": "Турция",
    },
  ),
  MultiItem(
    code: "UA",
    dialCode: "+380",
    flag: "🇺🇦",
    names: {
      "ar": "أوكرانيا",
      "en": "Ukraine",
      "fa": "اوکراین",
      "ur": "یوکرین",
      "tr": "Ukrayna",
      "ru": "Украина",
    },
  ),
  MultiItem(
    code: "GB",
    dialCode: "+44",
    flag: "🇬🇧",
    names: {
      "ar": "المملكة المتحدة",
      "en": "United Kingdom",
      "fa": "بریتانیا",
      "ur": "برطانیہ",
      "tr": "Birleşik Krallık",
      "ru": "Великобритания",
    },
  ),
  MultiItem(
    code: "US",
    dialCode: "+1",
    flag: "🇺🇸",
    names: {
      "ar": "الولايات المتحدة",
      "en": "United States",
      "fa": "ایالات متحده",
      "ur": "امریکا",
      "tr": "Amerika Birleşik Devletleri",
      "ru": "США",
    },
  ),
  MultiItem(
    code: "VE",
    dialCode: "+58",
    flag: "🇻🇪",
    names: {
      "ar": "فنزويلا",
      "en": "Venezuela",
      "fa": "ونزوئلا",
      "ur": "وینزویلا",
      "tr": "Venezuela",
      "ru": "Венесуэла",
    },
  ),
  MultiItem(
    code: "VN",
    dialCode: "+84",
    flag: "🇻🇳",
    names: {
      "ar": "فيتنام",
      "en": "Vietnam",
      "fa": "ویتنام",
      "ur": "ویتنام",
      "tr": "Vietnam",
      "ru": "Вьетнам",
    },
  ),
  MultiItem(
    code: "ZM",
    dialCode: "+260",
    flag: "🇿🇲",
    names: {
      "ar": "زامبيا",
      "en": "Zambia",
      "fa": "زامبیا",
      "ur": "زیمبیا",
      "tr": "Zambiya",
      "ru": "Замбия",
    },
  ),
  MultiItem(
    code: "ZW",
    dialCode: "+263",
    flag: "🇿🇼",
    names: {
      "ar": "زيمبابوي",
      "en": "Zimbabwe",
      "fa": "زیمبابوه",
      "ur": "زمبابوے",
      "tr": "Zimbabve",
      "ru": "Зимбабве",
    },
  ),
  MultiItem(
    code: "NG",
    dialCode: "+234",
    flag: "🇳🇬",
    names: {
      "ar": "نيجيريا",
      "en": "Nigeria",
      "fa": "نیجریه",
      "ur": "نائیجیریا",
      "tr": "Nijerya",
      "ru": "Нигерия",
    },
  ),
  MultiItem(
    code: "TZ",
    dialCode: "+255",
    flag: "🇹🇿",
    names: {
      "ar": "تنزانيا",
      "en": "Tanzania",
      "fa": "تانزانیا",
      "ur": "تنزانیہ",
      "tr": "Tanzanya",
      "ru": "Танзания",
    },
  ),
  MultiItem(
    code: "UG",
    dialCode: "+256",
    flag: "🇺🇬",
    names: {
      "ar": "أوغندا",
      "en": "Uganda",
      "fa": "اوگاندا",
      "ur": "یوگنڈا",
      "tr": "Uganda",
      "ru": "Уганда",
    },
  ),
  MultiItem(
    code: "MZ",
    dialCode: "+258",
    flag: "🇲🇿",
    names: {
      "ar": "موزمبيق",
      "en": "Mozambique",
      "fa": "موزامبیک",
      "ur": "موزمبیق",
      "tr": "Mozambik",
      "ru": "Мозамбик",
    },
  ),
  MultiItem(
    code: "BI",
    dialCode: "+257",
    flag: "🇧🇮",
    names: {
      "ar": "بوروندي",
      "en": "Burundi",
      "fa": "بوروندی",
      "ur": "برونڈی",
      "tr": "Burundi",
      "ru": "Бурунди",
    },
  ),
  MultiItem(
    code: "RW",
    dialCode: "+250",
    flag: "🇷🇼",
    names: {
      "ar": "رواندا",
      "en": "Rwanda",
      "fa": "رواندا",
      "ur": "روانڈا",
      "tr": "Ruanda",
      "ru": "Руанда",
    },
  ),
];

// This code defines a map of phone validation patterns for various countries, where the keys are the country dial codes and the values are regular expressions that validate phone numbers for those countries.
final Map<String, RegExp> phoneValidationPatterns = {
  '+964': RegExp(r'^\d{10}$'), // العراق
  '+98': RegExp(r'^\d{10}$'), // إيران
  '+213': RegExp(r'^\d{9}$'), // الجزائر
  '+973': RegExp(r'^\d{8}$'), // البحرين
  '+20': RegExp(r'^\d{10}$'), // مصر
  '+962': RegExp(r'^\d{9}$'), // الأردن
  '+971': RegExp(r'^\d{9}$'), // الإمارات
  '+966': RegExp(r'^\d{9}$'), // السعودية
  '+249': RegExp(r'^\d{9}$'), // السودان
  '+963': RegExp(r'^\d{9}$'), // سوريا
  '+968': RegExp(r'^\d{8}$'), // عمان
  '+970': RegExp(r'^\d{9}$'), // فلسطين
  '+974': RegExp(r'^\d{8}$'), // قطر
  '+965': RegExp(r'^\d{8}$'), // الكويت
  '+961': RegExp(r'^\d{8}$'), // لبنان
  '+218': RegExp(r'^\d{9}$'), // ليبيا
  '+222': RegExp(r'^\d{8}$'), // موريتانيا
  '+212': RegExp(r'^\d{9}$'), // المغرب
  '+967': RegExp(r'^\d{9}$'), // اليمن
  '+216': RegExp(r'^\d{8}$'), // تونس
  '+253': RegExp(r'^\d{8}$'), // جيبوتي
  '+252': RegExp(r'^\d{9}$'), // الصومال
  '+269': RegExp(r'^\d{7}$'), // جزر القمر
  '+93': RegExp(r'^\d{9}$'), // أفغانستان
  '+355': RegExp(r'^\d{9}$'), // ألبانيا
  '+374': RegExp(r'^\d{8}$'), // أرمينيا
  '+61': RegExp(r'^\d{9}$'), // أستراليا
  '+43': RegExp(r'^\d{10}$'), // النمسا
  '+994': RegExp(r'^\d{9}$'), // أذربيجان
  '+55': RegExp(r'^\d{10,11}$'), // البرازيل
  '+359': RegExp(r'^\d{9}$'), // بلغاريا
  '+1': RegExp(r'^\d{10}$'), // كندا / الولايات المتحدة
  '+86': RegExp(r'^\d{11}$'), // الصين
  '+385': RegExp(r'^\d{9}$'), // كرواتيا
  '+357': RegExp(r'^\d{8}$'), // قبرص
  '+420': RegExp(r'^\d{9}$'), // التشيك
  '+45': RegExp(r'^\d{8}$'), // الدنمارك
  '+372': RegExp(r'^\d{7,8}$'), // إستونيا
  '+358': RegExp(r'^\d{9}$'), // فنلندا
  '+33': RegExp(r'^\d{9}$'), // فرنسا
  '+995': RegExp(r'^\d{9}$'), // جورجيا
  '+49': RegExp(r'^\d{10,11}$'), // ألمانيا
  '+30': RegExp(r'^\d{10}$'), // اليونان
  '+36': RegExp(r'^\d{9}$'), // المجر
  '+354': RegExp(r'^\d{7}$'), // أيسلندا
  '+91': RegExp(r'^\d{10}$'), // الهند
  '+62': RegExp(r'^\d{10,12}$'), // إندونيسيا
  '+39': RegExp(r'^\d{9,10}$'), // إيطاليا
  '+81': RegExp(r'^\d{10}$'), // اليابان
  '+7': RegExp(r'^\d{10}$'), // كازاخستان / روسيا
  '+254': RegExp(r'^\d{9}$'), // كينيا
  '+82': RegExp(r'^\d{9,10}$'), // كوريا الجنوبية
  '+352': RegExp(r'^\d{9}$'), // لوكسمبورغ
  '+60': RegExp(r'^\d{9,10}$'), // ماليزيا
  '+265': RegExp(r'^\d{9}$'), // مالاوي
  '+52': RegExp(r'^\d{10}$'), // المكسيك
  '+373': RegExp(r'^\d{8}$'), // مولدوفا
  '+976': RegExp(r'^\d{8}$'), // منغوليا
  '+47': RegExp(r'^\d{8}$'), // النرويج
  '+92': RegExp(r'^\d{10}$'), // باكستان
  '+48': RegExp(r'^\d{9}$'), // بولندا
  '+351': RegExp(r'^\d{9}$'), // البرتغال
  '+40': RegExp(r'^\d{9}$'), // رومانيا
  '+65': RegExp(r'^\d{8}$'), // سنغافورة
  '+421': RegExp(r'^\d{9}$'), // سلوفاكيا
  '+386': RegExp(r'^\d{8}$'), // سلوفينيا
  '+27': RegExp(r'^\d{9}$'), // جنوب أفريقيا
  '+34': RegExp(r'^\d{9}$'), // إسبانيا
  '+46': RegExp(r'^\d{9}$'), // السويد
  '+41': RegExp(r'^\d{9}$'), // سويسرا
  '+66': RegExp(r'^\d{9}$'), // تايلاند
  '+90': RegExp(r'^\d{10}$'), // تركيا
  '+380': RegExp(r'^\d{9}$'), // أوكرانيا
  '+44': RegExp(r'^\d{10}$'), // المملكة المتحدة
  '+58': RegExp(r'^\d{10}$'), // فنزويلا
  '+84': RegExp(r'^\d{9,10}$'), // فيتنام
  '+260': RegExp(r'^\d{9}$'), // زامبيا
  '+263': RegExp(r'^\d{9}$'), // زيمبابوي
  '+234': RegExp(r'^\d{10}$'), // نيجيريا
  '+255': RegExp(r'^\d{9}$'), // تنزانيا
  '+256': RegExp(r'^\d{9}$'), // أوغندا
  '+258': RegExp(r'^\d{8,9}$'), // موزمبيق
  '+257': RegExp(r'^\d{8}$'), // بوروندي
  '+250': RegExp(r'^\d{9}$'), // رواندا
};
