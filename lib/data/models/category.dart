import 'package:flutter/material.dart';

class Category {
  final String nameEn;
  final String nameAr;
  final String id;
  final String imageDark;
  final String imageLight;
  final IconData icon;

  const Category({
    required this.nameEn,
    required this.nameAr,
    required this.id,
    required this.imageDark,
    required this.imageLight,
    required this.icon,
  });
}

Map<String, Category> allCategories = {
  'sport': const Category(
    id: 'sport',
    nameEn: 'Sport',
    nameAr: 'رياضة',
    imageDark: 'assets/imageDark/Sport.png',
    imageLight: 'assets/imageLight/Sport.png',
    icon: Icons.sports_soccer,
  ),

  'book_club': const Category(
    id: 'book_club',
    nameEn: 'Book Club',
    nameAr: 'نادي الكتاب',
    imageDark: 'assets/imageDark/Book Club.png',
    imageLight: 'assets/imageLight/Book Club.png',
    icon: Icons.menu_book,
  ),

  'birthday': const Category(
    id: 'birthday',
    nameEn: 'Birthday',
    nameAr: 'عيد ميلاد',
    imageDark: 'assets/imageDark/Birthday.png',
    imageLight: 'assets/imageLight/Birthday.png',
    icon: Icons.cake,
  ),

  'meeting': const Category(
    id: 'meeting',
    nameEn: 'Meeting',
    nameAr: 'اجتماع',
    imageDark: 'assets/imageDark/Meeting.png',
    imageLight: 'assets/imageLight/Meeting.png',
    icon: Icons.meeting_room,
  ),

  'exhibition': const Category(
    id: 'exhibition',
    nameEn: 'Exhibition',
    nameAr: 'معرض',
    imageDark: 'assets/imageDark/Exhibition.png',
    imageLight: 'assets/imageLight/Exhibition.png',
    icon: Icons.museum,
  ),
};
