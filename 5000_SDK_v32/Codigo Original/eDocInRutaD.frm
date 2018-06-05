
[Forma]
Clave=eDocInRutaD
Icono=0
CarpetaPrincipal=eDocInRutaD
Modulos=(Todos)

ListaCarpetas=eDocInRutaD
PosicionInicialAlturaCliente=368
PosicionInicialAncho=685
PosicionCol1=162
PosicionInicialIzquierda=457
PosicionInicialArriba=227
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Descripcion,Info.Ruta)
Nombre=Info.Titulo
SinTransacciones=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[eDocInRutaD]
Estilo=Ficha
Clave=eDocInRutaD
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInRutaDVista
Fuente={Tahoma, 12, Negro, []}
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=255
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S


ConFuenteEspecial=S
PestanaOtroNombre=S
PestanaNombre=Operador
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroGrupo1=eDocInRutaDVista.OperadorNumero
FiltroValida1=eDocInRutaDVista.OperadorNumero
FiltroTodo=S
FiltroGrupo2=eDocInRutaDVista.Condicion
FiltroValida2=eDocInRutaDVista.Condicion

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
FiltroEnOrden=S
FiltroArbolClave=OperadorLogico
FiltroArbolValidar=OperadorLogico
FiltroArbolRama=GUID
FiltroArbolAcumulativas=GUID
TablaIndependiente=eDocInRutaD
FiltroIndependiente=S
FiltroGeneral=eDocInRutaDVista.eDocIn = <T>{Info.Descripcion}<T> AND<BR>eDocInRutaDVista.Ruta = <T>{Info.Ruta}<T> AND<BR>eDocInRutaDVista.Tipo = <T>{Info.Tipo}<T>
[eDocInRutaDCondicion.eDocInRutaDCondicion.Operando1]
Carpeta=eDocInRutaDCondicion
Clave=eDocInRutaDCondicion.Operando1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[eDocInRutaDCondicion.eDocInRutaDCondicion.Operador]
Carpeta=eDocInRutaDCondicion
Clave=eDocInRutaDCondicion.Operador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInRutaDCondicion.eDocInRutaDCondicion.Operando2]
Carpeta=eDocInRutaDCondicion
Clave=eDocInRutaDCondicion.Operando2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[eDocInRutaD.Columnas]
0=146
1=-2

OperadorLogico=112
Operando1=454
Operador=454
Operando2=454
[eDocInRutaDCondicion.Columnas]
Operando1=183
Operador=174
Operando2=304


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S





































[eDocInRutaD.ListaEnCaptura]
(Inicio)=eDocInRutaDCondicion.Operando1
eDocInRutaDCondicion.Operando1=eDocInRutaDCondicion.Operador
eDocInRutaDCondicion.Operador=eDocInRutaDCondicion.Operando2
eDocInRutaDCondicion.Operando2=(Fin)





[eDocInRutaDCondicion.ListaEnCaptura]
(Inicio)=eDocInRutaDCondicion.Operando1
eDocInRutaDCondicion.Operando1=eDocInRutaDCondicion.Operador
eDocInRutaDCondicion.Operador=eDocInRutaDCondicion.Operando2
eDocInRutaDCondicion.Operando2=(Fin)























[Forma.ListaCarpetas]
(Inicio)=eDocInRutaD
eDocInRutaD=eDocInRutaDCondicion
eDocInRutaDCondicion=(Fin)


































































[Acciones.OperadorO]
Nombre=OperadorO
Boton=62
NombreDesplegar=Operador &O
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



NombreEnBoton=S
EspacioPrevio=S





























Expresion=EjecutarSQL(<T>speDocInInsertarRutaD :teDocIn, :tRuta, :tTipo, :tOperador<T>,Info.Descripcion, Info.Ruta, Info.Tipo, <T>O<T>)<BR>  Forma.ActualizarArbol( <T>eDocInRutaD<T> )
[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=FormaModal(<T>eDocInRutaDCondicion<T>)              <BR> Forma.ActualizarArbol(<T>eDocInRutaDVista<T>)
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Clave,eDocInRutaDVista:eDocInRutaDVista.GUID)<BR>Asigna(Info.Descripcion,eDocInRutaDVista:eDocInRutaDVista.eDocIn)<BR>Asigna(Info.Ruta,eDocInRutaDVista:eDocInRutaDVista.Ruta)<BR>Asigna(Info.Opcion,eDocInRutaDVista:eDocInRutaDVista.OperadorLogico)
DespuesGuardar=S
Visible=S






[Acciones.OperadorY]
Nombre=OperadorY
Boton=62
NombreEnBoton=S
NombreDesplegar=Operador &Y
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=EjecutarSQL(<T>speDocInInsertarRutaD :teDocIn, :tRuta, :tTipo, :tOperador<T>,Info.Descripcion, Info.Ruta, Info.Tipo, <T>Y<T>)<BR>  Forma.ActualizarArbol( <T>eDocInRutaD<T> )











[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



EspacioPrevio=S
Expresion=EjecutarSQL(<T>speDocInRutaDEliminar :tGUID<T>,eDocInRutaDVista:eDocInRutaDVista.GUID)<BR> Forma.ActualizarArbol(<T>eDocInRutaD<T>)












[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Eliminar
Eliminar=OperadorY
OperadorY=OperadorO
OperadorO=Detalle
Detalle=(Fin)
