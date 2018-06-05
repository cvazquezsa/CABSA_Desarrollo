
[Forma]
Clave=MovSituacionBinariaCondicion
Icono=166
Modulos=(Todos)
Nombre=<T>Condiciones - <T>+Info.Situacion

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=358
PosicionInicialAncho=665
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=350
PosicionInicialArriba=166
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=GuardarCerrar
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovSituacionBinariaCondicion
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

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=MovSituacionBinariaCondicion.ID={Info.ID}
[Lista.MovSituacionBinariaCondicion.Expresion1]
Carpeta=Lista
Clave=MovSituacionBinariaCondicion.Expresion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MovSituacionBinariaCondicion.Operador]
Carpeta=Lista
Clave=MovSituacionBinariaCondicion.Operador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MovSituacionBinariaCondicion.Expresion2]
Carpeta=Lista
Clave=MovSituacionBinariaCondicion.Expresion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MovSituacionBinariaCondicion.Expresion3]
Carpeta=Lista
Clave=MovSituacionBinariaCondicion.Expresion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Expresion1=118
Operador=130
Expresion2=158
Expresion3=177


[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



[Lista.ListaEnCaptura]
(Inicio)=MovSituacionBinariaCondicion.Expresion1
MovSituacionBinariaCondicion.Expresion1=MovSituacionBinariaCondicion.Operador
MovSituacionBinariaCondicion.Operador=MovSituacionBinariaCondicion.Expresion2
MovSituacionBinariaCondicion.Expresion2=MovSituacionBinariaCondicion.Expresion3
MovSituacionBinariaCondicion.Expresion3=(Fin)
