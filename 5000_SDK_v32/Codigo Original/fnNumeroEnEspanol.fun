
[Funcion]
Clave=fnNumeroEnEspanol
Nombre=Obtiene el importe en letra 
Parametros=(Lista)

Expresion=SQL(<T>SELECT dbo.fnNumeroEnEspanol(:nNumero, :tMoneda)<T>, [Numero], [Moneda])
[Funcion.Parametros]
(Inicio)=Numero
Numero=Moneda
Moneda=(Fin)
