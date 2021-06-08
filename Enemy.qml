import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
Item {
    Image {
        source: "qrc:/nlo.png"
        width: 200
        height: 140
    }
    function ele(){ //Функция расчёта вектора и скорости полёта НЛО к точке в центре
        if (enemy_flag){ //Если враг либо только что уничтожен, либо улетел далеко за карту
            var t = helper.rand() //Вызываем функцию рандома стороны откуда НЛО прилетит
            first.x = t[0]
            first.y = t[1]
            c_sx = baza_x - first.x - 60 //Вектор направляющий полёт
            c_sy = baza_y - first.y - 45

            var b = helper.vector(c_sx, c_sy)

            c_sx = b[0] //Приравниваются скорости
            c_sy = b[1]

            enemy_flag = false //Враг появился - флаг false
        }
    }

    Timer{ //Таймер движения НЛО
        interval: 40;running: true; repeat: true;

        onTriggered:{
            ele()
            first.x += c_sx*3
            first.y += c_sy*3
            var t = helper.rast(first.x, first.y, rok.x, rok.y) //Расстояние между НЛО и ракетой
            if (t[0] === 1){ //Если очень близки, то увеличиваем счёт и ракету выводим с карты
                score++
                rok.x = -3000
                rok.y= -3000
            }
            if (t[0] === 1 || first.x >= 1400 || first.y >= 900){ //Если сбили НЛО или НЛО улетело за карту, флаг респавна true
                enemy_flag = true
            }
        }
    }

    Shortcut{ //Подготовка возможности по нажатию пробела выпускать ракету
        context: Qt.ApplicationShortcut
        sequences: ["Space"]
        onActivated:
        {
            if (ready_strike && x_s !=0 && y_s !=0) //Если можно готов стрелять и самолёт не стоит на месте респавна на полосе
            {
                rok.x = planer.x + 45 //Приводим ракету в центр самолёта
                rok.y = planer.y + 45

                r_x = 2*x_s //Скорость ракеты равна скорости самолёта * 2
                r_y = 2*y_s
                ready_strike = false //Не можем стрелять пока не перезарядится
            }
        }
    }
}
