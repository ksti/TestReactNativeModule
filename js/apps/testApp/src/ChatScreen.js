/**
 * Created by GJS on 2017/3/30.
 */

import React from 'react';
import {
    View,
    Text,
    Button,
} from 'react-native';

export default class ChatScreen extends React.Component {
    /*
    static navigationOptions = ({ navigation }) => {
        const {state, setParams} = navigation;
        const isInfo = state.params.mode === 'info';
        const {user} = state.params;
        return {
            // title: isInfo ? `${user}'s Contact Info` : `Chat with ${state.params.user}`,
            // headerRight: (
            //     <Button
            //         title={isInfo ? 'Done' : `${user}'s info`}
            //         onPress={() => setParams({ mode: isInfo ? 'none' : 'info'})}
            //     />
            // ),

            // Nav options can be defined as a function of the navigation prop:
            title: ({ state }) => `Chat with ${state.params.user}`,
            header: ({ state }) => {
                return {
                    style: { backgroundColor: 'green'},
                    titleStyle: {
                        color: 'white',
                        textAlign: 'center',
                    },
                    left: <Button
                        title="返回"
                        onPress={
                        () => {
                            //console.log(`state:${Object.keys(state)}`); //state:type,routeName,params,action,key
                            navigation.goBack();
                        }
                    }
                    />,
                    right: <Button title="Info Right" />,
                };
            },
            headerRight: <Button title="Info" />,
        };
    };
    */
    static navigationOptions = {
        // Nav options can be defined as a function of the navigation prop:
        title: ({ state }) => `Chat with ${state.params.user}`,
        // header: ({ state, setParams, goBack, navigate, dispatch }) => {
        header: (navigation) => {
            return {
                style: { backgroundColor: 'green'},
                titleStyle: {
                    color: 'white',
                    textAlign: 'center',
                },
                left: <Button
                    title="返回"
                    onPress={
                        () => {
                            //console.log(`state:${Object.keys(state)}`); //state:type,routeName,params,action,key
                            //goBack && goBack();
                            navigation && navigation.goBack();
                        }
                    }
                />,
                right: <Button title="Info Right" />,
            };
        },
        headerRight: <Button title="Info" />,
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