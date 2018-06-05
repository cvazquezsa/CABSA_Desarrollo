[Forma]
Clave=ProdRuta
Nombre=Rutas Producción
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=688
PosicionInicialArriba=421
PosicionInicialAltura=350
PosicionInicialAncho=543
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=15
PosicionColumna1=30
PosicionInicialAlturaCliente=323
PosicionCol1=162

[Lista.Columnas]
Ruta=128
Categoria=304
Descripcion=304
TieneMovimientos=92

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
Menu=&Archivo
EnMenu=S
Carpeta=(Carpeta principal)
NombreEnBoton=S
ConfirmarAntes=S
ActivoCondicion=no ProdRuta:ProdRuta.TieneMovimientos

[Detalle.ProdRuta.Ruta]
Carpeta=Detalle
Clave=ProdRuta.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProdRuta.Descripcion]
Carpeta=Detalle
Clave=ProdRuta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProdRuta.Categoria]
Carpeta=Detalle
Clave=ProdRuta.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.RutaAlterna]
Nombre=RutaAlterna
Boton=89
NombreEnBoton=S
NombreDesplegar=Rutas &Alternas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProdRutaAlterna
Activo=S
Visible=S
Antes=S
ConCondicion=S
Menu=&Edición
EnMenu=S
EjecucionCondicion=ConDatos(ProdRuta:ProdRuta.Ruta)
AntesExpresiones=Asigna(Info.Ruta, ProdRuta:ProdRuta.Ruta)<BR>Asigna(Info.Descripcion, ProdRuta:ProdRuta.Descripcion)

[Acciones.Categorias]
Nombre=Categorias
Boton=91
NombreDesplegar=&Categorías
TipoAccion=Formas
ClaveAccion=ProdRutaCat
Activo=S
Visible=S
Menu=&Maestros
EnMenu=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[(Carpeta Abrir).ProdRuta.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=ProdRuta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=96
1=291

[Ficha]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Ruta
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ProdRuta
Fuente={MS Sans Serif, 8, Negro, []}
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

[Ficha.ProdRuta.Ruta]
Carpeta=Ficha
Clave=ProdRuta.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProdRuta.Descripcion]
Carpeta=Ficha
Clave=ProdRuta.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Ficha.ProdRuta.Categoria]
Carpeta=Ficha
Clave=ProdRuta.Categoria
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S
GuardarAntes=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nueva
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
Carpeta=(Carpeta principal)
NombreEnBoton=S
EspacioPrevio=S

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

[Detalle.ProdRutaD.Orden]
Carpeta=Detalle
Clave=ProdRutaD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProdRutaD.Centro]
Carpeta=Detalle
Clave=ProdRutaD.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Centro.Tipo]
Carpeta=Detalle
Clave=Centro.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Detalle.ProdRutaD.Operacion]
Carpeta=Detalle
Clave=ProdRutaD.Operacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProdRutaD.TiempoFijo]
Carpeta=Detalle
Clave=ProdRutaD.TiempoFijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.ProdRutaD.TiempoVariable]
Carpeta=Detalle
Clave=ProdRutaD.TiempoVariable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.ProdRutaD.Costo]
Carpeta=Detalle
Clave=ProdRutaD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProdRutaD.Moneda]
Carpeta=Detalle
Clave=ProdRutaD.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProdRutaD.UnidadT]
Carpeta=Detalle
Clave=ProdRutaD.UnidadT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Columnas]
Orden=38
Centro=81
Tipo=112
Operacion=105
TiempoFijo=64
TiempoVariable=79
Costo=75
Moneda=57
UnidadT=54

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdRuta
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=ProdRuta.Ruta
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ProdRutaCat
FiltroAplicaEn1=ProdRuta.Categoria
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroTodo=S
FiltroAplicaEn=ProdRuta.Categoria
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=ProdRutaCat
FiltroEstilo=Lista (Arriba)

[Lista.ProdRuta.Ruta]
Carpeta=Lista
Clave=ProdRuta.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ruta]
Nombre=Ruta
Boton=47
NombreEnBoton=S
NombreDesplegar=&Ruta
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProdRutaD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ProdRuta:ProdRuta.Ruta)
Antes=S
AntesExpresiones=Asigna(Info.Ruta, ProdRuta:ProdRuta.Ruta)<BR>Asigna(Info.Descripcion, ProdRuta:ProdRuta.Descripcion)
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Ruta
Ruta=RutaAlterna
RutaAlterna=Categorias
Categorias=Cerrar
Cerrar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=ProdRuta.Ruta
ProdRuta.Ruta=ProdRuta.Descripcion
ProdRuta.Descripcion=ProdRuta.Categoria
ProdRuta.Categoria=(Fin)
