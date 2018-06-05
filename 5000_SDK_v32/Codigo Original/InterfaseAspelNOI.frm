
[Forma]
Clave=InterfaseAspelNOI
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=InterfaseAspelNOI
BarraHerramientas=S
Nombre=Interfase NOI
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=InterfaseAspelNOI
ListaAcciones=(Lista)
PosicionInicialIzquierda=378
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=843
ExpresionesAlCerrar=EjecutarSQL(<T>spNOIActualizarConcepto :tEmpresa<T>,Empresa)
[InterfaseAspelNOI]
Estilo=Hoja
Clave=InterfaseAspelNOI
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InterfaseAspelNOI
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
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=InterfaseAspelNOI.Empresa = <T>{Info.Empresa}<T>
[InterfaseAspelNOI.InterfaseAspelNOI.TipoPeriodo]
Carpeta=InterfaseAspelNOI
Clave=InterfaseAspelNOI.TipoPeriodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[InterfaseAspelNOI.InterfaseAspelNOI.CtaDinero]
Carpeta=InterfaseAspelNOI
Clave=InterfaseAspelNOI.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[InterfaseAspelNOI.InterfaseAspelNOI.Moneda]
Carpeta=InterfaseAspelNOI
Clave=InterfaseAspelNOI.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[InterfaseAspelNOI.InterfaseAspelNOI.Concepto]
Carpeta=InterfaseAspelNOI
Clave=InterfaseAspelNOI.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[InterfaseAspelNOI.InterfaseAspelNOI.ConceptoDIN]
Carpeta=InterfaseAspelNOI
Clave=InterfaseAspelNOI.ConceptoDIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[InterfaseAspelNOI.InterfaseAspelNOI.MovNomina]
Carpeta=InterfaseAspelNOI
Clave=InterfaseAspelNOI.MovNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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

[InterfaseAspelNOI.Columnas]
TipoPeriodo=124
CtaDinero=64
Moneda=64
Concepto=227
ConceptoDIN=197
MovNomina=124


[Lista.Columnas]
Concepto=218
0=66
1=261
2=-2

[Acciones.NOITipoEmpleado]
Nombre=NOITipoEmpleado
Boton=80
NombreEnBoton=S
NombreDesplegar=Tipos &Personal
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NOITipoEmpleado
Activo=S
Visible=S








EspacioPrevio=S
[Acciones.NOIFormaPago]
Nombre=NOIFormaPago
Boton=47
NombreEnBoton=S
NombreDesplegar=&Formas Pago
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NOIFormaPago
Activo=S
Visible=S








[InterfaseAspelNOI.ListaEnCaptura]
(Inicio)=InterfaseAspelNOI.TipoPeriodo
InterfaseAspelNOI.TipoPeriodo=InterfaseAspelNOI.CtaDinero
InterfaseAspelNOI.CtaDinero=InterfaseAspelNOI.Moneda
InterfaseAspelNOI.Moneda=InterfaseAspelNOI.Concepto
InterfaseAspelNOI.Concepto=InterfaseAspelNOI.ConceptoDIN
InterfaseAspelNOI.ConceptoDIN=InterfaseAspelNOI.MovNomina
InterfaseAspelNOI.MovNomina=(Fin)

















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=NOITipoEmpleado
NOITipoEmpleado=NOIFormaPago
NOIFormaPago=(Fin)
