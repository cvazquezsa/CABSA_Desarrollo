
[Forma]
Clave=eDoc
Icono=0
Modulos=(Todos)
Nombre=Documento Electrónico

ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Modulo,Info.Descripcion)
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=274
PosicionInicialArriba=178
PosicionInicialAlturaCliente=465
PosicionInicialAncho=787
PosicionCol1=260
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDoc
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
ListaEnCaptura=eDoc.eDoc

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

HojaMantenerSeleccion=S
FiltroGeneral=eDoc.Modulo = {Comillas(Info.Modulo)}
[Lista.eDoc.eDoc]
Carpeta=Lista
Clave=eDoc.eDoc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
[Lista.ListaEnCaptura]
(Inicio)=eDoc.eDoc
eDoc.eDoc=eDoc.TipoXML
eDoc.TipoXML=eDoc.XSD
eDoc.XSD=(Fin)

[Lista.Columnas]
eDoc=226
TipoXML=121

[Detalle]
Estilo=Ficha
Clave=Detalle
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=eDoc
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

FiltroGeneral=eDoc.Modulo = {Comillas(Info.Modulo)}
[Detalle.eDoc.eDoc]
Carpeta=Detalle
Clave=eDoc.eDoc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=43
ColorFondo=Blanco

[Detalle.eDoc.TipoXML]
Carpeta=Detalle
Clave=eDoc.TipoXML
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=10
[Detalle.eDoc.XSD]
Carpeta=Detalle
Clave=eDoc.XSD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco












[Acciones.Documento]
Nombre=Documento
Boton=124
NombreDesplegar=&Plantilla
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=eDocDocumento
Activo=S
Visible=S





EspacioPrevio=S








GuardarAntes=S






ConCondicion=S
Antes=S
EjecucionCondicion=No Vacio(eDoc:eDoc.eDoc)
AntesExpresiones=Asigna(Info.Descripcion,eDoc:eDoc.eDoc)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S



























































NombreEnBoton=S
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S







[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S





GuardarAntes=S












ConfirmarAntes=S
DialogoMensaje=EstaSeguro




















Expresion=Informacion(SQL(<T>EXEC speDocEliminar :nEstacion, :tModulo, :teDoc<T>,EstacionTrabajo, eDoc:eDoc.Modulo, eDoc:eDoc.eDoc))<BR>ActualizarForma
[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreDesplegar=&Detalle
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocD
Activo=S
ConCondicion=S
Antes=S
Visible=S

































EjecucionCondicion=No Vacio(eDoc:eDoc.eDoc)
AntesExpresiones=Asigna(Info.Descripcion,eDoc:eDoc.eDoc)
[Acciones.Copiar]
Nombre=Copiar
Boton=65
NombreDesplegar=&Copiar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

















































































































































Antes=S










Expresion=Si Forma(<T>eDocCopiar<T>) Entonces<BR>  Informacion(SQL(<T>EXEC speDocCopiar :nEstacion, :tOModulo, :tOeDoc, :tDModulo, :tDeDoc<T>,EstacionTrabajo, eDoc:eDoc.Modulo, eDoc:eDoc.eDoc, Temp.Modulo, Info.eDoc))       <BR>  ActualizarForma<BR>Fin
AntesExpresiones=Asigna(Info.Descripcion,eDoc:eDoc.eDoc)







[Detalle.eDoc.TipoCFD]
Carpeta=Detalle
Clave=eDoc.TipoCFD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










Tamano=10
[Detalle.eDoc.DecimalesPorOmision]
Carpeta=Detalle
Clave=eDoc.DecimalesPorOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



Tamano=15









[Detalle.eDoc.TipoCFDI]
Carpeta=Detalle
Clave=eDoc.TipoCFDI
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




[Detalle.eDoc.TimbrarEnTransaccion]
Carpeta=Detalle
Clave=eDoc.TimbrarEnTransaccion
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco












[Detalle.eDoc.CaracterExtendidoAASCII]
Carpeta=Detalle
Clave=eDoc.CaracterExtendidoAASCII
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Detalle.eDoc.ConvertirPaginaCodigo437]
Carpeta=Detalle
Clave=eDoc.ConvertirPaginaCodigo437
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Detalle.eDoc.ConvertirComillaDobleAASCII]
Carpeta=Detalle
Clave=eDoc.ConvertirComillaDobleAASCII
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Detalle.eDoc.Sellar]
Carpeta=Detalle
Clave=eDoc.Sellar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco















[Detalle.ListaEnCaptura]
(Inicio)=eDoc.eDoc
eDoc.eDoc=eDoc.TipoXML
eDoc.TipoXML=eDoc.XSD
eDoc.XSD=eDoc.TipoCFD
eDoc.TipoCFD=eDoc.TipoCFDI
eDoc.TipoCFDI=eDoc.TimbrarEnTransaccion
eDoc.TimbrarEnTransaccion=eDoc.DecimalesPorOmision
eDoc.DecimalesPorOmision=eDoc.CaracterExtendidoAASCII
eDoc.CaracterExtendidoAASCII=eDoc.ConvertirPaginaCodigo437
eDoc.ConvertirPaginaCodigo437=eDoc.ConvertirComillaDobleAASCII
eDoc.ConvertirComillaDobleAASCII=eDoc.Sellar
eDoc.Sellar=(Fin)











[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Nuevo
Nuevo=Eliminar
Eliminar=Documento
Documento=Detalle
Detalle=Copiar
Copiar=(Fin)
