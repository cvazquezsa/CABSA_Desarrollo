
[Forma]
Clave=IntelisisLic
Icono=0
Modulos=(Todos)
Nombre=Licencimientos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=289
PosicionInicialArriba=103
PosicionInicialAlturaCliente=526
PosicionInicialAncho=788
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IntelisisLic
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
(Inicio)=IntelisisLic.Licenciamiento
IntelisisLic.Licenciamiento=IntelisisLic.Descripcion
IntelisisLic.Descripcion=(Fin)

[Lista.IntelisisLic.Licenciamiento]
Carpeta=Lista
Clave=IntelisisLic.Licenciamiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.IntelisisLic.Descripcion]
Carpeta=Lista
Clave=IntelisisLic.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

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
Licenciamiento=256
Descripcion=494

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Formas
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=IntelisisLicForma
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(IntelisisLic:IntelisisLic.Licenciamiento)
Antes=S
AntesExpresiones=Asigna(Info.Clave, IntelisisLic:IntelisisLic.Licenciamiento)
Visible=S















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalle
Detalle=(Fin)
