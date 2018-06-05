[Forma]
Clave=Opcion
Nombre=Opciones
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=285
PosicionInicialArriba=212
PosicionInicialAltura=366
PosicionInicialAncho=710
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=339
PosicionColumna1=43
PosicionCol1=298

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Opcion
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=Opcion.Opcion<TAB>(Acendente)
HojaMantenerSeleccion=S
HojaPermiteInsertar=S

[Lista.Opcion.Opcion]
Carpeta=Lista
Clave=Opcion.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Opcion.Descripcion]
Carpeta=Lista
Clave=Opcion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Opcion=38
Descripcion=226
TieneDetalle=45
OrdenDetalle=71
AyudaCaptura=80
TipoDetalle=66
Formato=80
Rango=66
Vista=58
Periodos=82

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

[Acciones.Detalles]
Nombre=Detalles
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalles
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OpcionD
ConCondicion=S
Antes=S
Visible=S
DespuesGuardar=S
ActivoCondicion=Opcion:Opcion.TieneDetalle y (Opcion:Opcion.TipoDetalle=<T>Numero<T>)
EjecucionCondicion=ConDatos(Opcion:Opcion.Opcion)
AntesExpresiones=Asigna(Info.Opcion, Opcion:Opcion.Opcion)<BR>Asigna(Info.Descripcion, Opcion:Opcion.Descripcion)

[Acciones.Listas]
Nombre=Listas
Boton=57
NombreEnBoton=S
NombreDesplegar=Lista&s
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=OpcionLista
Visible=S
ConCondicion=S
Antes=S
DespuesGuardar=S
ActivoCondicion=Opcion:Opcion.TieneDetalle y (Opcion:Opcion.TipoDetalle=<T>Numero<T>)
EjecucionCondicion=ConDatos(Opcion:Opcion.Opcion)
AntesExpresiones=Asigna(Info.Opcion, Opcion:Opcion.Opcion)<BR>Asigna(Info.Descripcion, Opcion:Opcion.Descripcion)

[Acciones.Precios]
Nombre=Precios
Boton=64
NombreEnBoton=S
NombreDesplegar=&Precios Adicionales
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OpcionPrecio
Activo=S
Visible=S

[Acciones.Nueva]
Nombre=Nueva
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nueva
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ConfirmarAntes=S
ActivoCondicion=no Opcion:Opcion.TieneMovimientos

[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Opcion
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

[Detalle.Opcion.TieneDetalle]
Carpeta=Detalle
Clave=Opcion.TieneDetalle
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.Opcion.TipoDetalle]
Carpeta=Detalle
Clave=Opcion.TipoDetalle
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Opcion.Vista]
Carpeta=Detalle
Clave=Opcion.Vista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.Opcion.Rango]
Carpeta=Detalle
Clave=Opcion.Rango
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.Opcion.Periodos]
Carpeta=Detalle
Clave=Opcion.Periodos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=5

[Detalle.Opcion.OrdenDetalle]
Carpeta=Detalle
Clave=Opcion.OrdenDetalle
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Opcion.AyudaCaptura]
Carpeta=Detalle
Clave=Opcion.AyudaCaptura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Opcion.Opcion]
Carpeta=Detalle
Clave=Opcion.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Opcion.Descripcion]
Carpeta=Detalle
Clave=Opcion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
Efectos=[Negritas]

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Detalle.Opcion.BloquearAnteriores]
Carpeta=Detalle
Clave=Opcion.BloquearAnteriores
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=Opcion.Opcion
Opcion.Opcion=Opcion.Descripcion
Opcion.Descripcion=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=Opcion.Opcion
Opcion.Opcion=Opcion.Descripcion
Opcion.Descripcion=Opcion.DescripcionCorta
Opcion.DescripcionCorta=Opcion.TieneDetalle
Opcion.TieneDetalle=Opcion.TipoDetalle
Opcion.TipoDetalle=Opcion.AyudaCaptura
Opcion.AyudaCaptura=Opcion.OrdenDetalle
Opcion.OrdenDetalle=Opcion.Vista
Opcion.Vista=Opcion.Periodos
Opcion.Periodos=Opcion.BloquearAnteriores
Opcion.BloquearAnteriores=Opcion.Rango
Opcion.Rango=(Fin)

[Detalle.Opcion.DescripcionCorta]
Carpeta=Detalle
Clave=Opcion.DescripcionCorta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nueva
Nueva=Eliminar
Eliminar=Detalles
Detalles=Listas
Listas=Precios
Precios=Navegador
Navegador=Expresion
Expresion=(Fin)

[Acciones.Expresion]
Nombre=Expresion
Boton=92
NombreEnBoton=S
NombreDesplegar=Sincronizar Factory
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Expresion=ProcesarSQL(<T>exec spInforGenerarSolicitudOpciones null<T>)
VisibleCondicion=General.ProdInterfazINFOR