
[Forma]
Clave=TipoComprobante
Icono=0
Modulos=(Todos)
Nombre=Tipo de Comprobante
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=407
PosicionInicialAncho=838
PosicionCol1=460
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=301
PosicionInicialArriba=233
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoComprobante
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
ListaOrden=TipoComprobante.TipoComprobante<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=TipoComprobante.TipoComprobante
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Ninguno
[Lista.TipoComprobante.TipoComprobante]
Carpeta=Lista
Clave=TipoComprobante.TipoComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.TipoComprobante.Concepto]
Carpeta=Lista
Clave=TipoComprobante.Concepto
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
Vista=TipoComprobante
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

[Ficha.TipoComprobante.TipoComprobante]
Carpeta=Ficha
Clave=TipoComprobante.TipoComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.TipoComprobante.Concepto]
Carpeta=Ficha
Clave=TipoComprobante.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.TipoComprobante.Referencia]
Carpeta=Ficha
Clave=TipoComprobante.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.TipoComprobante.VigenciaD]
Carpeta=Ficha
Clave=TipoComprobante.VigenciaD
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
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

EspacioPrevio=S
[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Lista.Columnas]
TipoComprobante=124
Concepto=304








[Ficha.ListaEnCaptura]
(Inicio)=TipoComprobante.TipoComprobante
TipoComprobante.TipoComprobante=TipoComprobante.Concepto
TipoComprobante.Concepto=TipoComprobante.Referencia
TipoComprobante.Referencia=TipoComprobante.VigenciaD
TipoComprobante.VigenciaD=(Fin)



[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreDesplegar=&Historico
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=formas
ClaveAccion=TipoComprobanteD
Activo=S
Visible=S



NombreEnBoton=S








ConCondicion=S
Antes=S




















GuardarAntes=S




EjecucionCondicion=ConDatos(TipoComprobante:TipoComprobante.TipoComprobante)
AntesExpresiones=Asigna(Info.Nombre,TipoComprobante:TipoComprobante.TipoComprobante)
DespuesGuardar=S








[Lista.ListaEnCaptura]
(Inicio)=TipoComprobante.TipoComprobante
TipoComprobante.TipoComprobante=TipoComprobante.Concepto
TipoComprobante.Concepto=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Detalle
Detalle=Navegador
Navegador=(Fin)
