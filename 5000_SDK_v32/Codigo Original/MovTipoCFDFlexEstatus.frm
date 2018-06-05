
[Forma]
Clave=MovTipoCFDFlexEstatus
Icono=0
Modulos=(Todos)
Nombre=CFD Flexible Estatus

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=273
PosicionInicialAncho=516
PosicionInicialIzquierda=369
PosicionInicialArriba=185
ListaAcciones=Aceptar
Comentarios=Lista(Info.Modulo,Info.Mov,Info.Contacto)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoCFDFlexEstatus
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
Filtros=S
PermiteEditar=S
ListaEnCaptura=MovTipoCFDFlexEstatus.Estatus

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=MovTipoCFDFlexEstatus.Modulo = {Comillas(Info.Modulo)} AND MovTipoCFDFlexEstatus.Mov = {Comillas(Info.Mov)} AND MovTipoCFDFlexEstatus.Contacto = {Comillas(Info.Contacto)}
[Lista.ListaEnCaptura]
(Inicio)=MovTipoCFDFlexEstatus.Modulo
MovTipoCFDFlexEstatus.Modulo=MovTipoCFDFlexEstatus.Mov
MovTipoCFDFlexEstatus.Mov=MovTipoCFDFlexEstatus.Estatus
MovTipoCFDFlexEstatus.Estatus=(Fin)



[Lista.MovTipoCFDFlexEstatus.Estatus]
Carpeta=Lista
Clave=MovTipoCFDFlexEstatus.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
Modulo=38
Mov=124
Estatus=94

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S
