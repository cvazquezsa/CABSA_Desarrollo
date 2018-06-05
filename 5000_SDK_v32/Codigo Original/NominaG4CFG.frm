
[Forma]
Clave=NominaG4CFG
Icono=0
Modulos=(Todos)
Nombre=Configuración Nomina G4

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
PosicionInicialIzquierda=300
PosicionInicialArriba=123
PosicionInicialAlturaCliente=443
PosicionInicialAncho=766
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Empresa
PosicionCol1=252
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaG4CFG
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=NominaG4CFG.NombreCSV

CarpetaVisible=S







HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=NominaG4CFG.NombreCSV<TAB>(Acendente)
[Acciones.GuardarCambios]
Nombre=GuardarCambios
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





















[Lista.NominaG4CFG.NombreCSV]
Carpeta=Lista
Clave=NominaG4CFG.NombreCSV
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=200
ColorFondo=Blanco




[Lista.Columnas]
Empresa=45
Modulo=127
NombreCSV=221
Qry=304
Params=304
Estatus=64






[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NominaG4CFG
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Detalle.NominaG4CFG.Qry]
Carpeta=Detalle
Clave=NominaG4CFG.Qry
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

Tamano=50x10
ConScroll=S
Efectos=[Negritas]
[Detalle.NominaG4CFG.Params]
Carpeta=Detalle
Clave=NominaG4CFG.Params
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

Tamano=50x10
Efectos=[Negritas]
[Lista.ListaEnCaptura]
(Inicio)=NominaG4CFG.Modulo
NominaG4CFG.Modulo=NominaG4CFG.NombreCSV
NominaG4CFG.NombreCSV=NominaG4CFG.Estatus
NominaG4CFG.Estatus=(Fin)







[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

EspacioPrevio=S


[Detalle.NominaG4CFG.NombreCSV]
Carpeta=Detalle
Clave=NominaG4CFG.NombreCSV
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.NominaG4CFG.Modulo]
Carpeta=Detalle
Clave=NominaG4CFG.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.NominaG4CFG.Estatus]
Carpeta=Detalle
Clave=NominaG4CFG.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

EspacioPrevio=S















[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

EspacioPrevio=S


























Carpeta=(Carpeta principal)









































[Detalle.ListaEnCaptura]
(Inicio)=NominaG4CFG.NombreCSV
NominaG4CFG.NombreCSV=NominaG4CFG.Qry
NominaG4CFG.Qry=NominaG4CFG.Params
NominaG4CFG.Params=NominaG4CFG.Modulo
NominaG4CFG.Modulo=NominaG4CFG.Estatus
NominaG4CFG.Estatus=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=GuardarCambios
GuardarCambios=Nuevo
Nuevo=Eliminar
Eliminar=Cerrar
Cerrar=Navegador
Navegador=(Fin)
