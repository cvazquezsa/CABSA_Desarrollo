[Forma]
Clave=Anuncio
Nombre=Anuncios
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=374
PosicionInicialAncho=709
PosicionInicialIzquierda=157
PosicionInicialArriba=197
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
MenuPrincipal=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Anuncio
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
ListaEnCaptura=(Lista)
PermiteEditar=S
ValidarCampos=S
ListaCamposAValidar=Prov.Nombre

[Lista.Columnas]
Anuncio=198
Archivo=212
Proveedor=73
FechaD=99
FechaA=94
Proveedor_1=64
Nombre=364
Estatus=94

[Detalle.Anuncio.Anuncio]
Carpeta=Detalle
Clave=Anuncio.Anuncio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Anuncio.Archivo]
Carpeta=Detalle
Clave=Anuncio.Archivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Anuncio.Proveedor]
Carpeta=Detalle
Clave=Anuncio.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Prov.Nombre]
Carpeta=Detalle
Clave=Prov.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=29
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Anuncio.FechaD]
Carpeta=Detalle
Clave=Anuncio.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Anuncio.FechaA]
Carpeta=Detalle
Clave=Anuncio.FechaA
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Anuncio.Anuncio]
Carpeta=Lista
Clave=Anuncio.Anuncio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Anuncio.Archivo]
Carpeta=Lista
Clave=Anuncio.Archivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Anuncio.Proveedor]
Carpeta=Lista
Clave=Anuncio.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Anuncio.FechaD]
Carpeta=Lista
Clave=Anuncio.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Anuncio.FechaA]
Carpeta=Lista
Clave=Anuncio.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar Cambios
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Anuncio:Anuncio.Anuncio)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Horario]
Nombre=Horario
Boton=0
Menu=&Maestros
NombreDesplegar=&Horarios
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnuncioHorario
Activo=S
Visible=S

[Acciones.AnuncioD]
Nombre=AnuncioD
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Horarios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnuncioD
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Anuncio:Anuncio.Anuncio)
AntesExpresiones=Asigna(Info.Anuncio, Anuncio:Anuncio.Anuncio)

[Acciones.Art]
Nombre=Art
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=Artículos E&specíficos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnuncioArt
Activo=S
Visible=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(Anuncio:Anuncio.Anuncio)
AntesExpresiones=Asigna(Info.Anuncio, Anuncio:Anuncio.Anuncio)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Cerrar
Cerrar=Horario
Horario=AnuncioD
AnuncioD=Art
Art=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Maestros
&Maestros=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Anuncio.Anuncio
Anuncio.Anuncio=Anuncio.Archivo
Anuncio.Archivo=Anuncio.FechaD
Anuncio.FechaD=Anuncio.FechaA
Anuncio.FechaA=Anuncio.Proveedor
Anuncio.Proveedor=(Fin)
