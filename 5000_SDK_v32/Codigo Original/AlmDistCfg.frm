
[Forma]
Clave=AlmDistCfg
Icono=0
Modulos=(Todos)
Nombre=Almacenes de Distribución

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=385
PosicionInicialArriba=129
PosicionInicialAlturaCliente=430
PosicionInicialAncho=595
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Almacenes
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AlmDist
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

HojaMantenerSeleccion=S
FiltroGeneral=Empresa = {Comillas(Empresa)}
[Lista.AlmDist.Almacen]
Carpeta=Lista
Clave=AlmDist.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.AlmDist.Nombre]
Carpeta=Lista
Clave=AlmDist.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.AlmDist.Porcentaje]
Carpeta=Lista
Clave=AlmDist.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.AlmDist.Distribuir]
Carpeta=Lista
Clave=AlmDist.Distribuir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Cdis.AlmCDIS.Almacen]
Carpeta=Cdis
Clave=AlmCDIS.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco




[Lista.Columnas]
Almacen=109
Nombre=111
Porcentaje=76
Distribuir=69








Grupo=100
Sucursal=46
EsOrigen=74
EsDestino=74
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





GuardarAntes=S




















































































[FormaExtraValor.Columnas]
VerCampo=298
VerValor=266

[(Carpeta Abrir).Columnas]
0=119
1=369
2=-2













[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Cdis
Cdis=(Fin)


[Lista.AlmDist.EsOrigen]
Carpeta=Lista
Clave=AlmDist.EsOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.AlmDist.EsDestino]
Carpeta=Lista
Clave=AlmDist.EsDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=AlmDist.Almacen
AlmDist.Almacen=AlmDist.Nombre
AlmDist.Nombre=AlmDist.Distribuir
AlmDist.Distribuir=AlmDist.EsOrigen
AlmDist.EsOrigen=AlmDist.EsDestino
AlmDist.EsDestino=AlmDist.Porcentaje
AlmDist.Porcentaje=(Fin)
