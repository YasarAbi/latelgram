import 'package:flutter/material.dart';
import 'package:latelgram/screens/add_post_screen.dart';
import 'package:latelgram/screens/feed_screen.dart';

const webScreenSize = 900;

const homeScreenItems = [
  const FeedScreen(),
  const Center(child: Text('Arama')),
  const AddPostScreen(),
  const Center(child: Text('Favoriler')),
  const Center(child: Text('Profil')),
];