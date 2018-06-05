[Forma]
Clave=Zona
Nombre=<T>Zonas Embarque<T>  
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=284
PosicionInicialArriba=202
PosicionInicialAltura=356
PosicionInicialAncho=455
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionColumna1=39
PosicionInicialAlturaCliente=329

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Zona
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
PestanaOtroNombre=S
PestanaNombre=Lista
HojaAjustarColumnas=S
PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.Zona.Zona]
Carpeta=Lista
Clave=Zona.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
GuardarAntes=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Zona:Zona.Zona)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Lista.Columnas]
Zona=230
Tipo=97
OrdenEmbarque=87
Ruta=141
Porcentaje=97

[Detalle.Zona.Zona]
Carpeta=Detalle
Clave=Zona.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Zona.Ruta]
Carpeta=Detalle
Clave=Zona.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Detalle.Zona.Tipo]
Carpeta=Detalle
Clave=Zona.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Zona.OrdenEmbarque]
Carpeta=Detalle
Clave=Zona.OrdenEmbarque
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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

[Lista.Zona.Tipo]
Carpeta=Lista
Clave=Zona.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Zona.Porcentaje]
Carpeta=Lista
Clave=Zona.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Zona.Zona
Zona.Zona=Zona.Tipo
Zona.Tipo=Zona.Porcentaje
Zona.Porcentaje=(Fin)
