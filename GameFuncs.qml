import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
Rectangle {

    width: 1200 //Меню снизу
    height: 140
    x : 0
    y : 750
    color: "blue"

    property int remem: reload //Переменная запоминания текущих секунд перезарядки
    function check(){ //Проверка того, что можно пустить ракету

        if (ready_strike)
            tex.text = "Ready"

        if (!ready_strike || remem == 0) //Если не флаг или remem ==0 ( она автоматически равняется 0 при запуске новой игры, чтоб прошла перезарядка сразу)
        {
            tex.text = remem         //Пишем сколько секунд
            if (remem === 0){        //Если 0
                ready_strike = true  //То флаг - можно стрелять
                remem = reload       //Переменная обновляется до 5 секунд
                return               //Выходим
            }

            remem--                   //Уменьшаем каждую секунду
        }
    }
    function new_game(){
        planer.x = 500 //Переводим самолёт на взлётную полосу и крутим его соответствующе
        planer.y = 210
        planer.rotation = 110

        x_s = 0 //Он не летит
        y_s = 0

        score = 0 //Счёт обнуляем, как и остальные требования
        remem = reload
        ready_strike = true

        first.x = 2000 //Ракета как бы вне экрана игры - мы не видим, значит её нет)
        first.y = 2000
    }
    function lose(){
        var t = helper.rast(planer.x-45, planer.y-45, first.x, first.y) //Расстояние между НЛО и самолётом
        if (t[0] == true){ //Если оно мало (менее 70 пикселей)
            planer.x = 2000 //Самолёт вон с экрана - типо уничтожен
            planer.y = 2000

            losing.open() //Открываем диалог с выбором либо завершения, либо перезапуска.

        }
    }

    RowLayout{ //Размещаем кнопки через остступы
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
                    Timer{ //Таймер отсчёта перезарядки и проверки столкновения
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
        title: "You have crushed in the UFO!"
        standardButtons: StandardButton.Yes | StandardButton.No
        Text{
            text: "Restart the game?"
            anchors.centerIn: parent
        }
        onYes: new_game()
        onNo: Qt.quit()
    }
}
