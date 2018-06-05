[Forma]
Clave=TablaRangoSt
Nombre=Tablas Rangos / Nombre
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=436
PosicionInicialArriba=327
PosicionInicialAltura=300
PosicionInicialAncho=408
PosicionInicialAlturaCliente=342

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaRangoSt
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TablaRangoSt.TablaRangoSt
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.TablaRangoSt.TablaRangoSt]
Carpeta=Lista
Clave=TablaRangoSt.TablaRangoSt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
TablaRangoSt=379

[Acciones.Tabla]
Nombre=Tabla
Boton=47
NombreEnBoton=S
NombreDesplegar=E&ditar Tabla
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TablaRangoStD
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(TablaRangoSt:TablaRangoSt.TablaRangoSt)
AntesExpresiones=Asigna(Info.Tabla,TablaRangoSt:TablaRangoSt.TablaRangoSt)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Tabla
Tabla=(Fin)
