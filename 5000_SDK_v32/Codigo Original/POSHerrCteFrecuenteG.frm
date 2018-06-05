
[Forma]
Clave=POSHerrCteFrecuenteG
Icono=0
CarpetaPrincipal=POSHerrCteFrecuenteG
BarraHerramientas=S
Modulos=(Todos)
Nombre=Generar Cliente Frecuente
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSHerrCteFrecuenteG
PosicionInicialIzquierda=2092
PosicionInicialArriba=371
PosicionInicialAlturaCliente=244
PosicionInicialAncho=296
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSBorrarCteFrecuenteG :nEstacion<T>,EstacionTrabajo)<BR>Asigna(Info.FechaD,Nulo)<BR>Asigna(Info.FechaA,Nulo)
[POSHerrCteFrecuenteG]
Estilo=Ficha
Clave=POSHerrCteFrecuenteG
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSHerrCteFrecuenteG
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=POSHerrCteFrecuenteG.Estacion = {EstacionTrabajo}
[POSHerrCteFrecuenteG.POSHerrCteFrecuenteG.Moneda]
Carpeta=POSHerrCteFrecuenteG
Clave=POSHerrCteFrecuenteG.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSHerrCteFrecuenteG.POSHerrCteFrecuenteG.Tipo]
Carpeta=POSHerrCteFrecuenteG
Clave=POSHerrCteFrecuenteG.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S
Expresion=Si(ConDatos(POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.FechaD),Asigna(Info.FechaD,FechaFormatoServidor(POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.FechaD)),Nulo)<BR>Si(ConDatos(POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.FechaA),Asigna(Info.FechaA,FechaFormatoServidor(POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.FechaA)),Nulo)<BR><BR>ProcesarSQL(<T>spPOSPOSHerrCteGenerarVale  :nEstacion,:tEmpresa,:tUsuario,:nSucursal,:tMoneda,:tTipo, :tCategoria, :tGrupo, :tFamilia, :tFechaD,:tFechaA<T>, EstacionTrabajo,Empresa,Usuario,Sucursal,POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.Moneda,POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.Tipo,POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.Categoria,POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.Grupo,POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.Familia,Info.FechaD,Info.FechaA)
EjecucionCondicion=ConDatos(POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.Moneda) y ConDatos(POSHerrCteFrecuenteG:POSHerrCteFrecuenteG.Tipo)
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

ConfirmarAntes=S
DialogoMensaje=POSEstaSeguro
[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S




[POSHerrCteFrecuenteG.POSHerrCteFrecuenteG.Categoria]
Carpeta=POSHerrCteFrecuenteG
Clave=POSHerrCteFrecuenteG.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[POSHerrCteFrecuenteG.POSHerrCteFrecuenteG.FechaD]
Carpeta=POSHerrCteFrecuenteG
Clave=POSHerrCteFrecuenteG.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[POSHerrCteFrecuenteG.POSHerrCteFrecuenteG.FechaA]
Carpeta=POSHerrCteFrecuenteG
Clave=POSHerrCteFrecuenteG.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20



[POSHerrCteFrecuenteG.POSHerrCteFrecuenteG.Grupo]
Carpeta=POSHerrCteFrecuenteG
Clave=POSHerrCteFrecuenteG.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSHerrCteFrecuenteG.POSHerrCteFrecuenteG.Familia]
Carpeta=POSHerrCteFrecuenteG
Clave=POSHerrCteFrecuenteG.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[POSHerrCteFrecuenteG.ListaEnCaptura]
(Inicio)=POSHerrCteFrecuenteG.Moneda
POSHerrCteFrecuenteG.Moneda=POSHerrCteFrecuenteG.Tipo
POSHerrCteFrecuenteG.Tipo=POSHerrCteFrecuenteG.Categoria
POSHerrCteFrecuenteG.Categoria=POSHerrCteFrecuenteG.Grupo
POSHerrCteFrecuenteG.Grupo=POSHerrCteFrecuenteG.Familia
POSHerrCteFrecuenteG.Familia=POSHerrCteFrecuenteG.FechaD
POSHerrCteFrecuenteG.FechaD=POSHerrCteFrecuenteG.FechaA
POSHerrCteFrecuenteG.FechaA=(Fin)










[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=(Fin)
