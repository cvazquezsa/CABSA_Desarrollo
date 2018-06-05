
[Forma]
Clave=MFAConceptoGas2
Icono=0
Modulos=(Todos)
Nombre=MFA - Concepto
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=194
PosicionInicialArriba=113
PosicionInicialAlturaCliente=482
PosicionInicialAncho=892
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
PestanaOtroNombre=S
PestanaNombre=Registros
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAConceptoGas2
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
[Lista.ListaEnCaptura]
(Inicio)=MFAConceptoGas2.ConceptoGas
MFAConceptoGas2.ConceptoGas=MFAConceptoGas2.IEPSNumReporte
MFAConceptoGas2.IEPSNumReporte=MFAIEPSNumReporte.Descripcion
MFAIEPSNumReporte.Descripcion=MFAConceptoGas2.IEPSCategoriaConcepto
MFAConceptoGas2.IEPSCategoriaConcepto=MFAIEPSCategoriaConcepto.Descripcion
MFAIEPSCategoriaConcepto.Descripcion=MFAConceptoGas2.IEPSExento
MFAConceptoGas2.IEPSExento=MFAConceptoGas2.IEPSEnvaseReutilizable
MFAConceptoGas2.IEPSEnvaseReutilizable=(Fin)

[Lista.MFAConceptoGas2.ConceptoGas]
Carpeta=Lista
Clave=MFAConceptoGas2.ConceptoGas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFAConceptoGas2.IEPSNumReporte]
Carpeta=Lista
Clave=MFAConceptoGas2.IEPSNumReporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[Lista.MFAConceptoGas2.IEPSCategoriaConcepto]
Carpeta=Lista
Clave=MFAConceptoGas2.IEPSCategoriaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[Lista.MFAConceptoGas2.IEPSExento]
Carpeta=Lista
Clave=MFAConceptoGas2.IEPSExento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFAConceptoGas2.IEPSEnvaseReutilizable]
Carpeta=Lista
Clave=MFAConceptoGas2.IEPSEnvaseReutilizable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
ConceptoGas=120
IEPSNumReporte=83
Descripcion=166
IEPSCategoriaConcepto=119
Descripcion_1=182
IEPSExento=64
IEPSEnvaseReutilizable=118
Concepto=218
0=-2
1=551
