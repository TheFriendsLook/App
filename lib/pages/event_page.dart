// Flutter
import 'package:flutter/material.dart';
import 'package:the_friends_look/controllers/db_controller.dart';

import '../controllers/db_controller.dart';
import '../controllers/user_controller.dart';
import '../models/event.dart';

class EventPageArguments {
  final Event event;
  final String imageTag;

  EventPageArguments(this.event, this.imageTag);
}

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventPageArguments args = ModalRoute.of(context).settings.arguments;
    final event = args.event;
    final imageTag = args.imageTag;

    final author = DbController().getAuthorForEvent(event.id);
    final isSubscribed = DbController().isSubscribed(event.id);
    final btnText = isSubscribed ? "Unsubscribe" : "Subscribe";

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Column(
        children: <Widget>[
          Hero(
            tag: event.imageUrl + imageTag,
            child: Image.network(
              event.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(author.avatarUri),
                ),
                padding: EdgeInsets.all(5),
              ),
              Chip(label: Text(author.username)),
              Expanded(
                child: Container(),
              ),
              Padding(
                child: Text(event.date.toString()),
                padding: EdgeInsets.all(5),
              ),
            ],
          ),
          Row(children: <Widget>[
            // TODO: style
            RaisedButton(
              onPressed: () {
                if (!isSubscribed) {
                  DbController().subscribe(UserController().getCurrentUser().id, event.id);
                }
              },
              child: Text(btnText),
            )
          ],)
        ],
      ),
    );
  }
}
