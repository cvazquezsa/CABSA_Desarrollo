[Forma]
Clave=AfectarPartidasRemision
Nombre=Afectar.Mov+<T> <T>+Afectar.MovID
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialAltura=110
PosicionInicialAncho=246
PosicionInicialIzquierda=389
PosicionInicialArriba=325
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS
MovEspecificos=Todos
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=83

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
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
InicializarVariables=S

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.MovID]
Carpeta=(Variables)
Clave=Info.MovID
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Continuar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Continuar]
Nombre=Continuar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Continuar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Expresion
ListaAccionesMultiples=Variables Asignar<BR>SQL<BR>Cerrar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Continuar.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna(Info.ID, SQL(<T>SELECT ID FROM Venta WHERE Empresa = :tEmpresa AND Mov =:tMov AND MovID = :tMovID AND Estatus = :tEstatus<T>, Empresa, Info.Mov, Info.MovID, EstatusPendiente))<BR>EjecutarSQL(<T>spProcesarCBPreConciliar :nEstacion, :nID, :nGenerarID<T>, EstacionTrabajo, Info.ID, Afectar.ID)<BR>Forma(<T>VentaConciliar<T>)
EjecucionCondicion=ConDatos(Info.Mov) y ConDatos(Info.MovID)

[Acciones.Continuar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Continuar
Continuar=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Mov
Info.Mov=Info.MovID
Info.MovID=(Fin)
