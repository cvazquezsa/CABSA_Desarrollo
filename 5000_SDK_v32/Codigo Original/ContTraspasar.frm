[Forma]
Clave=ContTraspasar
Nombre=Traspasar Movimientos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=787
PosicionInicialArriba=461
PosicionInicialAltura=235
PosicionInicialAncho=346
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsMovimiento=S
TituloAuto=S
MovModulo=CONT
MovEspecificos=Todos
BarraHerramientas=S
PosicionInicialAlturaCliente=243
ExpresionesAlMostrar=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.Descripcion, <T>Contabilidad<T>)<BR>Asigna(Info.MovTipo, Nulo)<BR>Asigna(Info.CuentaD, Nulo)<BR>Asigna(Info.CuentaA, Nulo)<BR>Asigna(Info.CentroCostosD, Nulo)<BR>Asigna(Info.CentroCostosA, Nulo)<BR>Asigna(Info.NivelTraspaso, <T>Cuenta<T>)<BR>Asigna(Info.MovIDD, Nulo)<BR>Asigna(Info.MovIDA, Nulo)<BR>Asigna(Info.Ejercicio, EjercicioTrabajo)

[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=5
FichaEspacioNombres=59
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S

[(Variables).Info.CuentaD]
Carpeta=(Variables)
Clave=Info.CuentaD
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CuentaA]
Carpeta=(Variables)
Clave=Info.CuentaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CentroCostosD]
Carpeta=(Variables)
Clave=Info.CentroCostosD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CentroCostosA]
Carpeta=(Variables)
Clave=Info.CentroCostosA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=7
NombreDesplegar=&Ejecutar
Multiple=S
EnBarraAcciones=S
TipoAccion=Controles Captura
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

Antes=S
AntesExpresiones=Precaucion( <T>Esta Opción se Reemplazo, Favor de Comunicarse a Intelisis<T>)<BR> AbortarOperacion
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=<T>&Cancelar<T>
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[(Variables).Info.MovIDA]
Carpeta=(Variables)
Clave=Info.MovIDA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.MovIDD]
Carpeta=(Variables)
Clave=Info.MovIDD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.NivelTraspaso]
Carpeta=(Variables)
Clave=Info.NivelTraspaso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar.Confirmar]
Nombre=Confirmar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=Si(Confirmacion(Lista(<T>Traspasar Saldos:<T>,<T>  De la cuenta: <T>+Info.CuentaD+<T> a la cuenta: <T>+Info.CuentaA, Si(Info.NivelTraspaso<><T>Cuenta<T>,<T>  Del centro de costos: <T>+Info.CentroCostosD+<T> al centro de costos: <T>+Info.CentroCostosA),<T><T>,<T>Movimiento: <T>+Info.Mov,<T>  Del consecutivo: <T>+Info.MovIDD+<T> al consecutivo: <T>+Info.MovIDA,<T><T>,<T>¿ Esta seguro que desea continuar ?<T>), BotonNo, BotonSi)=BotonNo, AbortarOperacion)
EjecucionCondicion=ConDatos(Info.CuentaD) y ConDatos(Info.CuentaA) y <BR>ConDatos(Info.Mov) y <BR>ConDatos(Info.MovIDD) y ConDatos(Info.MovIDA)

[Acciones.Aceptar.Procesar]
Nombre=Procesar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>EXEC spContTraspasar :tEmpresa, :tCuentaD, :tCuentaA, :tSubCuentaD, :tSubCuentaA, :tMov, :tNivelTraspaso, :tMovIDD, :tMovIDA, :nEjercicio<T>, <BR>Empresa, Info.CuentaD, Info.CuentaA, Info.CentroCostosD, Info.CentroCostosA, Info.Mov, Info.NivelTraspaso, Info.MovIDD, Info.MovIDA, Info.Ejercicio)

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CtaInfoD]
Nombre=CtaInfoD
Boton=34
NombreEnBoton=S
NombreDesplegar=De la C&uenta
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>Expresion<BR>CtaInfo

[Acciones.CtaInfoD.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.CtaInfoD.CtaInfo]
Nombre=CtaInfo
Boton=0
TipoAccion=Formas
ClaveAccion=CtaInfo
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Info.Cuenta)

[Acciones.CtaInfoD.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Cuenta, Info.CuentaD)

[Acciones.CtaInfoA.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.CtaInfoA.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Cuenta, Info.CuentaA)
Activo=S
Visible=S

[Acciones.CtaInfoA.CtaInfo]
Nombre=CtaInfo
Boton=0
TipoAccion=Formas
ClaveAccion=CtaInfo
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Info.Cuenta)

[Acciones.CtaInfoA]
Nombre=CtaInfoA
Boton=34
NombreEnBoton=S
NombreDesplegar=A la Cuent&a
Multiple=S
EnBarraHerramientas=S
TipoAccion=Formas
ListaAccionesMultiples=Variables Asignar<BR>Expresion<BR>CtaInfo
Activo=S
Visible=S

[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[(Variables).ListaEnCaptura]
(Inicio)=Info.CuentaD
Info.CuentaD=Info.CuentaA
Info.CuentaA=Info.CentroCostosD
Info.CentroCostosD=Info.CentroCostosA
Info.CentroCostosA=Info.Mov
Info.Mov=Info.NivelTraspaso
Info.NivelTraspaso=Info.MovIDD
Info.MovIDD=Info.MovIDA
Info.MovIDA=Info.Ejercicio
Info.Ejercicio=(Fin)






[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Confirmar
Confirmar=Procesar
Procesar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=CtaInfoD
CtaInfoD=CtaInfoA
CtaInfoA=(Fin)
