
[Forma]
Clave=NomXG4
Icono=34
Modulos=(Todos)
Nombre=Nomina G4

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=2042
PosicionInicialArriba=42
PosicionInicialAlturaCliente=272
PosicionInicialAncho=567
PosicionCol1=229
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomX
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=NomX.Nombre
CarpetaVisible=S

HojaMantenerSeleccion=S
[Lista.NomX.Nombre]
Carpeta=Lista
Clave=NomX.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NomX
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Detalle.NomX.Nombre]
Carpeta=Detalle
Clave=NomX.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.NomX.NomMov]
Carpeta=Detalle
Clave=NomX.NomMov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[Detalle.NomX.TipoNominaG4]
Carpeta=Detalle
Clave=NomX.TipoNominaG4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco






[Lista.Columnas]
Nombre=196


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S


NombreEnBoton=S
[Acciones.Cerrar]
Nombre=Cerrar
Boton=5
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





NombreEnBoton=S
EspacioPrevio=S
[Acciones.Configuracion]
Nombre=Configuracion
Boton=93
NombreEnBoton=S
NombreDesplegar=Config. &General
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NominaConceptoEx
Activo=S
Visible=S







EspacioPrevio=S












GuardarAntes=S
Antes=S
DespuesGuardar=S

AntesExpresiones=Asigna( Info.ABC, <T>[Configuracion]<T> )<BR>Asigna( Info.ID,0 )
[Detalle.ListaEnCaptura]
(Inicio)=NomX.Nombre
NomX.Nombre=NomX.NomMov
NomX.NomMov=NomX.TipoNominaG4
NomX.TipoNominaG4=(Fin)







































































































[Acciones.ConfigConceptos]
Nombre=ConfigConceptos
Boton=93
NombreEnBoton=S
NombreDesplegar=Config. Conce&ptos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NominaConceptoEx
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
































AntesExpresiones=Asigna( Info.ABC, NomX:NomX.TipoNominaG4 )<BR>Asigna( Info.ID, NomX:NomX.ID )
[Acciones.NominaG4Grupos]
Nombre=NominaG4Grupos
Boton=57
NombreEnBoton=S
NombreDesplegar=&Grupos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NominaG4Grupos
Activo=S
Visible=S























[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cerrar
Cerrar=Configuracion
Configuracion=ConfigConceptos
ConfigConceptos=NominaG4Grupos
NominaG4Grupos=(Fin)
