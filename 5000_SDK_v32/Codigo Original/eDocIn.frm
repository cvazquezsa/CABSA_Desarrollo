
[Forma]
Clave=eDocIn
Icono=0
Modulos=(Todos)
Nombre=Documento Electrónico

ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=367
PosicionInicialArriba=112
PosicionInicialAlturaCliente=598
PosicionInicialAncho=866
PosicionCol1=260
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocIn
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
ListaEnCaptura=eDocIn.eDocIn

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

HojaMantenerSeleccion=S

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

eDocIn=304
[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=eDocIn
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

CarpetaVisible=S





[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
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






















Expresion=Informacion(SQL(<T>EXEC speDocInEliminar :nEstacion, :teDocIn<T>,EstacionTrabajo, eDocIn:eDocIn.eDocIn))<BR>ActualizarForma
[Lista.eDocIn.eDocIn]
Carpeta=Lista
Clave=eDocIn.eDocIn
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Detalle.eDocIn.Descripcion]
Carpeta=Detalle
Clave=eDocIn.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=79
ColorFondo=Blanco

[Detalle.eDocIn.Tipo]
Carpeta=Detalle
Clave=eDocIn.Tipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=38
ColorFondo=Blanco































[Acciones.eDocInRuta]
Nombre=eDocInRuta
Boton=16
NombreEnBoton=S
NombreDesplegar=&Rutas
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocInRuta
Activo=S
Antes=S
DespuesGuardar=S
Visible=S

















AntesExpresiones=Asigna(Info.Descripcion,eDocIn:eDocIn.eDocIn)
[Acciones.Documento]
Nombre=Documento
Boton=124
NombreDesplegar=&Plantillas
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocInDocumento
Activo=S
Visible=S



Antes=S
AntesExpresiones=Asigna(Info.Descripcion,eDocIn:eDocIn.eDocIn)
DespuesGuardar=S

[Acciones.Copiar]
Nombre=Copiar
Boton=65
NombreDesplegar=&Copiar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S















Antes=S
DespuesGuardar=S
Expresion=FormaModal(<T>eDocInCopiar<T>)<BR> ActualizarForma
AntesExpresiones=Asigna(Info.Descripcion,eDocIn:eDocIn.eDocIn)
[Detalle.eDocIn.eDocIn]
Carpeta=Detalle
Clave=eDocIn.eDocIn
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

















[Detalle.ListaEnCaptura]
(Inicio)=eDocIn.eDocIn
eDocIn.eDocIn=eDocIn.Tipo
eDocIn.Tipo=eDocIn.Descripcion
eDocIn.Descripcion=(Fin)































[eDocInRutaDCondicion.Columnas]
Operando1=183
Operador=174
Operando2=304



















































































































































































































































































































































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
Documento=eDocInRuta
eDocInRuta=Copiar
Copiar=(Fin)
