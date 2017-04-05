/**
 * Created by GJS on 2017/4/1.
 */

import React, {PropTypes} from 'react';
import { requireNativeComponent, View } from 'react-native';

const imageSourcePropType = PropTypes.oneOfType([
    PropTypes.shape({
        uri: PropTypes.string,
    }),
    // Opaque type returned by require('./image.jpg')
    PropTypes.number,
    // Multiple sources
    PropTypes.arrayOf(
        PropTypes.shape({
            uri: PropTypes.string,
            width: PropTypes.number,
            height: PropTypes.number,
        }))
]);

class StarRatingView extends React.Component {
    render() {
        return <RCTStarRatingView {...this.props} />;
    }
}

StarRatingView.propTypes = {
    /**
     *
     */
    ...View.props,
    maximumValue: PropTypes.number,
    minimumValue: PropTypes.number,
    value: PropTypes.number,
    spacing: PropTypes.number,
    allowsHalfStars: PropTypes.bool,
    accurateHalfStars: PropTypes.bool,
    continuous: PropTypes.bool,
    starBorderColor: PropTypes.string,
    starBorderWidth: PropTypes.number,
    emptyStarColor: PropTypes.string,
    filledStarColor: PropTypes.string,
    emptyStarImage: imageSourcePropType,
    halfStarImage: imageSourcePropType,
    filledStarImage: imageSourcePropType,
    onChange: PropTypes.func,
    shouldBeFirstResponder: PropTypes.bool,
    starImageStyle: PropTypes.string,
    overflow: PropTypes.string,
};

// requireNativeComponent 自动把这个组件提供给 "RCTStarRatingViewManager"
var RCTStarRatingView = requireNativeComponent('RCTStarRatingView', StarRatingView);

module.exports = StarRatingView;