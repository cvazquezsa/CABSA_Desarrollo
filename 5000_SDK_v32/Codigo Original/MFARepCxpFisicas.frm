
[Forma]
Clave=MFARepCxpFisicas
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Personas Físicas
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
PosicionInicialIzquierda=395
PosicionInicialArriba=183
PosicionInicialAlturaCliente=324
PosicionInicialAncho=576
ListaCarpetas=Datos
CarpetaPrincipal=Datos
Comentarios=Empresa

[Datos]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Datos
Clave=Datos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFARepCxpFisicas
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S


ListaEnCaptura=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=MFARepCxpFisicas.Empresa = <T>{Empresa}<T>
FiltroRespetar=S
FiltroTipo=General
[Datos.Columnas]
IncluirConcluidos=87

Estatus=94
Concepto=388
[Acciones.MFARepCxpFisicasAdicion]
Nombre=MFARepCxpFisicasAdicion
Boton=30
NombreEnBoton=S
NombreDesplegar=Adiciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MFARepCxpFisicasAdicion
Activo=S
Visible=S


[Acciones.MFARepCxpFisicasExcepcion]
Nombre=MFARepCxpFisicasExcepcion
Boton=31
NombreEnBoton=S
NombreDesplegar=Excepciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MFARepCxpFisicasExcepcion
Activo=S
Visible=S




[Acciones.MFARepCxpFisicasClaseSubClase]
Nombre=MFARepCxpFisicasClaseSubClase
Boton=18
NombreEnBoton=S
NombreDesplegar=Clasificaciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MFARepCxpFisicasClaseSubClase
Activo=S
Visible=S




[Acciones.MFARepCxpFisicasFiscalRegimen]
Nombre=MFARepCxpFisicasFiscalRegimen
Boton=74
NombreEnBoton=S
NombreDesplegar=Regímenes Fiscales
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MFARepCxpFisicasFiscalRegimen
Activo=S
Visible=S



















































[Datos.MFARepCxpFisicas.Estatus]
Carpeta=Datos
Clave=MFARepCxpFisicas.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Datos.MFARepCxpFisicas.Concepto]
Carpeta=Datos
Clave=MFARepCxpFisicas.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



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










[Datos.ListaEnCaptura]
(Inicio)=MFARepCxpFisicas.Estatus
MFARepCxpFisicas.Estatus=MFARepCxpFisicas.Concepto
MFARepCxpFisicas.Concepto=(Fin)















[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=MFARepCxpFisicasAdicion
MFARepCxpFisicasAdicion=MFARepCxpFisicasExcepcion
MFARepCxpFisicasExcepcion=MFARepCxpFisicasClaseSubClase
MFARepCxpFisicasClaseSubClase=MFARepCxpFisicasFiscalRegimen
MFARepCxpFisicasFiscalRegimen=(Fin)
