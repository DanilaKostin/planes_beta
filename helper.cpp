#include "helper.h"
#include <QDebug>
#include "QtMath"
#include "QTime"
#include "QRandomGenerator"
Helper::Helper(QObject *parent) : QObject(parent) //Везде возвращается Вектор. Просто.
{

}
QVector<double> Helper::rast(double x, double y, double x1, double y1){ //Вычисление расстояния между точками, возвращает true если расстояние менее какой то величины - 70.
    bool f = false;
    double dist = sqrt((x-x1+70)*(x-x1+70) + (y-y1+50)*(y-y1+50));

    if (dist < 70)
        f = true;
    QVector <double> p;
    p.push_back(f);
    return p;
}

QVector<double> Helper::vector(double x, double y){ //Вычисление нормированного вектора - каждая координата делится на длину вектора
    QVector<double> copy;
    double x2 = x/(sqrt(x*x+y*y));
    double y2 = y/(sqrt(x*x+y*y));

    copy.push_back(x2);
    copy.push_back(y2);
    return copy;
}
QVector<double>Helper::rand(){ //Рандомится число от 0 до 3 - соответственно 0 - верх, 1 - право, и так далее по сторонам.
    QVector<double> copy;

    QTime midnight(0,0,0); //Чтоб точно случайные числа в разных играх
    qsrand(midnight.secsTo(QTime::currentTime()));
    double x2 = 0;
    double y2 = 0;
    int koef = qrand() % 4;

    if (koef == 0){ //Если k такое, то НЛО будет сверху, соответственно рандомим Х - от 0 до 1200 длины окна, а У фикированный, и так для каждой стороны.
        y2 -=400;
        x2 = qrand() % 1200;
    }
    if (koef == 1){
        x2 = 1400;
        y2 = qrand() % 700;
    }
    if (koef == 2){
        y2 = 900;
        x2 = qrand() % 1200;
    }
    if (koef == 3){
        x2 = -200;
        y2 = qrand() % 700;
    }
    copy.push_back(x2);
    copy.push_back(y2);
    return copy;
}

QVector<double>Helper::atang(double x, double y){ //Функция вычисление арктангенса
    QVector<double> copy;
    double tan = (y/x); //Тангенс отношение катетов
    double atan = qAtan(tan)*180/M_PI-90; //По формуле вычисляем арктнг. и вычитаем 90 - тк самолёт как бы уже повёрнут на картинке.
    if ((x > 0 && y < 0) || (x>0 && y>0))
        atan +=180; //Чтобы правильно выбирать координатную плоскость

    QVector<double> cop;
    cop.push_back(atan);
    return cop;
}
QVector<double> Helper::reject(double x){ //Простое угловое отражение
    QVector<double> coqy;
    double grad;


    if (x > 0) //Логика в том, что каждая сторона - прямая, то есть угол 180 градусов, вычитая из него улог текущего поворота можно получит поворот градусах, на который должен быть повёрнут самолёт
    {
        grad = 180 - x;
    }
    if (x < 0)
    {
        grad = -180 - x;
    }

    if (x==0 || x == 90 || x ==-90) //Но угол повора - число с точкой, очень трудно будет подвести самолёт, чтобы его угол был ровно 90 градусов, но проверка такого присутствует.
        grad = 180;


    coqy.push_back(grad);
    return coqy;
}

