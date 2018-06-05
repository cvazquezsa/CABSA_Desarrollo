
[Forma]
Clave=NominaG4ErroresCFG
Icono=0
Modulos=(Todos)
Nombre=Log Errores Configuracion

ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=1872
PosicionInicialArriba=42
PosicionInicialAlturaCliente=273
PosicionInicialAncho=907
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaG4ErroresCFG
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

FiltroGeneral=NominaG4ErroresCFG.Estacion = {EstacionTrabajo}
[Lista.NominaG4ErroresCFG.Rama]
Carpeta=Lista
Clave=NominaG4ErroresCFG.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.NominaG4ErroresCFG.Cuenta]
Carpeta=Lista
Clave=NominaG4ErroresCFG.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.NominaG4ErroresCFG.Propiedad]
Carpeta=Lista
Clave=NominaG4ErroresCFG.Propiedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.NominaG4ErroresCFG.Descripcion]
Carpeta=Lista
Clave=NominaG4ErroresCFG.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Rama=59
Cuenta=143
Propiedad=149
Valor=125
Descripcion=387





[Lista.ListaEnCaptura]
(Inicio)=NominaG4ErroresCFG.Rama
NominaG4ErroresCFG.Rama=NominaG4ErroresCFG.Cuenta
NominaG4ErroresCFG.Cuenta=NominaG4ErroresCFG.Propiedad
NominaG4ErroresCFG.Propiedad=NominaG4ErroresCFG.Descripcion
NominaG4ErroresCFG.Descripcion=(Fin)
