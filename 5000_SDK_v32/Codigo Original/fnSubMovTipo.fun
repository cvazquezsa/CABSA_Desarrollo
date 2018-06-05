
[Funcion]
Clave=fnSubMovTipo
Nombre=Regresa la subclave de afectacion de un movimiento determinado
Parametros=(Lista)

Expresion=SQL(<T>SELECT ISNULL(SubClave,:tVacio) FROM MovTipo WHERE Modulo = :tModulo AND Mov = :tMov<T>,<T><T>,[Modulo],[Mov])
[Funcion.Parametros]
(Inicio)=Modulo
Modulo=Mov
Mov=(Fin)
