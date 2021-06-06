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
    function ele(){
        if (enemy_flag){
            var t = helper.rand()
            first.x = t[0]
            first.y = t[1]
            c_sx = baza_x - first.x - 60
            c_sy = baza_y - first.y - 45

            var b = helper.vector(c_sx, c_sy)

            c_sx = b[0]
            c_sy = b[1]

            enemy_flag = false
        }
    }

    Timer{
        interval: 40;running: true; repeat: true;

        onTriggered:{
            ele()
            first.x += c_sx*3
            first.y += c_sy*3
            var t = helper.rast(first.x, first.y, rok.x, rok.y)
            if (t[0] === 1)
                score++
            if (t[0] === 1 || first.x >= 1400 || first.y >= 900){
                enemy_flag = true
                rok.x = -3000
                rok.y= -3000
            }
        }
    }

    Shortcut{
        context: Qt.ApplicationShortcut
        sequences: ["Space"]
        onActivated:
        {
            if (ready_strike && x_s !=0 && y_s !=0)
            {
                rok.x = planer.x + 45
                rok.y = planer.y + 45

                r_x = x_s
                r_y = y_s
                ready_strike = false
            }

        }
    }
}
