/**
 * Created by GJS on 2017/3/30.
 */

import React from 'react';
import {
    Button,
    Platform,
    ScrollView,
    StyleSheet,
    Text,
    TouchableOpacity,
    View,
    Image,
} from 'react-native';
import { NativeEventEmitter, NativeModules } from 'react-native';

import GJSTestModule from 'react-native-gjs-test-module'
import StarRatingView from 'react-native-gjs-test-module/StarRatingView'

export default class TestScreen extends React.Component {
    static navigationOptions = {
        title: 'For Test',
    };

    constructor(props) {
        super(props);
        //
        const testEmitter = new NativeEventEmitter(GJSTestModule);
        const subscription = testEmitter.addListener(
            'EventReminder',
            (reminder) => console.log(reminder.name)
        );
        this.subscription = subscription;
        // state
        this.state = {
            imageUrl: 'http://77587-interesting.stor.sinaapp.com/images/2_8_20151212112757.jpg',
        };
    }

    componentWillMount() {
        //
    }

    componentDidMount() {
        //
    }

    componentWillUnmount() {
        //
        // 别忘了取消订阅，通常在componentWillUnmount生命周期方法中实现。
        this.subscription && this.subscription.remove();
    }

    render() {
        const { navigate } = this.props.navigation;
        const { imageUrl } = this.state;
        return (
            <View style={styles.container}>
                <Text>Hello, Test App!</Text>
                <Image
                    style={{width: 100, height: 100, backgroundColor: 'purple'}}
                    source={{uri: imageUrl}}
                    resizeMethod={'auto'}
                    resizeMode={'contain'}
                />
                <Button
                    onPress={() => {
                        this._testIosNativeModule();
                        alert('test async await: precede await!');
                    }}
                    title="GJSTestModule"
                />
                <StarRatingView
                    style={{width: 100, height: 100, backgroundColor: 'green'}}
                    emptyStarColor='pink'
                    filledStarColor='yellow'
                    accurateHalfStars={true}
                    continuous={true}
                />
                <StarRatingView
                    style={{width: 100, height: 40, backgroundColor: 'cyan'}}
                    maximumValue={3}
                    value={2}
                    allowsHalfStars={false}
                    emptyStarImage={{uri: 'heart-empty'}}
                    filledStarImage={{uri: 'heart-full'}}
                />
                <StarRatingView
                    style={{flex: 1, width: 100, height: 100, backgroundColor: 'orange'}}
                    maximumValue={7}
                    value={2}
                    emptyStarImage={{uri: 'heart-empty'}}
                    filledStarImage={{uri: 'heart-full'}}
                />
            </View>
        );
    }

    // async _testIosNativeModule() {
    _testIosNativeModule = async() => {
        if (Platform.OS === 'ios') {
            if (!GJSTestModule) return;
            let functionName = 'init';
            console.log('module author:' + GJSTestModule.ModuleAuthor);
            console.log('testEnum2:' + GJSTestModule.testEnum2);
            /* then catch
            GJSTestModule.testRespondMethod(functionName).then((result) => {
                if (result) {
                    alert(functionName + ' can be responsed!');
                }
            }).catch((errCode, errMessage) => {
                console.log(errMessage);
            });
            */

            // async await
            try {
                let result = await GJSTestModule.testRespondMethod(functionName);

                if (result) {
                    alert(result + ' can be responsed!');
                }
            } catch (e) {
                console.error(e);
            }

            alert('test async await: after await!');

        }
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
    }
})