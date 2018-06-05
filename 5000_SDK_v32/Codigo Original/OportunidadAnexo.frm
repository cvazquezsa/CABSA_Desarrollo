
[Forma]
Clave=OportunidadAnexo
Icono=4
Modulos=(Todos)
Nombre=Anexos Correo Electrónico

ListaCarpetas=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Detalle
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Anuncio)
PosicionInicialIzquierda=234
PosicionInicialArriba=130
PosicionInicialAlturaCliente=430
PosicionInicialAncho=897
PosicionCol1=478
MovModulo=OPORT
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadAnexo
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

HojaMantenerSeleccion=S


FiltroGeneral=OportunidadAnexo.Plantilla = {Comillas(Info.Anuncio)}
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=OportunidadAnexo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Detalle



[Lista.Columnas]
SeccionDestinatario=124
TipoDestinatario=124















Tipo=133
Ruta=141
Nombre=160
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S







NombreEnBoton=S
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S











NombreEnBoton=S









ConfirmarAntes=S




[Lista.OportunidadAnexo.Tipo]
Carpeta=Lista
Clave=OportunidadAnexo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.OportunidadAnexo.Ruta]
Carpeta=Lista
Clave=OportunidadAnexo.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.OportunidadAnexo.Nombre]
Carpeta=Lista
Clave=OportunidadAnexo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Detalle.OportunidadAnexo.Tipo]
Carpeta=Detalle
Clave=OportunidadAnexo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.OportunidadAnexo.Ruta]
Carpeta=Detalle
Clave=OportunidadAnexo.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.OportunidadAnexo.Nombre]
Carpeta=Detalle
Clave=OportunidadAnexo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[Detalle.ListaEnCaptura]
(Inicio)=OportunidadAnexo.Tipo
OportunidadAnexo.Tipo=OportunidadAnexo.Ruta
OportunidadAnexo.Ruta=OportunidadAnexo.Nombre
OportunidadAnexo.Nombre=(Fin)

















[Acciones.OportunidadTagAyuda]
Nombre=OportunidadTagAyuda
Boton=101
NombreEnBoton=S
NombreDesplegar=&Ayuda Etiquetas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OportunidadTagAyuda
Activo=S
Visible=S









[Lista.ListaEnCaptura]
(Inicio)=OportunidadAnexo.Tipo
OportunidadAnexo.Tipo=OportunidadAnexo.Ruta
OportunidadAnexo.Ruta=OportunidadAnexo.Nombre
OportunidadAnexo.Nombre=(Fin)

















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=OportunidadTagAyuda
OportunidadTagAyuda=(Fin)
