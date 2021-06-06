#include "helper.h"
#include <QDebug>
#include "QtMath"
#include "QTime"
#include "QRandomGenerator"
Helper::Helper(QObject *parent) : QObject(parent)
{

}
QVector<double> Helper::rast(double x, double y, double x1, double y1){
bool f = false;
double dist = sqrt((x-x1+70)*(x-x1+70) + (y-y1+50)*(y-y1+50));

if (dist < 120)
f = true;
QVector <double> p;
p.push_back(f);
return p;
}

QVector<double> Helper::vector(double x, double y){
    QVector<double> copy;
    double x2 = x/(sqrt(x*x+y*y));
    double y2 = y/(sqrt(x*x+y*y));

    copy.push_back(x2);
    copy.push_back(y2);
    return copy;
}
QVector<double>Helper::rand(){
   QVector<double> copy;

   QTime midnight(0,0,0);
   qsrand(midnight.secsTo(QTime::currentTime()));
   double x2 = 0;
   double y2 = 0;
   int koef = qrand() % 4;

   if (koef == 0){
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

QVector<double>Helper::atang(double x, double y){
   QVector<double> copy;
   double tan = (y/x);
   double atan = qAtan(tan)*180/M_PI-90;
   if ((x > 0 && y < 0) || (x>0 && y>0))
       atan +=180;

   QVector<double> cop;
   cop.push_back(atan);
   return cop;
}
QVector<double> Helper::reject(double x){
QVector<double> coqy;
double grad;


    if (x > 0)
    {
        grad = 180 - x;
    }
    if (x < 0)
    {
        grad = -180 - x;
    }

    if (x==0 || x == 90 || x ==-90)
        grad = 180;


coqy.push_back(grad);
return coqy;
}

