import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
Rectangle {

    width: 1200
    height: 140
    x : 0
    y : 750
    color: "blue"

    property int remem: reload
    function check(){

        if (ready_strike)
            tex.text = "Ready"

        if (!ready_strike || remem == 0)
        {
            tex.text = remem
            if (remem === 0){
                ready_strike = true
                remem = reload
                return
            }

            remem--
        }
    }
    function new_game(){
        planer.x = 500
        planer.y = 210
        planer.rotation = 110

        x_s = 0
        y_s = 0

        score = 0
        remem = reload
        ready_strike = true

        first.x = 2000
        first.y = 2000
    }
    function lose(){
        var t = helper.rast(planer.x-45, planer.y-45, first.x, first.y)
        //        console.log(planer.x, planer.y)
        //        console.log(first.x, first.y)
        //        console.log(t[0])
        if (t[0] == true){
            planer.x = 2000
            planer.y = 2000
            losing.open()

        }
    }

    RowLayout{
        y: 5
        x: 5
        spacing: 570
        RowLayout{
            spacing: 10
            Button{

                Layout.preferredWidth: 100
                text: "New game"
                onPressed:{
                    new_game()
                }
            }

            Button{
                Layout.preferredWidth: 100
                text: "Quit"
                onClicked: Qt.quit()
            }
        }

        RowLayout{
            spacing: 10
            TextField{

                readOnly: true
                Layout.preferredWidth: 200
                Text{
                    font.pointSize: 25
                    text: score
                }

            }

            TextField{
                id: tex
                readOnly: true
                Layout.preferredWidth: 200
                font.pointSize: 15
                Text{
                    Timer{
                        interval: 1000;running: true; repeat: true;
                        onTriggered:{
                            check()
                            lose()
                        }
                    }
                }
            }
        }

    }
    Dialog {
        id: losing
        title: "You have crushed in a UFO!"
        standardButtons: StandardButton.Yes | StandardButton.No
        Text{
            text: "Restart the game?"
            anchors.centerIn: parent
        }
        onYes: new_game()
        onNo: Qt.quit()
    }
}
