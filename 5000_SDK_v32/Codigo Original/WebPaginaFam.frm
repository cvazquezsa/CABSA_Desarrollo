[Forma]
Clave=WebPaginaFam
Nombre=Familias de P�ginas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=806
PosicionInicialArriba=391
PosicionInicialAlturaCliente=382
PosicionInicialAncho=307

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaFam
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=WebPaginaFam.Familia

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
ConCondicion=S
EjecucionConError=S
Visible=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(WebPaginaFam:WebPaginaFam.Familia)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

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

[Lista.Columnas]
Familia=270

[Lista.WebPaginaFam.Familia]
Carpeta=Lista
Clave=WebPaginaFam.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
