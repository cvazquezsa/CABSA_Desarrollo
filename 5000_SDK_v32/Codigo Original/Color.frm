[Forma]
Clave=Color
Nombre=Lista de Colores
Icono=0
Modulos=INV
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Color
PosicionInicialIzquierda=811
PosicionInicialArriba=298
PosicionInicialAltura=324
PosicionInicialAncho=297
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
CarpetaPrincipal=Color
ListaAcciones=(Lista)
BarraHerramientas=S
PosicionInicialAlturaCliente=567

[Lista.Color.Color]
Carpeta=Lista
Clave=Color.Color
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5

[Lista.Color.Descripcion]
Carpeta=Lista
Clave=Color.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Lista.Columnas]
Color=81
Descripcion=248

[Color]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Colores
Clave=Color
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Color
Fuente={MS Sans Serif, 8, Negro, []}
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaAjustarColumnas=S
CondicionEditar=FormaNormal
OtroOrden=S
ListaOrden=Color.Color<TAB>(Acendente)
HojaConfirmarEliminar=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S

[Color.Color.Color]
Carpeta=Color
Clave=Color.Color
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Color.Columnas]
Color=197
Descripcion=193
Nombre=199
Hexadecimal=72
Numero=62

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
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Color:Color.Color)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

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

[Color.Color.Numero]
Carpeta=Color
Clave=Color.Numero
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

[Color.ListaEnCaptura]
(Inicio)=Color.Color
Color.Color=Color.Numero
Color.Numero=(Fin)
