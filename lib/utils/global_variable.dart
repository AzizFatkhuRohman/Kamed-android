import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamed/screen/add_ecommerce_screen.dart';
import 'package:kamed/screen/add_post_screen.dart';
import 'package:kamed/screen/ecommerce_screen.dart';
import 'package:kamed/screen/feed_screen.dart';
import 'package:kamed/screen/profile_screen.dart';
import 'package:kamed/screen/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const AddEcommerceScreen(),
  const EcommerceScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];