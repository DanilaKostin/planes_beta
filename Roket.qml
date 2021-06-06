import QtQuick 2.0

Rectangle {
    id: mroket
    color: "red"
    radius: 5
    width: 10
    height: 10

    Timer{
        interval: 40;running: true; repeat: true;

        onTriggered:{
            if (mroket.x > 1200 || mroket.x < -20)
            {
                r_x = 0
                r_y = 0
            }

            if (mroket.y > 750 || mroket.y < -20)
            {
                r_x = 0
                r_y = 0
            }
            mroket.x +=2*r_x
            mroket.y +=2*r_y

        }
    }
}
