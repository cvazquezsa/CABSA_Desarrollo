[Forma]
Clave=LCAval
Nombre=Avales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=265
PosicionInicialArriba=291
PosicionInicialAlturaCliente=414
PosicionInicialAncho=749
Comentarios=Info.LineaCredito
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LCAval
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaCamposAValidar=Cte.Nombre
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=LCAval.LineaCredito=<T>{Info.LineaCredito}<T>

[Lista.LCAval.Aval]
Carpeta=Lista
Clave=LCAval.Aval
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LCAval.Referencia]
Carpeta=Lista
Clave=LCAval.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LCAval.Fecha]
Carpeta=Lista
Clave=LCAval.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LCAval.Estado]
Carpeta=Lista
Clave=LCAval.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Aval=112
Referencia=189
Fecha=94
Estado=128
Importe=93
Moneda=99

[Lista.LCAval.Importe]
Carpeta=Lista
Clave=LCAval.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LCAval.Moneda]
Carpeta=Lista
Clave=LCAval.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.LCAvalInfo]
Nombre=LCAvalInfo
Boton=34
NombreDesplegar=&Aval
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=LCAvalInfo
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
ConCondicion=S
EjecucionCondicion=ConDatos(LCAval:LCAval.Aval)
AntesExpresiones=Asigna(Info.Cliente, LCAval:LCAval.Aval)<BR>Asigna(Info.Nombre, LCAval:Cte.Nombre)


[Lista.ListaEnCaptura]
(Inicio)=LCAval.Aval
LCAval.Aval=LCAval.Referencia
LCAval.Referencia=LCAval.Fecha
LCAval.Fecha=LCAval.Importe
LCAval.Importe=LCAval.Moneda
LCAval.Moneda=LCAval.Estado
LCAval.Estado=(Fin)







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=LCAvalInfo
LCAvalInfo=(Fin)
