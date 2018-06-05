[Forma]
Clave=MovRecibo
Nombre=Recepción
Icono=0
Modulos=(Todos)
AccionesTamanoBoton=20x5
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=414
PosicionInicialAncho=733
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=273
PosicionInicialArriba=288
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
AccionesIzq=S
BarraAcciones=S
BarraHerramientas=S
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaExclusiva=S
VentanaEscCerrar=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
AntesExpresiones=Si(Info.PuedeEditar, EjecutarSQL(<T>spMovReciboAceptar :tModulo, :nID, :tAplica, :tAplicaID<T>, Info.Modulo, Info.ID, Info.Mov, Info.MovID))

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovReciboResumen
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Artículos
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
MenuLocal=S
ListaAcciones=Eliminar
IconosNombre=MovReciboResumen:Articulo

[Lista.Unidad]
Carpeta=Lista
Clave=Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Costo]
Carpeta=Lista
Clave=Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Lote]
Carpeta=Lista
Clave=Lote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Caducidad]
Carpeta=Lista
Clave=Caducidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cantidad]
Carpeta=Lista
Clave=Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Descripcion1]
Carpeta=Lista
Clave=Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=108
1=185
Articulo=124
Descripcion1=197
Cantidad=48
Unidad=46
Costo=103
Lote=91
Caducidad=79

[Acciones.Agregar]
Nombre=Agregar
Boton=62
NombreDesplegar=Agrega&r...
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Visible=S
EnBarraAcciones=S
ConCondicion=S
EnBarraHerramientas=S
NombreEnBoton=S
ActivoCondicion=Info.PuedeEditar
EjecucionCondicion=Forma(<T>MovReciboAgregar<T>)

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=0
NombreDesplegar=Eliminar
EnMenu=S
ConfirmarAntes=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Visible=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Actualizar Vista
ActivoCondicion=Info.PuedeEditar

[Acciones.Eliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spMovReciboEliminar :tModulo, :nID, :tArt, :tSub, :tUnidad, :nCosto, :tLote, :fCad<T>, <BR>Info.Modulo, Info.ID, MovReciboResumen:Articulo, MovReciboResumen:SubCuenta, MovReciboResumen:Unidad, MovReciboResumen:Costo, MovReciboResumen:Lote, MovReciboResumen:Caducidad)

[Acciones.Eliminar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Agregar
Agregar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Descripcion1
Descripcion1=Cantidad
Cantidad=Unidad
Unidad=Costo
Costo=Lote
Lote=Caducidad
Caducidad=(Fin)
