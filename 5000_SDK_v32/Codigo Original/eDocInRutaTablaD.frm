
[Forma]
Clave=eDocInRutaTablaD
Icono=0
CarpetaPrincipal=Detalle
Modulos=(Todos)
Nombre=Detalle

ListaCarpetas=(Lista)
PosicionInicialAlturaCliente=561
PosicionInicialAncho=827
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=386
PosicionInicialArriba=130
Comentarios=Lista(Info.Descripcion,Info.Ruta,Info.Tabla)
PosicionCol1=207
ExpresionesAlMostrar=Asigna(Info.Destino,NULO)<BR>Asigna(Info.Dato,NULO)<BR>Asigna(Info.Motivo,NULO)<BR>Asigna(Info.Anuncio,NULO)
[eDocInRutaTablaD]
Estilo=Hoja
Clave=eDocInRutaTablaD
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInRutaTablaD
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Campos XML
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaEnCaptura=eDocInRutaTablaD.CampoTabla
FiltroGeneral=eDocInRutaTablaD.eDocIn = <T>{Info.Descripcion}<T> AND<BR>eDocInRutaTablaD.Ruta = <T>{Info.Ruta}<T> AND<BR>eDocInRutaTablaD.Tablas  =<T>{Info.Tabla}<T>
[eDocInRutaTablaD.ListaEnCaptura]
(Inicio)=eDocInRutaTablaD.CampoXML
eDocInRutaTablaD.CampoXML=eDocInRutaTablaD.ExpresionXML
eDocInRutaTablaD.ExpresionXML=eDocInRutaTablaD.CampoTabla
eDocInRutaTablaD.CampoTabla=eDocInRutaTablaD.CampoXMLTipo
eDocInRutaTablaD.CampoXMLTipo=eDocInRutaTablaD.CampoXMLRuta
eDocInRutaTablaD.CampoXMLRuta=eDocInRutaTablaD.CampoXMLAtributo
eDocInRutaTablaD.CampoXMLAtributo=eDocInRutaTablaD.CampoXMLTipoXML
eDocInRutaTablaD.CampoXMLTipoXML=eDocInRutaTablaD.EsIndependiente
eDocInRutaTablaD.EsIndependiente=eDocInRutaTablaD.EsConsecutivo
eDocInRutaTablaD.EsConsecutivo=eDocInRutaTablaD.ConsecutivoNombre
eDocInRutaTablaD.ConsecutivoNombre=eDocInRutaTablaD.ConsecutivoInicial
eDocInRutaTablaD.ConsecutivoInicial=eDocInRutaTablaD.ConsecutivoIncremento
eDocInRutaTablaD.ConsecutivoIncremento=eDocInRutaTablaD.Traducir
eDocInRutaTablaD.Traducir=eDocInRutaTablaD.TablaSt
eDocInRutaTablaD.TablaSt=(Fin)















[eDocInRutaTablaD.Columnas]
CampoXML=300
ExpresionXML=116
CampoTabla=174
CampoXMLTipo=177
CampoXMLRuta=244
CampoXMLAtributo=161
CampoXMLTipoXML=162
EsIndependiente=88
EsConsecutivo=77
ConsecutivoNombre=173
ConsecutivoInicial=93
ConsecutivoIncremento=121
Traducir=64
TablaSt=169

0=-2
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
Antes=S
AntesExpresiones=AvanzarCaptura<BR>GuardarCambios
[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S




























[Detalle]
Estilo=Ficha
Clave=Detalle
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=eDocInRutaTablaD
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

FiltroGeneral=eDocInRutaTablaD.eDocIn = <T>{Info.Descripcion}<T> AND<BR>eDocInRutaTablaD.Ruta = <T>{Info.Ruta}<T> AND<BR>eDocInRutaTablaD.Tablas  =<T>{Info.Tabla}<T>
[Detalle.eDocInRutaTablaD.CampoXML]
Carpeta=Detalle
Clave=eDocInRutaTablaD.CampoXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=80

[Detalle.eDocInRutaTablaD.CampoTabla]
Carpeta=Detalle
Clave=eDocInRutaTablaD.CampoTabla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=40



[Detalle.eDocInRutaTablaD.EsIndependiente]
Carpeta=Detalle
Clave=eDocInRutaTablaD.EsIndependiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.eDocInRutaTablaD.EsConsecutivo]
Carpeta=Detalle
Clave=eDocInRutaTablaD.EsConsecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.eDocInRutaTablaD.ConsecutivoNombre]
Carpeta=Detalle
Clave=eDocInRutaTablaD.ConsecutivoNombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.eDocInRutaTablaD.ConsecutivoInicial]
Carpeta=Detalle
Clave=eDocInRutaTablaD.ConsecutivoInicial
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=19
[Detalle.eDocInRutaTablaD.ConsecutivoIncremento]
Carpeta=Detalle
Clave=eDocInRutaTablaD.ConsecutivoIncremento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=19
[Detalle.eDocInRutaTablaD.Traducir]
Carpeta=Detalle
Clave=eDocInRutaTablaD.Traducir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.eDocInRutaTablaD.TablaSt]
Carpeta=Detalle
Clave=eDocInRutaTablaD.TablaSt
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco








[Acciones.Registro Insertar]
Nombre=Registro Insertar
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S



[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreDesplegar=&Eliminar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S






[eDocInNodoAtributoTemp.Columnas]
0=-2
1=-2


















































[eDocInRutaTablaD.eDocInRutaTablaD.CampoTabla]
Carpeta=eDocInRutaTablaD
Clave=eDocInRutaTablaD.CampoTabla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
































[Acciones.eDocInHerrTablaST]
Nombre=eDocInHerrTablaST
Boton=90
NombreEnBoton=S
NombreDesplegar=&Generar Tabla Conversión
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=eDocInHerrTablaST
Activo=S
Visible=S



EspacioPrevio=S














[Acciones.eDocInTablaDAvanzado]
Nombre=eDocInTablaDAvanzado
Boton=93
NombreEnBoton=S
NombreDesplegar=&Avanzado
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocInTablaDAvanzado
Activo=S
Antes=S
DespuesGuardar=S
Visible=S



























AntesExpresiones=Asigna(Info.Descripcion,eDocInRutaTablaD:eDocInRutaTablaD.eDocIn )<BR>Asigna(Info.Ruta,eDocInRutaTablaD:eDocInRutaTablaD.Ruta )<BR>Asigna(Info.RID,eDocInRutaTablaD:eDocInRutaTablaD.RID)<BR>Asigna(Info.Tabla,eDocInRutaTablaD:eDocInRutaTablaD.Tablas)<BR>Asigna(Info.Campo,eDocInRutaTablaD:eDocInRutaTablaD.CampoTabla)
[Detalle.eDocInRutaTablaD.CampoXMLTipo]
Carpeta=Detalle
Clave=eDocInRutaTablaD.CampoXMLTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=39
ColorFondo=Blanco












[Detalle.ListaEnCaptura]
(Inicio)=eDocInRutaTablaD.CampoTabla
eDocInRutaTablaD.CampoTabla=eDocInRutaTablaD.CampoXMLTipo
eDocInRutaTablaD.CampoXMLTipo=eDocInRutaTablaD.CampoXML
eDocInRutaTablaD.CampoXML=eDocInRutaTablaD.EsIndependiente
eDocInRutaTablaD.EsIndependiente=eDocInRutaTablaD.EsConsecutivo
eDocInRutaTablaD.EsConsecutivo=eDocInRutaTablaD.ConsecutivoNombre
eDocInRutaTablaD.ConsecutivoNombre=eDocInRutaTablaD.ConsecutivoInicial
eDocInRutaTablaD.ConsecutivoInicial=eDocInRutaTablaD.ConsecutivoIncremento
eDocInRutaTablaD.ConsecutivoIncremento=eDocInRutaTablaD.Traducir
eDocInRutaTablaD.Traducir=eDocInRutaTablaD.TablaSt
eDocInRutaTablaD.TablaSt=(Fin)





















































[Forma.ListaCarpetas]
(Inicio)=eDocInRutaTablaD
eDocInRutaTablaD=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Registro Insertar
Registro Insertar=Registro Eliminar
Registro Eliminar=eDocInHerrTablaST
eDocInHerrTablaST=eDocInTablaDAvanzado
eDocInTablaDAvanzado=(Fin)
