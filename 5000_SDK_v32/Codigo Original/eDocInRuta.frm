
[Forma]
Clave=eDocInRuta
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=eDocInRuta
CarpetaPrincipal=eDocInRuta
PosicionInicialIzquierda=226
PosicionInicialArriba=219
PosicionInicialAlturaCliente=384
PosicionInicialAncho=1148
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Nombre=Rutas
Comentarios=Info.Descripcion
[eDocInRuta]
Estilo=Hoja
Clave=eDocInRuta
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInRuta
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
FiltroGeneral=eDocInRuta.eDocIn = {Comillas(Info.Descripcion)}
[eDocInRuta.eDocInRuta.Ruta]
Carpeta=eDocInRuta
Clave=eDocInRuta.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=40
[eDocInRuta.eDocInRuta.Descripcion]
Carpeta=eDocInRuta
Clave=eDocInRuta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[eDocInRuta.eDocInRuta.XSD]
Carpeta=eDocInRuta
Clave=eDocInRuta.XSD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[eDocInRuta.eDocInRuta.Modulo]
Carpeta=eDocInRuta
Clave=eDocInRuta.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[eDocInRuta.eDocInRuta.Mov]
Carpeta=eDocInRuta
Clave=eDocInRuta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[eDocInRuta.eDocInRuta.Afectar]
Carpeta=eDocInRuta
Clave=eDocInRuta.Afectar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[eDocInRuta.eDocInRuta.VigenciaDe]
Carpeta=eDocInRuta
Clave=eDocInRuta.VigenciaDe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=40
[eDocInRuta.eDocInRuta.VigenciaA]
Carpeta=eDocInRuta
Clave=eDocInRuta.VigenciaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





Tamano=40

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

[Acciones.Cancelar/Cancelar Cambios]
Nombre=Cancelar/Cancelar Cambios
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S



EspacioPrevio=S








[Acciones.eDocInRutaTabla]
Nombre=eDocInRutaTabla
Boton=47
NombreEnBoton=S
NombreDesplegar=Tablas
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=eDocInRutaTabla
Activo=S
Antes=S
DespuesGuardar=S
Visible=S







EspacioPrevio=S
AntesExpresiones=Asigna(Info.Ruta,eDocInRuta:eDocInRuta.Ruta)       <BR>Asigna(Info.Modulo,eDocInRuta:eDocInRuta.Modulo)<BR>EjecutarSQL(<T>speDocInInsertarRutaTabla :teDocIn, :tRuta, :tModulo<T>,eDocInRuta:eDocInRuta.eDocIn,eDocInRuta:eDocInRuta.Ruta,eDocInRuta:eDocInRuta.Modulo)<BR>EjecutarSQL(<T>speDocInListarNodosXml2 :nEstacion,:teDocIn<T>,EstacionTrabajo,Info.Descripcion)
[eDocInRuta.Columnas]
Ruta=93
Descripcion=150
XSD=114
Modulo=62
Mov=124
Afectar=64
VigenciaDe=94
VigenciaA=94











AntesAfectar=304
[Acciones.Validar]
Nombre=Validar
Boton=95
NombreEnBoton=S
NombreDesplegar=&Validaciones
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocInRutaD
Activo=S
Antes=S
DespuesGuardar=S
Visible=S


AntesExpresiones=Asigna(Info.Titulo,<T>Validaciones<T>)<BR>Asigna(Info.Ruta,eDocInRuta:eDocInRuta.Ruta)<BR>Asigna(Info.Tipo,<T>Validar<T>)<BR>EjecutarSQL(<T>speDocInListarNodosAtributos2 :nEstacion,:teDocIn<T>,EstacionTrabajo,eDocInRuta:eDocInRuta.eDocIn)
[Acciones.Condicion]
Nombre=Condicion
Boton=90
NombreEnBoton=S
NombreDesplegar=C&ondiciones
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocInRutaD
Activo=S
Antes=S
DespuesGuardar=S
Visible=S









































AntesExpresiones=Asigna(Info.Titulo,<T>Condiciones<T>)<BR>Asigna(Info.Ruta,eDocInRuta:eDocInRuta.Ruta)<BR>Asigna(Info.Tipo,<T>Condicion<T>)<BR>EjecutarSQL(<T>speDocInListarNodosAtributos2 :nEstacion,:teDocIn<T>,EstacionTrabajo,eDocInRuta:eDocInRuta.eDocIn)












[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>speDocInRutaEliminar :eDocIn,:tRuta<T>,eDocInRuta:eDocInRuta.eDocIn,eDocInRuta:eDocInRuta.Ruta)<BR>ActualizarForma
Activo=S
Visible=S






[Acciones.Copiar]
Nombre=Copiar
Boton=65
NombreEnBoton=S
NombreDesplegar=&Copiar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S













Expresion=FormaModal(<T>eDocInRutaCopiar<T>)<BR>ActualizarForma
Antes=S
AntesExpresiones=Asigna(Info.Descripcion,eDocInRuta:eDocInRuta.eDocIn)<BR>Asigna(Info.Rol,eDocInRuta:eDocInRuta.Ruta)
DespuesGuardar=S








[eDocInRuta.eDocInRuta.AntesAfectar]
Carpeta=eDocInRuta
Clave=eDocInRuta.AntesAfectar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco










[Acciones.eDocInRutaExpresion]
Nombre=eDocInRutaExpresion
Boton=105
NombreEnBoton=S
NombreDesplegar=&Expresión
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=eDocInRutaExpresion
Visible=S





GuardarAntes=S
Antes=S




EspacioPrevio=S
ActivoCondicion=eDocInRuta:eDocInRuta.AntesAfectar=<T>Stored Procedure<T>
AntesExpresiones=Asigna(Info.Ruta,eDocInRuta:eDocInRuta.Ruta)



















[eDocInRuta.ListaEnCaptura]
(Inicio)=eDocInRuta.Ruta
eDocInRuta.Ruta=eDocInRuta.Descripcion
eDocInRuta.Descripcion=eDocInRuta.Modulo
eDocInRuta.Modulo=eDocInRuta.Mov
eDocInRuta.Mov=eDocInRuta.Afectar
eDocInRuta.Afectar=eDocInRuta.AntesAfectar
eDocInRuta.AntesAfectar=eDocInRuta.VigenciaDe
eDocInRuta.VigenciaDe=eDocInRuta.VigenciaA
eDocInRuta.VigenciaA=eDocInRuta.XSD
eDocInRuta.XSD=(Fin)















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar/Cancelar Cambios
Cancelar/Cancelar Cambios=eDocInRutaTabla
eDocInRutaTabla=Condicion
Condicion=Validar
Validar=Eliminar
Eliminar=Copiar
Copiar=eDocInRutaExpresion
eDocInRutaExpresion=(Fin)
