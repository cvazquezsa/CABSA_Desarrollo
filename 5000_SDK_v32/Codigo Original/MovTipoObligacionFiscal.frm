
[Forma]
Clave=MovTipoObligacionFiscal
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Tipo Movimiento - Obligacion Fiscal
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
Comentarios=Lista(Info.Modulo,Info.Mov)
PosicionInicialAlturaCliente=384
PosicionInicialAncho=433
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=503
PosicionInicialArriba=239
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoObligacionFiscal
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
ListaEnCaptura=MovTipoObligacionFiscal.ObligacionFiscal
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=MovTipoObligacionFiscal.Modulo = {Comillas(Info.Modulo)} AND MovTipoObligacionFiscal.Mov = {Comillas(Info.Mov)}
[Lista.MovTipoObligacionFiscal.ObligacionFiscal]
Carpeta=Lista
Clave=MovTipoObligacionFiscal.ObligacionFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Borrar]
Nombre=Borrar
Boton=37
NombreEnBoton=S
NombreDesplegar=&Borrar Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S


GuardarAntes=S
Expresion=EJECUTARSQL(<T>EXEC spFiscalBorrarMovTipoObligacionFiscal :tModulo, :tMov<T>,Info.Modulo, Info.Mov)<BR>ActualizarForma
[Lista.Columnas]
ObligacionFiscal=396























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Borrar
Borrar=(Fin)
