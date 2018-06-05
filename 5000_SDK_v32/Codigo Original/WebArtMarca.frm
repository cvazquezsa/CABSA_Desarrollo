
[Forma]
Clave=WebArtMarca
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Detalle
BarraHerramientas=S
Nombre=Marcas Artículos eCommerce
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=(Lista)
PosicionInicialIzquierda=369
PosicionInicialArriba=172
PosicionInicialAlturaCliente=478
PosicionInicialAncho=862
PosicionCol1=222
PosicionColumna1=26

SinTransacciones=S
[WebArtMarca]
Estilo=Hoja
Clave=WebArtMarca
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtMarca
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebArtMarca.Nombre
CarpetaVisible=S

HojaIndicador=S
OtroOrden=S
ListaOrden=WebArtMarca.Orden<TAB>(Acendente)
PermiteEditar=S
[WebArtMarca.WebArtMarca.Nombre]
Carpeta=WebArtMarca
Clave=WebArtMarca.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=WebArtMarca
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

[Detalle.WebArtMarca.Nombre]
Carpeta=Detalle
Clave=WebArtMarca.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

IgnoraFlujo=N
[Detalle.WebArtMarca.Titulo]
Carpeta=Detalle
Clave=WebArtMarca.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco


[WebArtMarca.Columnas]
Nombre=189

[Acciones.Registro Insertar]
Nombre=Registro Insertar
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
EspacioPrevio=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Info.Estado,SQL(<T>SELECT dbo.fneWebVerificarWebArtMarca(:nID)<T>,WebArtMarca:WebArtMarca.ID))<BR>Vacio(Info.Estado)
EjecucionMensaje=Info.Estado


[Acciones.Orden]
Nombre=Orden
Boton=50
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
DespuesGuardar=S
Visible=S

EspacioPrevio=S
AntesExpresiones=FormaModal(<T>WebArtMarcaOrdenar<T>)
[Lista.Columnas]
0=49
1=434
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=AvanzarCaptura<BR>GuardarCambios
ConCondicion=S
EjecucionCondicion=SQL(<T>SELECT dbo.fneWebValidarNombre(:tNombre)<T>,WebArtMarca:WebArtMarca.Nombre)
EjecucionMensaje= <T>El Campo Nombre Debe Tener Valor<T>
EjecucionConError=S
[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
















































































[Detalle.ListaEnCaptura]
(Inicio)=WebArtMarca.Nombre
WebArtMarca.Nombre=WebArtMarca.Titulo
WebArtMarca.Titulo=(Fin)





















[Forma.ListaCarpetas]
(Inicio)=WebArtMarca
WebArtMarca=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cerrar
Cerrar=Registro Insertar
Registro Insertar=Registro Eliminar
Registro Eliminar=Orden
Orden=(Fin)
