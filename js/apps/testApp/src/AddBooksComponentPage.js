import React,{Component} from 'react'
import {
    AppRegistry,
     StyleSheet,
     Text,
     View,
     ListView,
     Animated,
     TouchableOpacity,
     Platform,
     Image,
     ScrollView,
     InteractionManager,
     Dimensions,
}from 'react-native'

  var headerDatas=[ {
                         "title":"A",
                         "icons":[
                             {
                                 "name" : "iconA1"
                                 },
                             {
                                 "name" : "iconA2"
                             },
                             {
                                 "name" : "iconA3"
                             }
                         ]
                     },
                     {
                         "title":"B",
                         "icons":[
                             {
                                 "name" : "iconB1"
                             },
                             {
                                 "name" : "iconB2"
                             },
                             {
                                 "name" : "iconB3"
                             },
                             {
                                 "name" : "iconB4"
                             }
                         ]
                     },
                     {
                         "title":"C",
                         "icons":[
                             {
                                 "name" : "iconC1"
                             },
                             {
                                 "name" : "iconC2"
                             }
                         ]
                     },
                     {
                         "title":"D",
                         "icons":[
                             {
                                 "name" : "iconD1"
                             },
                             {
                                 "name" : "iconD2"
                             },
                             {
                                 "name" : "iconD3"
                             },
                             {
                                 "name" : "iconD4"
                             }
                         ]
                     },
                     {
                         "title":"E",
                         "icons":[
                             {
                                 "name" : "iconE1"
                             },
                             {
                                 "name" : "iconE2"
                             },
                             {
                                 "name" : "iconE3"
                             }
                         ]
                     },
                     {
                         "title":"F",
                         "icons":[
                             {
                                 "name" : "iconF1"
                             },
                             {
                                 "name" : "iconF2"
                             }
                         ]
                     },{
                        "title":"G",
                        "icons":[
                            {
                                "name" : "iconG1"
                            },
                            {
                                "name" : "iconG2"
                            }
                        ]
                    },{
                         "title":"H",
                         "icons":[
                             {
                                 "name" : "iconH1"
                             },
                             {
                                 "name" : "iconH2"
                             }
                         ]
                     },{

                       "title":"I",
                       "icons":[
                           {
                               "name" : "iconI1"
                           },
                           {
                               "name" : "iconI2"
                           }
                       ]
                   }
                 ];

class AddBooksComponentPage extends Component
{
    constructor(props)
    {
        super(props);
         this.ds = new ListView.DataSource({
                    getSectionData : this.getSectionData,
                    getRowData : this.getRowData,
                    rowHasChanged : (r1, r2) => r1 !== r2,
                    sectionHeaderHasChanged : (s1, s2) => s1 !== s2
                }); 
        this.state={
            dataSource:this.ds
        };
    }
    getSectionData=(dataBlob, sectionID)=>
    {
        return dataBlob[sectionID];
    }
    getRowData=(dataBlob, sectionID, rowID)=>
    {
        return dataBlob[sectionID + ':' + rowID];
    }

     loadData=()=>{
            // 定义变量
            var dataBlob = {},
                sectionIDs = [],
                rowIDs = [],
                icons = [];
            // 遍历数组中对应的数据并存入变量内
            for (var i = 0; i<headerDatas.length; i++){
                // 将组号存入 sectionIDs 中
                sectionIDs.push(i);
                // 将每组头部需要显示的内容存入 dataBlob 中
                dataBlob[i] = headerDatas[i].title;
                // 取出该组所有的 icon
                icons = headerDatas[i].icons;
                rowIDs[i] = [];
                // 遍历所有 icon
                for (var j = 0; j<icons.length; j++){
                    // 设置标识
                    rowIDs[i].push(j);
                    // 根据标识,将数据存入 dataBlob
                    dataBlob[i + ':' + j] = icons[j];
                }
            }
            // 刷新dataSource状态
            this.setState({ dataSource:this.state.dataSource.cloneWithRowsAndSections(dataBlob, sectionIDs, rowIDs)
            });
        }
    componentDidMount() {
//             this.loading.show();
                       InteractionManager.runAfterInteractions(() => {
//                           this.loading.dismiss();
                       this.loadData();
                       this.setState({ renderPlaceholderOnly: false });

                       });
   }
   componentWillUnmount() {
    }
    componentWillReceiveProps(nextProps)
    {
    }

    render()
    {
          if(this.state.renderPlaceholderOnly)return(<LoadingDialog
                                                               ref={ref => this.loading = ref}
                                                               text={'加载中...'}
                                                               loadingStyle={{
                                                                   // backgroundColor: 'red',
                                                               }}/>);

        return (<View style={{flex:1,backgroundColor:'white'}}>

                          <ListView
                            dataSource={this.state.dataSource}
                            renderRow={this._renderRow.bind(this)}
                            renderSectionHeader={this.renderSectionHeader.bind(this)}
                            />

                </View>);
    }
     _renderRow(obj, sectionID, rowID) {
            return (<View style={styles.row}><Text>{obj.name}</Text></View>);
    }

    // 返回一个SectionHeader
      renderSectionHeader(sectionData, sectionID){
          return(
              <Text style={{backgroundColor:'red'}}>{sectionData}</Text>
          );
      }

     renderRow(obj, sectionID, rowID) {
            return (
                <View style={styles.row}>
                    <Image
                        resizeMode='stretch'
                        source={obj.img}
                        style={styles.avatar}
                        />
                    <Text sytle={styles.name}>{obj.name}</Text>
                </View>
            )
        }
}

const styles = StyleSheet.create({
   container: {
          flex: 1,
          paddingTop: 24,
      },
      row: {
          paddingVertical:10,
          flexDirection: 'row',
          height:50,
          alignItems: 'center',
      },
      avatar: {
          height: 50,
          width: 50,
          borderRadius: 25,
          marginHorizontal: 20,
      },
      name: {
          fontSize: 16,
      }
});
module.exports=AddBooksComponentPage;