[Forma]
Clave=WebColor
Nombre=Lista de Colores Web
Icono=0
Modulos=INV
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=811
PosicionInicialArriba=306
PosicionInicialAltura=324
PosicionInicialAncho=298
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
BarraHerramientas=S
PosicionInicialAlturaCliente=552

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
Color=194
Descripcion=248
Hexadecimal=66

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
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(WebColor:WebColor.Color)))<BR>Vacio(Temp.Texto)
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

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Colores
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebColor
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=WebColor.Color<TAB>(Acendente)
CarpetaVisible=S

[Lista.WebColor.Color]
Carpeta=Lista
Clave=WebColor.Color
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebColor.Hexadecimal]
Carpeta=Lista
Clave=WebColor.Hexadecimal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=WebColor.Color
WebColor.Color=WebColor.Hexadecimal
WebColor.Hexadecimal=(Fin)
