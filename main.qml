import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {

    property double x_s: 0 //Скорость самолёта по х
    property double y_s: 0 //Скорость по у

    property double r_x: 0 //Скорость ракеты по х
    property double r_y: 0 //По у

    property double xold: 0 //Координаты вектора из центра самолёта в место клика
    property double yold: 0


    property bool ready_strike: true //Флаг завершения перезарядки
    property int reload: 5 //Секунд перезарядки
    property int score: 0 //Счётчик сбитых НЛО

    id: main
    width: 1200 //Ограничения на размер окна
    height: 800
    minimumWidth:1200
    maximumWidth: 1200

    color: "white"
    minimumHeight:800
    maximumHeight:800

    Image{
        id: fon //Замена фона на картинку острова
        source: "qrc:/fon.jpg"
        height: 750
        width: 1200

    }


    function vector(){ //Функция вычисления координат нормированного вектора и увеличение их до скорости самолёта
        var nor_vect = helper.vector(xold, yold)
        x_s = nor_vect[0]*8
        y_s = nor_vect[1]*8
    }



    MouseArea{
        id: ma
        anchors.fill: fon
        acceptedButtons: Qt.LeftButton //Тут была идея сделать взаимодействие и с правой кнопкой, но пришлось отказаться
        onClicked: {

            if(mouse.button === Qt.LeftButton)
            {

                xold = mouse.x - planer.x - 45 //Вычисление координат направляющего в точку нажатия вектора
                yold = mouse.y - planer.y - 45
                vector()

                var p = helper.atang(xold, yold); //Функия на С++ расчитывает поворот через арктангенс

                planer.rotation = p[0];
            }
        }

    }
    Plane{
        id: planer
    }
    Enemy{

        property bool enemy_flag: true //Флаг того, чтобы координаты полёта НЛО рассчитовадись единожды ( а не каждый тик таймера)
        property double c_sx: 0 //Скорость НЛО
        property double c_sy: 0

        property double baza_x: 630 //Координаты вектора движения НЛО (примерно посередине)
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

    GameFuncs{
        id: gmenu
    }
    visible: true
    title: qsTr("Aliens attack!")
}
