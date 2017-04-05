/**
 * Created by GJS on 2017/3/30.
 */

import React from 'react';
import {
    View,
    Text,
} from 'react-native';

export default class ChatScreen extends React.Component {
    static navigationOptions = {
        // Nav options can be defined as a function of the navigation prop:
        title: ({ state }) => `Chat with ${state.params.user}`,
    };
    render() {
        // The screen's current route is passed in to `props.navigation.state`:
        const { params } = this.props.navigation.state;
        return (
            <View>
                <Text>Chat with {params.user}</Text>
            </View>
        );
    }
}