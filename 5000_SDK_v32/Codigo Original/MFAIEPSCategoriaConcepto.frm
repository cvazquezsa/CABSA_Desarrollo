
[Forma]
Clave=MFAIEPSCategoriaConcepto
Icono=0
Modulos=(Todos)
Nombre=MFA - Categoría IEPS
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=257
PosicionInicialArriba=122
PosicionInicialAlturaCliente=446
PosicionInicialAncho=766
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S

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
Vista=MFAIEPSCategoriaConcepto
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
(Inicio)=MFAIEPSCategoriaConcepto.Categoria
MFAIEPSCategoriaConcepto.Categoria=MFAIEPSCategoriaConcepto.Descripcion
MFAIEPSCategoriaConcepto.Descripcion=(Fin)

[Lista.MFAIEPSCategoriaConcepto.Categoria]
Carpeta=Lista
Clave=MFAIEPSCategoriaConcepto.Categoria
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

[Lista.Columnas]
Categoria=124
Descripcion=604
