[Forma]
Clave=Modulo
Nombre=Módulos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=693
PosicionInicialArriba=391
PosicionInicialAlturaCliente=383
PosicionInicialAncho=533
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionCol1=345

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Modulo
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
HojaMantenerSeleccion=S

[Lista.Modulo.Modulo]
Carpeta=Lista
Clave=Modulo.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Modulo.Nombre]
Carpeta=Lista
Clave=Modulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Modulo=59
Nombre=254

[Acciones.SubModulo]
Nombre=SubModulo
Boton=47
NombreEnBoton=S
NombreDesplegar=&Sub Módulos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SubModulo
Antes=S
Visible=S
ActivoCondicion=Modulo:Modulo.Modulo en (<T>VTAS<T>, <T>ST<T>, <T>COMS<T>,  <T>INV<T>, <T>GAS<T>, <T>CXC<T>)
AntesExpresiones=Asigna(Info.Modulo, Modulo:Modulo.Modulo)<BR>Asigna(Info.Nombre, Modulo:Modulo.Nombre)

[Ficha]
Estilo=Ficha
PestanaOtroNombre=S
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Modulo
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

[Ficha.Modulo.Hist]
Carpeta=Ficha
Clave=Modulo.Hist
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Modulo.HistMin]
Carpeta=Ficha
Clave=Modulo.HistMin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Modulo.HistMinUnidad]
Carpeta=Ficha
Clave=Modulo.HistMinUnidad
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Modulo.HistMax]
Carpeta=Ficha
Clave=Modulo.HistMax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Modulo.HistMaxUnidad]
Carpeta=Ficha
Clave=Modulo.HistMaxUnidad
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Modulo.ConsecutivoUnico]
Carpeta=Ficha
Clave=Modulo.ConsecutivoUnico
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=SubModulo
SubModulo=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Modulo.Modulo
Modulo.Modulo=Modulo.Nombre
Modulo.Nombre=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Modulo.Hist
Modulo.Hist=Modulo.HistMin
Modulo.HistMin=Modulo.HistMinUnidad
Modulo.HistMinUnidad=Modulo.HistMax
Modulo.HistMax=Modulo.HistMaxUnidad
Modulo.HistMaxUnidad=Modulo.ConsecutivoUnico
Modulo.ConsecutivoUnico=(Fin)
