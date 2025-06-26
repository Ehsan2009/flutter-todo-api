import 'package:flutter/material.dart';
import 'package:flutter_todo_api/common_widgets.dart/custom_text_field.dart';
import 'package:flutter_todo_api/models/todo.dart';
import 'package:flutter_todo_api/services/todo_service.dart';

class AddEditTodoScreen extends StatefulWidget {
  const AddEditTodoScreen({super.key, required this.isEditMode, this.todo});

  final bool isEditMode;
  final Todo? todo;

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  var enteredTitle = '';
  var enteredDescription = '';
  final formKey = GlobalKey<FormState>();
  var isLoading = false;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode && widget.todo != null) {
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  void submit() async {
    bool validate = formKey.currentState!.validate();

    if (validate) {
      setState(() {
        isLoading = true;
      });

      if (widget.isEditMode) {
        await TodoService().updateTodo(
          widget.todo!.id,
          titleController.text,
          descriptionController.text,
        );
      } else {
        await TodoService().addTodo(
          titleController.text,
          descriptionController.text,
        );
      }

      setState(() {
        isLoading = false;
      });

      titleController.text = '';
      descriptionController.text = '';
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(widget.isEditMode ? 'Edit Todo' : 'Add Todo'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 54, 53, 53),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 24,
            children: [
              CustomTextField(
                controller: titleController,
                hintText: 'Title',
                maxLines: 1,
              ),
              CustomTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 5,
              ),
              GestureDetector(
                onTap: submit,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          widget.isEditMode ? 'Update' : 'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
