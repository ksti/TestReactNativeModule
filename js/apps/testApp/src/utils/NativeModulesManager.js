/**
 * Created by GJS on 2017/3/27.
 */

import React, {PropTypes, Component} from 'react';

import {
    Platform,
    NativeModules,
} from 'react-native'

// 原生模块，提供一些原生类、库(功能)
export default NativeModulesManager = {
    iosIQKeyboardHandler: (function() {
        let iosIQKeyboardHandler = null;
        let native_IQKeyboardHandler = null;
        if (Platform.OS === 'ios') {
            iosIQKeyboardHandler = {};
            native_IQKeyboardHandler = NativeModules.IQKeyboardHandler;
            iosIQKeyboardHandler.setEnableAutoToolbar = (enableToolbar, doneText, doneTextStyle, callBack) => {
                if (callBack) {
                    native_IQKeyboardHandler.setEnableAutoToolbar(enableToolbar, doneText, doneTextStyle)
                        .then((result)=>callBack(result))
                        .catch((err)=>callBack(err));
                }
                else {
                    return new Promise((resolve, reject) => {
                        native_IQKeyboardHandler.setEnableAutoToolbar(enableToolbar, doneText, doneTextStyle)
                            .then((result)=>resolve(result))
                            .catch((err)=>reject(err));
                    });
                }
            }
        } else {
            // 没实现
        }

        return iosIQKeyboardHandler;
    }()),
};
