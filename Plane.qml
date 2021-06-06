import QtQuick 2.0


Rectangle{
    id: plane
    //    function reject(x1){
    //    }

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
            interval: 90;running: true; repeat: true;

            onTriggered:{

                if (plane.x > 1105 || plane.x < 0){

                    x_s*=-1
                    plane.x +=2*x_s
                    var t = helper.reject(plane.rotation)
                    plane.rotation = t[0] + 180
                }
                else
                {
                    plane.x += x_s
                }

                if (plane.y > 660 || plane.y < 0){
                    y_s*=-1
                    plane.y +=2*y_s
                    var t = helper.reject(plane.rotation)

                    plane.rotation = t[0]
                }
                else
                {
                    plane.y +=y_s}
            }
        }
    }
}




