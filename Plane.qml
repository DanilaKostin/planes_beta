import QtQuick 2.0


Rectangle{
    id: plane //Самолёт, тут же задается начальное положение и текстура

    x : 500
    y : 210
    rotation: 110
    width: 90
    height: 90
    color: "transparent"
    Image{
        source: "qrc:/red_plane.png"
        width: 90
        height: 90

        Timer{
            interval: 90;running: true; repeat: true; //Таймер перемещения самолёта

            onTriggered:{

                if (plane.x > 1105 || plane.x < 0){ //Если самолёт зашел за край по Х

                    x_s*=-1  //Скорость по Х - назад
                    plane.x +=2*x_s //Чтобы не застрял добавляем чуть координаты назад
                    var t = helper.reject(plane.rotation) //Функция поворота - угол падения равен углу отражения
                    plane.rotation = t[0] + 180 //Но угол расчитывается хитро, не на все 360)
                }
                else
                {
                    plane.x += x_s //Если не перешел границу, просто добавляем скорость
                }

                if (plane.y > 660 || plane.y < 0){ //Идентично и с У
                    y_s*=-1
                    plane.y +=2*y_s
                    var t = helper.reject(plane.rotation)
                    plane.rotation = t[0]
                }
                else
                {
                    plane.y +=y_s
                }
            }
        }
    }
}




