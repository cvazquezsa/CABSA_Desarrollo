
[Forma]
Clave=SustentoComprobante
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Sustento de Comprobante
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=423
PosicionInicialAncho=837
PosicionCol1=460
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=301
PosicionInicialArriba=225
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SustentoComprobante
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

OtroOrden=S
ListaOrden=SustentoComprobante.SustentoComprobante<TAB>(Acendente)
[Lista.SustentoComprobante.SustentoComprobante]
Carpeta=Lista
Clave=SustentoComprobante.SustentoComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SustentoComprobante.Concepto]
Carpeta=Lista
Clave=SustentoComprobante.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=SustentoComprobante
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

[Ficha.SustentoComprobante.SustentoComprobante]
Carpeta=Ficha
Clave=SustentoComprobante.SustentoComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SustentoComprobante.Concepto]
Carpeta=Ficha
Clave=SustentoComprobante.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.SustentoComprobante.Referencia]
Carpeta=Ficha
Clave=SustentoComprobante.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.SustentoComprobante.VigenciaD]
Carpeta=Ficha
Clave=SustentoComprobante.VigenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=12
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
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
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

EspacioPrevio=S
[Acciones.Navegar]
Nombre=Navegar
Boton=0
NombreDesplegar=Navegar
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

EspacioPrevio=S
[Lista.Columnas]
SustentoComprobante=124
Concepto=304


[Acciones.TipoComprobante]
Nombre=TipoComprobante
Boton=35
NombreEnBoton=S
NombreDesplegar=&Tipos Comprobante
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SustentoComprobanteTipoComprobante
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Nombre,SustentoComprobante:SustentoComprobante.SustentoComprobante)


[Ficha.ListaEnCaptura]
(Inicio)=SustentoComprobante.SustentoComprobante
SustentoComprobante.SustentoComprobante=SustentoComprobante.Concepto
SustentoComprobante.Concepto=SustentoComprobante.Referencia
SustentoComprobante.Referencia=SustentoComprobante.VigenciaD
SustentoComprobante.VigenciaD=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SustentoComprobante.SustentoComprobante
SustentoComprobante.SustentoComprobante=SustentoComprobante.Concepto
SustentoComprobante.Concepto=(Fin)









[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Historico
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SustentoComprobanteD
Activo=S
Visible=S

ConCondicion=S
Antes=S














GuardarAntes=S








EjecucionCondicion=ConDatos(SustentoComprobante:SustentoComprobante.SustentoComprobante)
AntesExpresiones=Asigna(Info.Nombre,SustentoComprobante:SustentoComprobante.SustentoComprobante)
DespuesGuardar=S


[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=TipoComprobante
TipoComprobante=Detalle
Detalle=Navegar
Navegar=(Fin)
