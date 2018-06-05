
[Forma]
Clave=eDocDMapeoCampo
Icono=0
Modulos=(Todos)
Nombre=<T>Mapeo Campos<T>

ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=511
PosicionInicialArriba=264
PosicionInicialAlturaCliente=428
PosicionInicialAncho=910
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionCol1=518
Comentarios=Lista(Info.Modulo,Info.Descripcion,Info.Categoria)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocDMapeoCampo
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

HojaAjustarColumnas=S
FiltroGeneral=eDocDMapeoCampo.Modulo = {Comillas(Info.Modulo)} AND eDocDMapeoCampo.eDoc = {Comillas(Info.Descripcion)} AND eDocDMapeoCampo.IDSeccion = {Info.RID}
[Lista.eDocDMapeoCampo.CampoXML]
Carpeta=Lista
Clave=eDocDMapeoCampo.CampoXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.eDocDMapeoCampo.CampoVista]
Carpeta=Lista
Clave=eDocDMapeoCampo.CampoVista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle]
Estilo=Ficha
Clave=Detalle
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=eDocDMapeoCampo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
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

FiltroGeneral=eDocDMapeoCampo.Modulo = {Comillas(Info.Modulo)} AND eDocDMapeoCampo.eDoc = {Comillas(Info.Descripcion)} AND eDocDMapeoCampo.IDSeccion = {Info.RID}
[Detalle.eDocDMapeoCampo.CampoXML]
Carpeta=Detalle
Clave=eDocDMapeoCampo.CampoXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.eDocDMapeoCampo.CampoVista]
Carpeta=Detalle
Clave=eDocDMapeoCampo.CampoVista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.eDocDMapeoCampo.FormatoOpcional]
Carpeta=Detalle
Clave=eDocDMapeoCampo.FormatoOpcional
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.eDocDMapeoCampo.Traducir]
Carpeta=Detalle
Clave=eDocDMapeoCampo.Traducir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.eDocDMapeoCampo.Opcional]
Carpeta=Detalle
Clave=eDocDMapeoCampo.Opcional
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.eDocDMapeoCampo.BorrarSiOpcional]
Carpeta=Detalle
Clave=eDocDMapeoCampo.BorrarSiOpcional
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco



[Lista.Columnas]
CampoXML=241
CampoVista=242


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








[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo Registro
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S











[Lista.ListaEnCaptura]
(Inicio)=eDocDMapeoCampo.CampoXML
eDocDMapeoCampo.CampoXML=eDocDMapeoCampo.CampoVista
eDocDMapeoCampo.CampoVista=(Fin)





[Detalle.eDocDMapeoCampo.TablaSt]
Carpeta=Detalle
Clave=eDocDMapeoCampo.TablaSt
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

























[Acciones.Sugerir]
Nombre=Sugerir
Boton=12
NombreEnBoton=S
NombreDesplegar=&Sugerir Campos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S









ConfirmarAntes=S
DialogoMensaje=EstaSeguro










Expresion=EJECUTARSQL(<T>EXEC speDocInsertarCamposXML :tModulo, :teDoc, :nSeccionID<T>,Info.Modulo,Info.Descripcion,Info.RID)<BR>ActualizarForma
VisibleCondicion=SI(SQL(<T>IF EXISTS(SELECT * FROM Version WHERE SincroIS = 0) OR (EXISTS(SELECT * FROM Version WHERE SincroIS = 1) AND :nSucursal = 0) SELECT 1 ELSE SELECT 0<T>, Sucursal)=1,VERDADERO,FALSO)
[Acciones.Ayuda]
Nombre=Ayuda
Boton=101
NombreEnBoton=S
NombreDesplegar=&Ayuda Campos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocModuloVistaAyuda
Activo=S
Visible=S





Antes=S




AntesExpresiones=Asigna(Info.Campo,eDocDMapeoCampo:eDocDMapeoCampo.CampoVista)





[Detalle.eDocDMapeoCampo.Decimales]
Carpeta=Detalle
Clave=eDocDMapeoCampo.Decimales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco









[Detalle.eDocDMapeoCampo.CaracterExtendidoAASCII]
Carpeta=Detalle
Clave=eDocDMapeoCampo.CaracterExtendidoAASCII
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Detalle.eDocDMapeoCampo.ConvertirPaginaCodigo437]
Carpeta=Detalle
Clave=eDocDMapeoCampo.ConvertirPaginaCodigo437
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Detalle.eDocDMapeoCampo.ConvertirComillaDobleAASCII]
Carpeta=Detalle
Clave=eDocDMapeoCampo.ConvertirComillaDobleAASCII
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
























[Detalle.ListaEnCaptura]
(Inicio)=eDocDMapeoCampo.CampoXML
eDocDMapeoCampo.CampoXML=eDocDMapeoCampo.CampoVista
eDocDMapeoCampo.CampoVista=eDocDMapeoCampo.FormatoOpcional
eDocDMapeoCampo.FormatoOpcional=eDocDMapeoCampo.Decimales
eDocDMapeoCampo.Decimales=eDocDMapeoCampo.NumericoNuloACero
eDocDMapeoCampo.NumericoNuloACero=eDocDMapeoCampo.Traducir
eDocDMapeoCampo.Traducir=eDocDMapeoCampo.TablaSt
eDocDMapeoCampo.TablaSt=eDocDMapeoCampo.Opcional
eDocDMapeoCampo.Opcional=eDocDMapeoCampo.BorrarSiOpcional
eDocDMapeoCampo.BorrarSiOpcional=eDocDMapeoCampo.CaracterExtendidoAASCII
eDocDMapeoCampo.CaracterExtendidoAASCII=eDocDMapeoCampo.ConvertirPaginaCodigo437
eDocDMapeoCampo.ConvertirPaginaCodigo437=eDocDMapeoCampo.ConvertirComillaDobleAASCII
eDocDMapeoCampo.ConvertirComillaDobleAASCII=(Fin)

[Detalle.eDocDMapeoCampo.NumericoNuloACero]
Carpeta=Detalle
Clave=eDocDMapeoCampo.NumericoNuloACero
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco























[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Sugerir
Sugerir=Ayuda
Ayuda=(Fin)
