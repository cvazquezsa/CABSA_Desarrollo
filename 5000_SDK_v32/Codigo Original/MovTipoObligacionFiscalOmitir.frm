
[Forma]
Clave=MovTipoObligacionFiscalOmitir
Icono=0
Modulos=(Todos)
Nombre=Omitir Obligaciones Fiscales

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Modulo,Info.Mov)
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=391
PosicionInicialAncho=473
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=470
PosicionInicialArriba=294
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoObligacionFiscalOmitir
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
PermiteEditar=S
ListaEnCaptura=(Lista)


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=MovTipoObligacionFiscalOmitir.Modulo = {Comillas(Info.Modulo)} AND MovTipoObligacionFiscalOmitir.Mov = {Comillas(Info.Mov)}
FiltroRespetar=S
FiltroTipo=General
[Lista.MovTipoObligacionFiscalOmitir.ObligacionFiscal]
Carpeta=Lista
Clave=MovTipoObligacionFiscalOmitir.ObligacionFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.MovTipoObligacionFiscalOmitir.OrigenModulo]
Carpeta=Lista
Clave=MovTipoObligacionFiscalOmitir.OrigenModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MovTipoObligacionFiscalOmitir.OrigenMov]
Carpeta=Lista
Clave=MovTipoObligacionFiscalOmitir.OrigenMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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
[Lista.Columnas]
ObligacionFiscal=184
OrigenModulo=124
OrigenMov=124

[Acciones.Borrar]
Nombre=Borrar
Boton=37
NombreDesplegar=&Borrar Todo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



NombreEnBoton=S
EspacioPrevio=S
Expresion=EJECUTARSQL(<T>EXEC spFiscalBorrarMovTipoObligacionFiscalOmitir :tModulo, :tMov<T>, MovTipoObligacionFiscalOmitir:MovTipoObligacionFiscalOmitir.Modulo, MovTipoObligacionFiscalOmitir:MovTipoObligacionFiscalOmitir.Mov)<BR>ActualizarForma







[Lista.ListaEnCaptura]
(Inicio)=MovTipoObligacionFiscalOmitir.ObligacionFiscal
MovTipoObligacionFiscalOmitir.ObligacionFiscal=MovTipoObligacionFiscalOmitir.OrigenModulo
MovTipoObligacionFiscalOmitir.OrigenModulo=MovTipoObligacionFiscalOmitir.OrigenMov
MovTipoObligacionFiscalOmitir.OrigenMov=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Borrar
Borrar=(Fin)
