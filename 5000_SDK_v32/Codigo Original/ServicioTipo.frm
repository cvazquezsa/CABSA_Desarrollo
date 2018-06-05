[Forma]
Clave=ServicioTipo
Nombre=Tipos de Servicios
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=383
PosicionInicialArriba=90
PosicionInicialAltura=300
PosicionInicialAncho=257
PosicionInicialAlturaCliente=417

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServicioTipo
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ServicioTipo.Tipo
CarpetaVisible=S

[Lista.ServicioTipo.Tipo]
Carpeta=Lista
Clave=ServicioTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Tipo=228

[Acciones.Plantilla]
Nombre=Plantilla
Boton=47
NombreEnBoton=S
NombreDesplegar=&Plantilla
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ServicioTipoPlantilla
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ServicioTipo:ServicioTipo.Tipo)
AntesExpresiones=Asigna(Info.Tipo, ServicioTipo:ServicioTipo.Tipo)
DespuesGuardar=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Plantilla
Plantilla=(Fin)
