
[Forma]
Clave=POSCBExpresion
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=POS Expresiones
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSCBExpresion
CarpetaPrincipal=POSCBExpresion
PosicionInicialAlturaCliente=273
PosicionInicialAncho=734
ListaAcciones=Guardar y Cerrar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=316
PosicionInicialArriba=229
[POSCBExpresion]
Estilo=Hoja
Clave=POSCBExpresion
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCBExpresion
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
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=POSCBExpresion.TipoCuenta = <T>Expresion<T>
[POSCBExpresion.POSCBExpresion.Codigo]
Carpeta=POSCBExpresion
Clave=POSCBExpresion.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[POSCBExpresion.Columnas]
Codigo=100
Accion=154


Expresion=604
[Acciones.Guardar y Cerrar]
Nombre=Guardar y Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[POSCBExpresion.POSCBExpresion.Expresion]
Carpeta=POSCBExpresion
Clave=POSCBExpresion.Expresion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[POSCBExpresion.ListaEnCaptura]
(Inicio)=POSCBExpresion.Codigo
POSCBExpresion.Codigo=POSCBExpresion.Expresion
POSCBExpresion.Expresion=(Fin)

[FormaExtraValor.Columnas]
VerCampo=285
VerValor=316

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[(Carpeta Abrir).Columnas]
0=131
1=282
