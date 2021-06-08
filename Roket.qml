import QtQuick 2.0

Rectangle {
    id: mroket  //Решил не заморачиваться над текстурой ракеты - пусть будем красный круг
    color: "red"
    radius: 5
    width: 10
    height: 10

    Timer{
        interval: 40;running: true; repeat: true;

        onTriggered:{
            if (mroket.x > 1200 || mroket.x < -20) //Если ракета зашла в данные промежутки на карте, то останавливается (иначе бы она могла прилететь обратно по нажатию мышкой) )
            {
                r_x = 0
                r_y = 0
            }

            if (mroket.y > 750 || mroket.y < -20)
            {
                r_x = 0
                r_y = 0
            }
            mroket.x +=r_x //Добавляем к координатам ракеты скорость
            mroket.y +=r_y

        }
    }
}
