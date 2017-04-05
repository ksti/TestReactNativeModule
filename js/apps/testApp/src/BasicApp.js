/**
 * Created by GJS on 2017/3/30.
 */

import React from 'react';
import {
    Text,
} from 'react-native';
import { StackNavigator } from 'react-navigation';

/*
 * Screens
 */
import HomeScreen from './HomeScreen'
import ChatScreen from './ChatScreen'
import TestScreen from './TestScreen'
import AddBooksComponentPage from './AddBooksComponentPage'

const SimpleApp = StackNavigator({
    Home: { screen: HomeScreen },
    Chat: { screen: ChatScreen },
    Test: { screen: TestScreen },
    TestAddBooks: { screen: AddBooksComponentPage },
});

export default SimpleApp;
