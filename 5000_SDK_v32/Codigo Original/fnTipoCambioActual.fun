
[Funcion]
Clave=fnTipoCambioActual
Nombre=Regresa el tipo de cambio actual de la moneda
Parametros=Moneda
Expresion=SQL(<T>SELECT ISNULL(TipoCambio,0.0) FROM Mon WHERE Moneda = :tMoneda<T>,[Moneda])
