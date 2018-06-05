[Forma]
Clave=AutoBoletoMov
Nombre=Boletos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=286
PosicionInicialArriba=243
PosicionInicialAlturaCliente=503
PosicionInicialAncho=708
Totalizadores=S
PosicionSeccion1=93
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Articulo, Info.SubCuenta)
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoBoletoMov
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
ListaEnCaptura=(Lista)
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=AutoBoletoMov.Empresa=<T>{Empresa}<T> AND<BR>AutoBoletoMov.Modulo=<T>{Info.Modulo}<T> AND<BR>AutoBoletoMov.ID={Info.ID} AND<BR>AutoBoletoMov.RenglonID={Info.RenglonID} AND<BR>AutoBoletoMov.Articulo=<T>{Info.Articulo}<T> AND<BR>ISNULL(AutoBoletoMov.SubCuenta, <T><T>)={Comillas(Info.SubCuenta)}

[Lista.AutoBoletoMov.Cantidad]
Carpeta=Lista
Clave=AutoBoletoMov.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=1

[Lista.AutoBoletoMov.Precio]
Carpeta=Lista
Clave=AutoBoletoMov.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoletoMov.Origen]
Carpeta=Lista
Clave=AutoBoletoMov.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoletoMov.Destino]
Carpeta=Lista
Clave=AutoBoletoMov.Destino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoletoMov.TipoPasajero]
Carpeta=Lista
Clave=AutoBoletoMov.TipoPasajero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=1
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Cantidad=51
SerieLote=124
Precio=94
Origen=88
Destino=76
TipoPasajero=69
Nombre=137
Nombre_1=141
BoletoD=103
BoletoA=100
Importe=81

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Cantidad<BR>Importe
Totalizadores2=Suma(AutoBoletoMov:AutoBoletoMov.Cantidad)<BR>Suma(AutoBoletoMov:Importe)
Totalizadores3=(Cantidades)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Cantidad]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Pegado=S
Efectos=[Negritas]

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Aceptar

[Lista.AutoBoletoMov.BoletoD]
Carpeta=Lista
Clave=AutoBoletoMov.BoletoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoletoMov.BoletoA]
Carpeta=Lista
Clave=AutoBoletoMov.BoletoA
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Importe]
Carpeta=Lista
Clave=Importe
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00408080

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Cantidad, Suma(AutoBoletoMov:AutoBoletoMov.Cantidad))<BR>Asigna(Info.Importe, Suma(AutoBoletoMov:Importe))<BR>EjecutarSQL(<T>spAutoBoletoMovAceptar :tEmpresa, :tModulo, :nID, :nRenglonID, :tArt, :tSub, :nAsignarBoletos<T>, Empresa, Info.Modulo, Info.ID, Info.RenglonID, Info.Articulo, Info.SubCuenta, LogicoEnBit(Info.ArtLinea=Config.AutoArtBA))

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S
NombreEnBoton=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AutoBoletoMov.Cantidad
AutoBoletoMov.Cantidad=AutoBoletoMov.BoletoD
AutoBoletoMov.BoletoD=AutoBoletoMov.BoletoA
AutoBoletoMov.BoletoA=AutoBoletoMov.Precio
AutoBoletoMov.Precio=AutoBoletoMov.Origen
AutoBoletoMov.Origen=AutoBoletoMov.Destino
AutoBoletoMov.Destino=AutoBoletoMov.TipoPasajero
AutoBoletoMov.TipoPasajero=Importe
Importe=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=AutoOrigen.Nombre
AutoOrigen.Nombre=AutoDestino.Nombre
AutoDestino.Nombre=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Cantidad
Cantidad=Importe
Importe=(Fin)
