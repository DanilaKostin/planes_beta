import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {

        signal new_game()
    property double x_s: 0
    property double y_s: 0

    property double r_x: 0
    property double r_y: 0

    property double xold: 0
    property double yold: 0


    property bool ready_strike: true

    property int reload: 5
    property int kill: 0
    property int score: 0
    id: main
    width: 1200
    height: 800
    minimumWidth:1200
    maximumWidth: 1200

    color: "white"
    minimumHeight:800
    maximumHeight:800

    Image{
        id: fon
        source: "qrc:/fon.jpg"
        height: 750
        width: 1200

    }


    function vector(){
        var nor_vect = helper.vector(xold, yold)
        x_s = nor_vect[0]*8
        y_s = nor_vect[1]*8
    }



    MouseArea{
        id: ma
        anchors.fill: fon
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {

            if(mouse.button === Qt.LeftButton)
            {

                xold = mouse.x - planer.x - 45
                yold = mouse.y - planer.y - 45
                vector()

                var proectia_y = planer.x + 45

                var p = helper.atang(xold, yold);

                planer.rotation = p[0];
            }
        }

    }
    Plane{
        id: planer
    }
    Enemy{

        property bool enemy_flag: true
        property double c_sx: 0
        property double c_sy: 0

        property double baza_x: 630
        property double baza_y: 310

        id: first
        x: -150
        y: -150
    }


    Roket{

        id: rok
        x: -100
        y: -100
    }
    Gamemenu{
        id: gmenu

    }
Component.onCompleted: {
    new_game()
}

    visible: true
    title: qsTr("Airport")
}
