import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/core/utils/dialog_utils.dart';
import 'package:evently_app/data/firebase/firebase_events_database.dart';
import 'package:evently_app/data/models/category.dart';
import 'package:evently_app/data/models/event.dart';
import 'package:evently_app/widgets/custom_filled_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventEdit extends StatefulWidget {
  const EventEdit({super.key, required this.event});
  static const String id = 'EventEdit';
  final Event event;

  @override
  State<EventEdit> createState() => _EventEditState();
}

class _EventEditState extends State<EventEdit> {
  FirebaseEventsDatabase database = FirebaseEventsDatabase();
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  late Category selectedCategory;
  List<Category> categories = [];
  @override
  void initState() {
    super.initState();
    categories = allCategories.values.toList();
    selectedCategory = categories.firstWhere(
      (cat) => cat.id == widget.event.categoryId,
      orElse: () => categories.first,
    );
    titleController = TextEditingController(text: widget.event.title);
    descriptionController = TextEditingController(
      text: widget.event.description,
    );
    selectedDate = widget.event.eventDate;

    selectedTime = TimeOfDay(
      hour: widget.event.eventTime.hour,
      minute: widget.event.eventTime.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(localizations.addEvent),
        leadingWidth: 70,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            SizedBox(),
            Container(
              margin: .symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondary.withAlpha(80),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    !provider.isDark
                        ? selectedCategory.imageLight
                        : selectedCategory.imageDark,
                    width: double.infinity,
                    fit: .cover,
                  ),
                ),
              ),
            ),
            _buildCategoriesTabBar(context, provider),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 8,
                children: [
                  Text(
                    localizations.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextFormField(
                    style: TextStyle(color: theme.colorScheme.secondary),
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: localizations.eventTitleHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 8,
                children: [
                  Text(
                    localizations.description,
                    style: theme.textTheme.titleSmall!,
                  ),
                  TextFormField(
                    style: TextStyle(color: theme.colorScheme.secondary),
                    maxLines: 5,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: localizations.eventDescriptionHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: .start,
                children: [
                  Icon(
                    Iconsax.calendar_add_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    localizations.eventDate,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      var date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: selectedDate,
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (date != null) {
                        setState(() {
                          selectedDate = date;
                        });
                      }
                    },
                    child: Text(
                      selectedDate == null
                          ? localizations.chooseDate
                          : DateFormat("dd - MM -yyyy").format(selectedDate!),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: .start,
                children: [
                  Icon(
                    Iconsax.clock_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    localizations.eventTime,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      var time = await showTimePicker(
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          selectedTime = time;
                        });
                      }
                    },
                    child: Text(
                      selectedTime == null
                          ? localizations.chooseTime
                          : DateFormat("hh:mm a").format(
                              DateTime(
                                1,
                                1,
                                1,
                                selectedTime!.hour,
                                selectedTime!.minute,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomFilledButton(
                text: localizations.updateEvent,
                onPressed: () {
                  if (selectedDate == null ||
                      selectedTime == null ||
                      titleController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    return;
                  }

                  _editEvent();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  DefaultTabController _buildCategoriesTabBar(
    BuildContext context,
    AppConfigProvider provider,
  ) {
    return DefaultTabController(
      length: categories.length,
      child: TabBar(
        isScrollable: true,
        tabAlignment: .start,
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        indicatorColor: Colors.transparent,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        padding: .symmetric(horizontal: 12),
        labelPadding: .all(4),
        onTap: (value) {
          setState(() {
            selectedCategory = categories[value];
          });
        },
        tabs: categories
            .map(
              (category) => Container(
                padding: .symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1,
                    color: category.id == selectedCategory.id
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).colorScheme.onSecondary.withAlpha(20),
                  ),
                  color: category.id == selectedCategory.id
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSecondary,
                ),
                child: Row(
                  crossAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    Icon(
                      category.icon,
                      color: category.id == selectedCategory.id
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      provider.isEn ? category.nameEn : category.nameAr,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: category.id == selectedCategory.id
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _editEvent() async {
    DialogUtils.showLoadingDialog(context);
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await database.editEvent(
        Event(
          id: widget.event.id,
          categoryId: selectedCategory.id,
          title: titleController.text,
          description: descriptionController.text,
          eventDate: selectedDate ?? widget.event.eventDate,
          eventTime: DateTime(
            1,
            1,
            1,
            selectedTime!.hour,
            selectedTime!.minute,
          ),
          uid: firebaseAuth.currentUser!.uid,
          favorites: widget.event.favorites,
        ),
      );
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      DialogUtils.buildDialog(
        context,
        title: 'Error',
        content: e.toString(),
        negActionText: 'Ok',
      );
    }
  }
}
