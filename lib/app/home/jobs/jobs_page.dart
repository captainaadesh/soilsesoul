import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth_demo_flutter/app/about_page.dart';
import 'package:firebase_auth_demo_flutter/app/home/job_entries/job_entries_page.dart';
import 'package:firebase_auth_demo_flutter/app/home/jobs/edit_job_page.dart';
import 'package:firebase_auth_demo_flutter/app/home/jobs/empty_content.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/avatar.dart';
import 'package:firebase_auth_demo_flutter/app/home/jobs/job_list_tile.dart';
import 'package:firebase_auth_demo_flutter/app/home/jobs/list_items_builder.dart';
import 'package:firebase_auth_demo_flutter/models/job.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/services/database.dart';
import 'package:firebase_auth_demo_flutter/services/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth_demo_flutter/models/avatar_reference.dart';
import 'package:firebase_auth_demo_flutter/services/firebase_storage_service.dart';
import 'package:firebase_auth_demo_flutter/services/image_picker_service.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthService>(context,listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _onAbout(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AboutPage(),
      ),
    );
  }


  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // 1. Get image from picker
      final imagePicker =
      Provider.of<ImagePickerService>(context, listen: false);
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        // 2. Upload to storage
        final storage =
        Provider.of<FirebaseStorageService>(context, listen: false);
        final downloadUrl = await storage.uploadAvatar(file: file);
        // 3. Save url to Firestore
        //final database = Provider.of<FirestoreService>(context, listen: false);
        //await database.setAvatarReference(AvatarReference(downloadUrl));
        //final database = Provider.of<FirestoreDatabase>(context, listen: false);
        final database = Provider.of<Database>(context, listen: false);
        await database.setAvatarReference(AvatarReference(downloadUrl));
        // 4. (optional) delete local file as no longer needed
        await file.delete();
      }
    } catch (e) {
      print(e);
    }
  }


  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false); //TODO understand
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () => _onAbout(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => EditJobPage.show(
              context,
              //database: Provider.of<Database>(context),
            ),
          ),
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Column(
            children: <Widget>[
              _buildUserInfo(user),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      body: _buildContents(context),
 //     floatingActionButton: FloatingActionButton(
 //       child: Icon(Icons.add),
 //       onPressed: () => EditJobPage.show(context),
 //     ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false); //TODO Understand
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context,job),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Avatar(
          photoUrl: user.photoUrl,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
        ),
        SizedBox(height: 8),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(height: 8),
      ],
    );
  }
/*
  Widget _buildUserInfo({BuildContext context}) {
    //final database = Provider.of<FirestoreService>(context, listen: false);
    //final database = Provider.of<FirestoreDatabase>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(),
      builder: (context, snapshot) {
        final avatarReference = snapshot.data;
        return Avatar(
          photoUrl: avatarReference?.downloadUrl,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
          onPressed: () => _chooseAvatar(context),
        );
      },
    );
  }*/


}
