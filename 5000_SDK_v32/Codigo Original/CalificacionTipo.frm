[Forma]
Clave=CalificacionTipo
Nombre=Tipos Calificaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=789
PosicionInicialArriba=329
PosicionInicialAlturaCliente=506
PosicionInicialAncho=341
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
Vista=CalificacionTipo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CalificacionTipo.Tipo
CarpetaVisible=S

[Lista.CalificacionTipo.Tipo]
Carpeta=Lista
Clave=CalificacionTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Tipo=304

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

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CalificacionTipoD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CalificacionTipo:CalificacionTipo.Tipo)
Antes=S
AntesExpresiones=Asigna(Info.Tipo, CalificacionTipo:CalificacionTipo.Tipo)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalle
Detalle=(Fin)
