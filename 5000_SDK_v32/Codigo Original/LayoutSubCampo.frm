[Forma]
Clave=LayoutSubCampo
Nombre=Sub Campos
Icono=0
Modulos=(Todos)
MovModulo=Campo
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Layout, Info.Lista, Info.Campo, Info.Nombre)
PosicionInicialAlturaCliente=450
PosicionInicialAncho=734
PosicionInicialIzquierda=473
PosicionInicialArriba=283
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSec1=327
PosicionCol1=579

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LayoutSubCampo
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=LayoutSubCampo.Orden<TAB>(Acendente)
FiltroGeneral=LayoutSubCampo.Layout=<T>{Info.Layout}<T> AND<BR>LayoutSubCampo.Lista=<T>{Info.Lista}<T> AND<BR>LayoutSubCampo.Campo=<T>{Info.Campo}<T>

[Lista.LayoutSubCampo.Nombre]
Carpeta=Lista
Clave=LayoutSubCampo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LayoutSubCampo.Posicion]
Carpeta=Lista
Clave=LayoutSubCampo.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LayoutSubCampo.Tamano]
Carpeta=Lista
Clave=LayoutSubCampo.Tamano
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=4
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Campo=181
Nombre=230
Descripcion=604
Posicion=42
Tamano=103
Tipo=88
Orden=36
TipoDatos=87
SubCampo=186

[Lista.LayoutSubCampo.Orden]
Carpeta=Lista
Clave=LayoutSubCampo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LayoutSubCampo.TipoDatos]
Carpeta=Lista
Clave=LayoutSubCampo.TipoDatos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=LayoutSubCampo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=LayoutSubCampo.Descripcion
CarpetaVisible=S
AlinearTodaCarpeta=S
PestanaNombre=Descripción
Pestana=S
PestanaOtroNombre=S

[Ficha.LayoutSubCampo.Descripcion]
Carpeta=Ficha
Clave=LayoutSubCampo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255x3
ColorFondo=Blanco
ColorFuente=Negro

[Transformaciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Transformaciones
Clave=Transformaciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=LayoutSubCampo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Transformaciones.LayoutSubCampo.CDATA]
Carpeta=Transformaciones
Clave=LayoutSubCampo.CDATA
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Transformaciones.LayoutSubCampo.DividirEntre100]
Carpeta=Transformaciones
Clave=LayoutSubCampo.DividirEntre100
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Transformaciones.LayoutSubCampo.Mayusculas]
Carpeta=Transformaciones
Clave=LayoutSubCampo.Mayusculas
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Transformaciones.LayoutSubCampo.Minusculas]
Carpeta=Transformaciones
Clave=LayoutSubCampo.Minusculas
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Valores]
Nombre=Valores
Boton=35
NombreEnBoton=S
NombreDesplegar=&Valores
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=LayoutSubCampoValor
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(LayoutSubCampo:LayoutSubCampo.SubCampo)
AntesExpresiones=Asigna(Info.SubCampo, LayoutSubCampo:LayoutSubCampo.SubCampo)<BR>Asigna(Info.Nombre, LayoutSubCampo:LayoutSubCampo.Nombre)

[Lista.LayoutSubCampo.SubCampo]
Carpeta=Lista
Clave=LayoutSubCampo.SubCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=Transformaciones
Transformaciones=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Valores
Valores=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=LayoutSubCampo.SubCampo
LayoutSubCampo.SubCampo=LayoutSubCampo.Nombre
LayoutSubCampo.Nombre=LayoutSubCampo.Posicion
LayoutSubCampo.Posicion=LayoutSubCampo.Tamano
LayoutSubCampo.Tamano=LayoutSubCampo.TipoDatos
LayoutSubCampo.TipoDatos=LayoutSubCampo.Orden
LayoutSubCampo.Orden=(Fin)

[Transformaciones.ListaEnCaptura]
(Inicio)=LayoutSubCampo.Mayusculas
LayoutSubCampo.Mayusculas=LayoutSubCampo.Minusculas
LayoutSubCampo.Minusculas=LayoutSubCampo.DividirEntre100
LayoutSubCampo.DividirEntre100=LayoutSubCampo.CDATA
LayoutSubCampo.CDATA=(Fin)
