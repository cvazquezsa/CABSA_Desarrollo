[Forma]
Clave=AutoMant
Nombre=Mantenimientos Preventivos
Icono=0
Modulos=(Todos)
PosicionInicialAlturaCliente=365
PosicionInicialAncho=267
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=378
PosicionInicialArriba=184
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoMant
Fuente={Tahoma, 8, Negro, []}
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=AutoMant.Mantenimiento
CarpetaVisible=S
HojaMantenerSeleccion=S
HojaMostrarRenglones=S

[Lista.AutoMant.Mantenimiento]
Carpeta=Lista
Clave=AutoMant.Mantenimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mantenimiento=237
Tipo=109

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
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(AutoMant:AutoMant.Mantenimiento)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Acciones.Servicios]
Nombre=Servicios
Boton=47
NombreEnBoton=S
NombreDesplegar=&Servicios
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AutoMantServ
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(AutoMant:AutoMant.Mantenimiento)
AntesExpresiones=Asigna(Info.Mantenimiento, AutoMant:AutoMant.Mantenimiento)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Servicios
Servicios=(Fin)
