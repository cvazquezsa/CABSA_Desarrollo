
[Funcion]
Clave=FnModuloPREV
Nombre=Verifica si el Modulo esta encendido
Parametros=Empresa
Expresion=SQL(<T>Select isnull(ModuloPREV,0) from EmpresaCfgFRP Where Empresa=:tEmp<T>,[Empresa])
