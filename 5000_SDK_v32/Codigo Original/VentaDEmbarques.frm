
[Forma]
Clave=VentaDEmbarques
Icono=0
Modulos=(Todos)
Nombre=Embarques

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
VentanaColor=Plata
ListaAcciones=(Lista)
PosicionInicialIzquierda=1672
PosicionInicialArriba=126
PosicionInicialAlturaCliente=286
PosicionInicialAncho=735
Comentarios=Info.Articulo
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaDEmbarques
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=VentaDEmbarques.ID = {Info.ID}
[Lista.VentaDEmbarques.Cantidad]
Carpeta=Lista
Clave=VentaDEmbarques.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.VentaDEmbarques.TipoDireccion]
Carpeta=Lista
Clave=VentaDEmbarques.TipoDireccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.VentaDEmbarques.Ubicacion]
Carpeta=Lista
Clave=VentaDEmbarques.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S




[Lista.Columnas]
TipoDireccion=110
Cantidad=64
Ubicacion=514







Articulo=124
[Lista.ListaEnCaptura]
(Inicio)=VentaDEmbarques.Articulo
VentaDEmbarques.Articulo=VentaDEmbarques.TipoDireccion
VentaDEmbarques.TipoDireccion=VentaDEmbarques.Cantidad
VentaDEmbarques.Cantidad=VentaDEmbarques.Ubicacion
VentaDEmbarques.Ubicacion=(Fin)

[Lista.VentaDEmbarques.Articulo]
Carpeta=Lista
Clave=VentaDEmbarques.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





















[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Cancelar
Cancelar=(Fin)
