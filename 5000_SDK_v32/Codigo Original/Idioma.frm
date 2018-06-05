[Forma]
Clave=Idioma
Nombre=Otros Idiomas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=485
PosicionInicialArriba=284
PosicionInicialAltura=324
PosicionInicialAncho=469
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=297
PosicionCol1=272

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Idioma
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=Idioma.Orden<TAB>(Acendente)
HojaMantenerSeleccion=S
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.Idioma.Idioma]
Carpeta=Lista
Clave=Idioma.Idioma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Idioma=240
Orden=38
SinAcentos=82
AutoAgregar=108

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
AntesExpresiones=Forma(<T>IdiomaOrdenar<T>)

[Acciones.Etiquetas]
Nombre=Etiquetas
Boton=47
NombreEnBoton=S
NombreDesplegar=&Etiquetas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=IdiomaEtiqueta
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Idioma:Idioma.Idioma)
AntesExpresiones=Asigna(Info.Idioma, Idioma:Idioma.Idioma)

[Detalles.Idioma.SinAcentos]
Carpeta=Detalles
Clave=Idioma.SinAcentos
Editar=S
LineaNueva=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.Idioma.AutoAgregar]
Carpeta=Detalles
Clave=Idioma.AutoAgregar
Editar=S
LineaNueva=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Idioma.SinAcentos]
Carpeta=Lista
Clave=Idioma.SinAcentos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Idioma.AutoAgregar]
Carpeta=Lista
Clave=Idioma.AutoAgregar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Campos]
Nombre=Campos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Campos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=IdiomaCampo
Activo=S
ConCondicion=S
Visible=S
Antes=S
EjecucionCondicion=ConDatos(Idioma:Idioma.Idioma)
AntesExpresiones=Asigna(Info.Idioma, Idioma:Idioma.Idioma)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Etiquetas
Etiquetas=Campos
Campos=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Idioma.Idioma
Idioma.Idioma=Idioma.SinAcentos
Idioma.SinAcentos=Idioma.AutoAgregar
Idioma.AutoAgregar=(Fin)
