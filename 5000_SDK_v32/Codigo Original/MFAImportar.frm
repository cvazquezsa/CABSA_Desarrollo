
[Forma]
Clave=MFAImportar
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Exportar Información a MFA
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=533
PosicionInicialArriba=248
PosicionInicialAlturaCliente=193
PosicionInicialAncho=299

ListaAcciones=(Lista)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
ExpresionesAlMostrar=Asigna(Info.Empresa, Empresa)<BR>Asigna(Info.FechaD, Nulo)<BR>Asigna(Info.FechaA, Nulo)<BR>Asigna(Info.Ejercicio, Nulo)<BR>Asigna(Info.Periodo, Nulo)
[Acciones.Exportar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Exportar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=ProcesarSQL(<T>EXEC spMFALayoutEmpresaImportar :tUsuario, :tEmpresa, :nEjercicio, :nPeriodo, :tFechaD, :tFechaA<T>, Usuario, Info.Empresa, Info.Ejercicio, Info.Periodo, FechaFormatoServidor(Info.FechaD),FechaFormatoServidor(Info.FechaA))
[Acciones.Exportar]
Nombre=Exportar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Exportar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
ConfirmarAntes=S

[(Variables)]
Estilo=Ficha
PestanaOtroNombre=S
Clave=(Variables)
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
PermiteEditar=S

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Lista.Columnas]
Posicion=64
Tipo=106
ArticuloEsp=124
Pasillo=45
Nivel=37
Zona=64
Descripcion=130
Estatus=54





Empresa=71
Nombre=371

[(Variables).Info.Empresa]
Carpeta=(Variables)
Clave=Info.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Periodo]
Carpeta=(Variables)
Clave=Info.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[(Variables).ListaEnCaptura]
(Inicio)=Info.Empresa
Info.Empresa=Info.Ejercicio
Info.Ejercicio=Info.Periodo
Info.Periodo=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=(Fin)

[Acciones.Exportar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)

[Acciones.ExportarContabilidad]
Nombre=ExportarContabilidad
Boton=61
NombreEnBoton=S
NombreDesplegar=&Exportar Información Contable
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S





Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.ExportarContabilidad.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.ExportarContabilidad.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>EXEC spMFALayoutEmpresaCuentasImportar :tUsuario, :tEmpresa, :nEjercicio, :nPeriodo<T>, Usuario, Info.Empresa, Info.Ejercicio, Info.Periodo)
Activo=S
Visible=S

[Acciones.ExportarContabilidad.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)













[Forma.ListaAcciones]
(Inicio)=Exportar
Exportar=ExportarContabilidad
ExportarContabilidad=(Fin)
