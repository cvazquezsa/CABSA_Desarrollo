
[Forma]
Clave=MFAArt
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=MFA - Artículo
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaAcciones=Aceptar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
CarpetasMultilinea=S
PosicionInicialIzquierda=105
PosicionInicialArriba=74
PosicionInicialAlturaCliente=541
PosicionInicialAncho=1077
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

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAArt
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
PestanaOtroNombre=S
PestanaNombre=Registros
PermiteEditar=S
ListaEnCaptura=(Lista)


[Lista.MFAArt.Articulo]
Carpeta=Lista
Clave=MFAArt.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAArt.IEPSNumReporte]
Carpeta=Lista
Clave=MFAArt.IEPSNumReporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAArt.IEPSCategoriaConcepto]
Carpeta=Lista
Clave=MFAArt.IEPSCategoriaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAArt.IEPSExento]
Carpeta=Lista
Clave=MFAArt.IEPSExento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFAArt.IEPSEnvaseReutilizable]
Carpeta=Lista
Clave=MFAArt.IEPSEnvaseReutilizable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFAIEPSNumReporte.Descripcion]
Carpeta=Lista
Clave=MFAIEPSNumReporte.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.MFAIEPSCategoriaConcepto.Descripcion]
Carpeta=Lista
Clave=MFAIEPSCategoriaConcepto.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Lista.Columnas]
Articulo=85
IEPSNumReporte=111
Descripcion=144
IEPSCategoriaConcepto=124
Descripcion_1=124
IEPSExento=64
IEPSEnvaseReutilizable=96

Descripcion1=126
0=-2
1=551

Impuesto=76
UnidadBaseIEPS=74
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.MFAArt.Impuesto]
Carpeta=Lista
Clave=MFAArt.Impuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=MFAArt.Articulo
MFAArt.Articulo=Art.Descripcion1
Art.Descripcion1=MFAArt.IEPSNumReporte
MFAArt.IEPSNumReporte=MFAIEPSNumReporte.Descripcion
MFAIEPSNumReporte.Descripcion=MFAArt.IEPSCategoriaConcepto
MFAArt.IEPSCategoriaConcepto=MFAIEPSCategoriaConcepto.Descripcion
MFAIEPSCategoriaConcepto.Descripcion=MFAArt.IEPSExento
MFAArt.IEPSExento=MFAArt.IEPSEnvaseReutilizable
MFAArt.IEPSEnvaseReutilizable=MFAArt.UnidadBaseIEPS
MFAArt.UnidadBaseIEPS=MFAArt.Impuesto
MFAArt.Impuesto=(Fin)

[Lista.MFAArt.UnidadBaseIEPS]
Carpeta=Lista
Clave=MFAArt.UnidadBaseIEPS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
