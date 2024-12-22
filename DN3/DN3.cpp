#include <iostream>
#include <cmath>
#include <cstdlib>

using namespace std;


double calcAtan(double* x, int N_steps) {
    double output = 0;
    for (int i = 0; i < N_steps; i++) {
        double imenovalec = 2 * i + 1;
        double stevec = pow(*x, imenovalec);
        double temp = stevec / imenovalec;
        temp *= pow(-1, i);
        output += temp;
    }
    return output;
}

double funkcija(double x) {
    return exp(3 * x) * calcAtan(&x, 50);
}
double Trapz(double a, double b, double (*f)(double), int n) {
    double dolzina = b - a;
    double vsota = 0;
    for (int i = 1; i < n; i++) {
        double x_i = a + i * dolzina / n;
        vsota += 2 * f(x_i);
    }
    vsota += f(a) + f(b);
    return (dolzina / (2 * n)) * vsota;
}

int main() {
    int M_PI = 3.14;
    double pi = M_PI;
    int n1 = 1000;
    double* tab = (double*)calloc(n1, sizeof(double)); 

    for (int j = 1; j < n1; j++) {
        tab[j - 1] = Trapz(0, pi / 4, funkcija, j);
    }

    int ix = 0;
    double diff = 1000000.0;

    for (int l = 1; l < n1 - 1; l++) {
        if (abs(tab[l + 1] - tab[l]) < diff) {
            diff = abs(tab[l + 1] - tab[l]);
            ix = l;
        }
    }

    cout << tab[ix] << endl;
    free(tab);

    return 0;
}
