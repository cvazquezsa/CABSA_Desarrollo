
[Forma]
Clave=eDocInRutaDCondicion
Icono=0
Modulos=(Todos)
Nombre=Info.Titulo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=eDocInRutaDCondicion
CarpetaPrincipal=eDocInRutaDCondicion
PosicionInicialIzquierda=449
PosicionInicialArriba=235
PosicionInicialAlturaCliente=352
PosicionInicialAncho=702
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Descripcion,Info.Ruta,Info.Opcion)
[eDocInRutaDCondicion]
Estilo=Hoja
Clave=eDocInRutaDCondicion
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInRutaDCondicion
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=30
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

PermiteEditar=S
TablaIndependiente=eDocInRutaD
FiltroIndependiente=S
FiltroGrupo1=eDocInRutaD.OperadorLogico
FiltroValida1=eDocInRutaD.OperadorLogico
FiltroGrupo2=eDocInRutaDCondicion.Operador
FiltroValida2=eDocInRutaDCondicion.Operador
FiltroTodo=S
FiltroGeneral=eDocInRutaDCondicion.eDocIn = <T>{Info.Descripcion}<T> AND<BR>eDocInRutaDCondicion.Ruta = <T>{Info.Ruta}<T>    AND<BR>eDocInRutaDCondicion.GUID = <T>{Info.Clave}<T>
[eDocInRutaDCondicion.eDocInRutaDCondicion.Operando1]
Carpeta=eDocInRutaDCondicion
Clave=eDocInRutaDCondicion.Operando1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
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
Tamano=255
ColorFondo=Blanco


[eDocInRutaDCondicion.Columnas]
Operando1=183
Operador=174
Operando2=304


OperadorLogico=80
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





























[eDocInRutaDCondicion.ListaEnCaptura]
(Inicio)=eDocInRutaDCondicion.Operando1
eDocInRutaDCondicion.Operando1=eDocInRutaDCondicion.Operador
eDocInRutaDCondicion.Operador=eDocInRutaDCondicion.Operando2
eDocInRutaDCondicion.Operando2=(Fin)



































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
