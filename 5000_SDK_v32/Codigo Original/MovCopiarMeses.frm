[Forma]
Clave=MovCopiarMeses
Nombre=Copiar en el Tiempo
Icono=0
Modulos=(Todos)
CarpetaPrincipal=(Variables)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=777
PosicionInicialArriba=521
PosicionInicialAltura=318
PosicionInicialAncho=366
Comentarios=Lista(Info.Mov+<T> <T>+Info.MovID)
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=122
ListaCarpetas=(Variables)
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.FechaD, PrimerDiaMes(SiguienteMes(Hoy)))<BR>Asigna(Info.FechaA, PrimerDiaMes(SiguienteMes(Hoy)))<BR>Asigna(Info.TiempoUnidad, <T>meses<T>)

[Lista.CteEnviarA.Nombre]
Carpeta=Lista
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteEnviarA.Direccion]
Carpeta=Lista
Clave=CteEnviarA.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=65
NombreEnBoton=S
NombreDesplegar=&Generar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConfirmarAntes=S
DialogoMensaje=ConfirmarCopiaMultiple
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>Expresion<BR>Aceptar

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar y &Afectar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
ConfirmarAntes=S
DialogoMensaje=ConfirmarCopiaMultiple
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>Expresion<BR>Aceptar
ActivoCondicion=Usuario.Afectar y Usuario.AfectarLote

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
EspacioPrevio=S

[Lista.Columnas]
0=57
1=235

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spMovCopiarMeses :nSucursal, :tModulo, :nID, :tUsuario, :fFechaD, :fFechaA, 0, :tUnidad<T>,  Sucursal, Info.Modulo, Info.ID, Usuario, Info.FechaD, Info.FechaA, Info.TiempoUnidad)

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Afectar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spMovCopiarMeses :nSucursal, :tModulo, :nID, :tUsuario, :fFechaD, :fFechaA, 1, :tUnidad<T>,  Sucursal, Info.Modulo, Info.ID, Usuario, Info.FechaD, Info.FechaA, Info.TiempoUnidad)

[Acciones.Afectar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
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

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Afectar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[(Variables).Info.TiempoUnidad]
Carpeta=(Variables)
Clave=Info.TiempoUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Afectar
Afectar=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.TiempoUnidad
Info.TiempoUnidad=(Fin)
