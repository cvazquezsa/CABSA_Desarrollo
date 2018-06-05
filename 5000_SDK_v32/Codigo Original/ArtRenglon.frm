[Forma]
Clave=ArtRenglon
Nombre=Lista de Renglones
Icono=0
Modulos=INV
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=331
PosicionInicialArriba=222
PosicionInicialAltura=324
PosicionInicialAncho=362
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
BarraHerramientas=S
ListaCarpetas=Lista

[Lista.ArtRenglon.Renglon]
Carpeta=Lista
Clave=ArtRenglon.Renglon
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtRenglon.Descripcion]
Carpeta=Lista
Clave=ArtRenglon.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Renglon=115
Descripcion=218

[ArtRenglon.ArtRenglon.Renglon]
Carpeta=Renglon
Clave=ArtRenglon.Renglon
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[ArtRenglon.Columnas]
Renglon=134
Descripcion=193
Nombre=199

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
Icono=0
NombreDesplegar=&Guardar Cambios
EnBarraAcciones=Si
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Expresion=
SQL=
ListaParametros=Si
Visible=Si
VisibleCondicion=
Activo=Si
ActivoCondicion=
EjecucionCondicion=
EjecucionMensaje=
AntesExpresiones=

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtRenglon:ArtRenglon.Renglon)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[ArtRenglon.ArtRenglon.Descripcion]
Carpeta=Renglon
Clave=ArtRenglon.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
EspacioPrevio=S
ActivoCondicion=Usuario.EnviarExcel

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtRenglon
Fuente={MS Sans Serif, 8, Negro, []}
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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtRenglon.Renglon
ArtRenglon.Renglon=ArtRenglon.Descripcion
ArtRenglon.Descripcion=(Fin)
