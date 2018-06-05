[Forma]
Clave=Ruta
Nombre=Rutas Embarque
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=535
PosicionInicialArriba=353
PosicionInicialAltura=350
PosicionInicialAncho=883
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlCerrar=Asigna(Info.Ruta, Nulo)
PosicionInicialAlturaCliente=459

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Ruta
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoFondoColor=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
CampoColorFondo=Blanco
HojaTitulos=S
HojaMostrarColumnas=S
OtroOrden=S
ListaOrden=Ruta.Zona<TAB>(Acendente)

[Lista.Ruta.Ruta]
Carpeta=Lista
Clave=Ruta.Ruta
Tamano=50
3D=S
Editar=S
ColorFondo=Blanco
ColorFuente=Negro

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
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Ruta:Ruta.Ruta)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Lista.Columnas]
Ruta=210
OrdenEmbarque=86
Zona=177
TiempoEntrega=79
TiempoEntregaUnidad=64
Kms=54
Costo=101

AlmacenD=64
AlmacenA=64
0=91
1=267
SucursalD=79
SucursalA=83
[Lista.Ruta.Zona]
Carpeta=Lista
Clave=Ruta.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Lista.Ruta.TiempoEntrega]
Carpeta=Lista
Clave=Ruta.TiempoEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Ruta.TiempoEntregaUnidad]
Carpeta=Lista
Clave=Ruta.TiempoEntregaUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CteRutaOrdenar]
Nombre=CteRutaOrdenar
Boton=47
NombreEnBoton=S
NombreDesplegar=&Clientes Ruta
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteRutaOrdenar
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Ruta:Ruta.Ruta)
AntesExpresiones=Asigna(Info.Ruta, Ruta:Ruta.Ruta)

[Lista.Ruta.Kms]
Carpeta=Lista
Clave=Ruta.Kms
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Ruta.Costo]
Carpeta=Lista
Clave=Ruta.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CodigoPostal]
Nombre=CodigoPostal
Boton=47
NombreEnBoton=S
NombreDesplegar=Codigos &Postales Ruta
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CodigoPostal
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(Ruta:Ruta.Ruta)
AntesExpresiones=Asigna(Info.Ruta, Ruta:Ruta.Ruta)



[Lista.ListaOrden]
(Inicio)=Ruta.Zona<TAB>(Acendente)
Ruta.Zona<TAB>(Acendente)=Ruta.Ruta<TAB>(Acendente)
Ruta.Ruta<TAB>(Acendente)=(Fin)










[Lista.ListaEnCaptura]
(Inicio)=Ruta.Ruta
Ruta.Ruta=Ruta.Zona
Ruta.Zona=Ruta.TiempoEntrega
Ruta.TiempoEntrega=Ruta.TiempoEntregaUnidad
Ruta.TiempoEntregaUnidad=Ruta.Kms
Ruta.Kms=Ruta.Costo
Ruta.Costo=Ruta.SucursalD
Ruta.SucursalD=Ruta.SucursalA
Ruta.SucursalA=(Fin)

[Lista.Ruta.SucursalD]
Carpeta=Lista
Clave=Ruta.SucursalD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Ruta.SucursalA]
Carpeta=Lista
Clave=Ruta.SucursalA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CteRutaOrdenar
CteRutaOrdenar=CodigoPostal
CodigoPostal=Excel
Excel=(Fin)
